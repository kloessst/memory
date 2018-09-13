xquery version "3.1"  encoding "UTF-8";

(:~
 : This module handles the game logic. It alters the gamestate according to the interaction and issues database 
 : updates
 :)

module namespace gbf = "memory/src/model/gameBoardFunctions";

import module namespace dbf = "memory/src/model/databaseFunctions" at "databaseFunctions.xqm";
import module namespace ch = "memory/src/controller/controllerHelper" at "../controller/controllerHelper.xqm";

declare
    %rest:path("/model/game/revealCard/{$cardId}")
    %rest:POST("{$body}")
    function gbf:handleCardReveal($body, $cardId as xs:string)
{
    $body/game/gameState/phase
};

declare %private
    function gbf:alterGame($game as element(game), $cardId as xs:string) as element(game)
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
    let $newGameBoard := gbf:alterGameBoard("0", $game/gameState, $cardId)
    let $newGameState := gbf:alterGamestate("0", $game/gameState, $cardId)
    return $game
};

declare %private
    function gbf:alterGameBoard($phase as xs:string,  $gameBoard as element(gameBoard), $cardId as xs:string) 
    as element(gameBoard)
{

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
        $gameState update {
            replace node state with $state
        } update {
            replace node firstGues with $firstGuess
        } update {
            replace node secondGuess with $secondGuess
        } 
};

