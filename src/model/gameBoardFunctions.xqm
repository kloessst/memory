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
    let $dummy := prof:variables()
    let $newGame := gbf:alterGameByPhase($game, $cardId)
    return $newGame
};

declare %private
    function gbf:alterGameByPhase($game as element(game), $cardId as xs:string) as element(game)
{
    let $phase := $game/gameState/phase
    let $newGame := 
        if ($phase = "0") then
            gbf:handleRevealPhase0($game, $cardId)
        else if ($phase = "1") then
            gbf:handleRevealPhase0($game, $cardId)
        else 
            gbf:handleRevealPhase0($game, $cardId)
    return $newGame
};

declare %private
    function gbf:handleRevealPhase0($game as element(game), $cardId as xs:string) as element(game)
{
    let $newGameBoard := gbf:revealCard($game/gameBoard, $cardId)
    return 
        $game transform with {
            replace node gameBoard with $newGameBoard
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
    function gbf:alterGamestate($phase as xs:string,  $gameState as element(gameState), $cardId as xs:string) 
    as element(gameState)
{
   let $guessPhase := (xs:int($phase) + 1) mod 3
   let $state := 
        if ($phase = "0" or $phase = "1") then
            $gameState/state
        else
            $gameState/state
   let $firstGuess := 
        if ($phase = "0") then
            $cardId
        else
            $gameState/firstGuess
   let $secondGuess := 
        if ($phase = "1") then
            $cardId
        else
            $gameState/secondGuess
   return 
        $gameState transform with {
            replace node state with $state,
            replace node firstGues with $firstGuess,
            replace node secondGuess with $secondGuess
        }
};

