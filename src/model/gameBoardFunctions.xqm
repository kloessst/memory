xquery version "3.1"  encoding "UTF-8";

(:~
 : This module handles the game logic. It alters the gamestate according to the interaction and issues database 
 : updates
 :)

module namespace gbf = "memory/src/model/gameBoardFunctions";

import module namespace dbf = "memory/src/model/databaseFunctions" at "databaseFunctions.xqm";
import module namespace ch = "memory/src/controller/controllerHelper" at "../controller/controllerHelper.xqm";

declare
    %rest:path("/model/{$gameId}/revealCard/{$cardId}")
    %rest:POST
    function gbf:handleCardReveal($gameId as xs:string, $cardId as xs:string)
{
    let $getGamePath := "/model/database/getGame/" || $gameId
    let $game := ch:callModelFunction("get", $getGamePath, ())[2]/game
    let $newGame := gbf:alterGameByPhase($game, $cardId)
    return $newGame
};

declare %private
    function gbf:alterGameByPhase($game as element(game), $cardId as xs:string) as element(game)
{
    let $phase := $game/gameState/guessPhase
    let $newGame := 
        if ($phase = "0") then
            gbf:handleFirstGuess($game, $cardId)
        else if ($phase = "1") then
            gbf:handleSecondGuess($game, $cardId)
        else 
            gbf:handlePlayerSwitch($game)
    return $newGame
};

declare %private
    function gbf:handleFirstGuess($game as element(game), $cardId as xs:string) as element(game)
{
    let $newGameBoard := gbf:revealCard($game/gameBoard, $cardId)
    let $newGameState := gbf:updateStateFirstGuess($game/gameState, $cardId)
    return 
        $game transform with {
            replace node gameBoard with $newGameBoard,
            replace node gameState with $newGameState
        }
};

declare %private
    function gbf:handleSecondGuess($game as element(game), $cardId as xs:string) as element(game)
{   
    let $pairFound := gbf:isPairFound($game, $cardId)
    return 
        if ($pairFound) then
            gbf:handleSecondGuessSuccess($game, $cardId)
        else
            gbf:handleSecondGuessFail($game, $cardId)
};

declare %private
    function gbf:handleSecondGuessSuccess($game as element(game), $cardId as xs:string) as element(game)
{
    let $gameBoardRevealed := gbf:revealCard($game/gameBoard, $cardId)
    let $gameBoardSolved := gbf:solveCards($gameBoardRevealed, $cardId)
    let $playersScoreUpdated := gbf:updatePlayerScore($game/players)
    let $newGameState :=  gbf:updateStateSecondGuessSuccess($game)
    return 
        $game transform with {
            replace node gameBoard with $gameBoardSolved,
            replace node players with $playersScoreUpdated,
            replace node gameState with $newGameState
        }
};

declare %private
    function gbf:handleSecondGuessFail($game as element(game), $cardId as xs:string) as element(game)
{
    let $gameBoardRevealed := gbf:revealCard($game/gameBoard, $cardId)
    let $newGameState :=  gbf:updateStateSecondGuessFail($game/gameState, $cardId)
    return 
        $game transform with {
            replace node gameBoard with $gameBoardRevealed,
            replace node gameState with $newGameState
        }
};

declare %private
    function gbf:handlePlayerSwitch($game as element(game)) as element(game)
{
    let $switchedPlayers := gbf:switchPlayers($game/players)
    let $hiddenCardsGameBoard := gbf:hideRevealedCards($game/gameBoard)
    let $resettedGameState := gbf:resetGameState($game/gameState)
    return 
        $game transform with {
            replace node gameBoard with $hiddenCardsGameBoard,
            replace node players with $switchedPlayers,
            replace node gameState with $resettedGameState
        }
};

declare %private
    function gbf:revealCard($gameBoard as element(gameBoard), $cardId as xs:string) 
    as element(gameBoard)  
{
    $gameBoard transform with {
        replace value of node cards/card[@id = $cardId]/@revealed with true()
    }
};

declare %private
    function gbf:updateStateFirstGuess($gameState as element(gameState), $cardId as xs:string) 
    as element(gameState)
{
    $gameState transform with {
        replace value of node firstGuess with $cardId,
        replace value of node guessPhase with "1"
    }
};

declare %private
    function gbf:updateStateSecondGuessSuccess($game as element(game)) 
    as element(gameState)
{
    let $newState := gbf:checkForFinish($game/gameBoard/cards)
    return $game/gameState transform with {
        replace value of node state with $newState,
        replace value of node guessPhase with "0",
        replace value of node firstGuess with ""
    }
};

declare %private
    function gbf:updateStateSecondGuessFail($gameState as element(gameState), $cardId as xs:string) 
    as element(gameState)
{
    $gameState transform with {
        replace value of node secondGuess with $cardId,
        replace value of node guessPhase with "2"
    }
};

declare %private
    function gbf:resetGameState($gameState as element(gameState)) as element(gameState)
{
    $gameState transform with {
        replace value of node firstGuess with "",
        replace value of node secondGuess with "",
        replace value of node guessPhase with 0
    }
};

declare %private
    function gbf:isPairFound($game as element(game), $secondGuess as xs:string) 
    as xs:boolean
{
    let $firstGuess := $game/gameState/firstGuess
    let $firstGuessPairId := $game/gameBoard/cards/card[@id = $firstGuess]/@pairId
    let $secondGuessPairId := $game/gameBoard/cards/card[@id = $secondGuess]/@pairId
    return $firstGuessPairId = $secondGuessPairId
};

declare %private
    function gbf:solveCards($gameBoard as element(gameBoard), $cardId as xs:string) 
    as element(gameBoard)
{
    let $solvedPairId := $gameBoard/cards/card[@id = $cardId]/@pairId
    return $gameBoard transform with {
        for $solvedCard in cards/card[@pairId = $solvedPairId]
        return replace value of node $solvedCard/@solved with true()
    }
};

declare %private
    function gbf:updatePlayerScore($players as element(players)) 
    as element(players)
{
    let $oldScore := $players/player[@active = true()]/score
    return $players transform with {
        replace value of node player[@active = true()]/score with xs:int($oldScore) + 10
    }
};

declare %private
    function gbf:checkForFinish($cards as element(cards)) as xs:string
{
    let $numberOfCards := count($cards/card)
    let $numOfSolvedCards := count($cards/card[@solved = true()])   
    return 
        if ($numOfSolvedCards + 2 = $numberOfCards) then
            "finished"
        else
            "running"
};

declare %private
    function gbf:switchPlayers($players as element(players)) as element(players)
{
    let $numberOfPlayers := count($players/player)
    let $oldActivePlayerPos := count($players/player[@active = true()]/preceding-sibling::*) + 1
    let $newActivePlayerPos := ($oldActivePlayerPos mod $numberOfPlayers) + 1
    return 
        if ($numberOfPlayers = 1) then
            $players
        else
            $players transform with {
                replace value of node player[$oldActivePlayerPos]/@active with false(),
                replace value of node player[$newActivePlayerPos]/@active with true()
            }
};

declare %private
    function gbf:hideRevealedCards($gameBoard as element(gameBoard)) as element(gameBoard)
{
    $gameBoard transform with {
        for $revealedCard in cards/card[@revealed = true() and @solved = false()]
        return replace value of node $revealedCard/@revealed with false()
    }
};