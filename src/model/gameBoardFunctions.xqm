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
    function gbf:handleCardReveal($body as element(game), $cardId as xs:string)
{
    let $phase := $body/gameState/phase
    let $newGameState := gbf:alterGame($body/game/gameState, $cardId)
    return $body
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
    let $newGameState := gbf:alterGamestate("0", $game/gameState, $cardId)
    return $game
};

declare %private
    function gbf:alterGamestate($phase as xs:string,  $gameState as element(gameState), $cardId as xs:string) 
    as element(gameState)
{
   let $running := 1
   return $gameState
};

