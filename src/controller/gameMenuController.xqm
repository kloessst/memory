xquery version "3.0"  encoding "UTF-8";
(:~
 : This module controls the ingame menu interactions
 :)
 
module namespace gmc = "memory/src/controller/gameMenuController";

import module namespace ch = "memory/src/controller/controllerHelper" at "controllerHelper.xqm";

(:~
 : This route saves a running game. The whole gamestate is saved together with a name and a password,
 : which is needed to run the game again.
 : @return redirects to primary game page
 :)
declare
    %rest:path("/gameMenu/saveGame")
    %rest:POST
    %rest:form-param("gameId","{$gameId}")
    %rest:form-param("gameName","{$gameName}", "defaultName")
    %rest:form-param("gamePassword","{$gamePassword}")
    function gmc:saveGame($gameId as xs:string, $gameName as xs:string, $gamePassword as xs:string)
{
    let $saveGamePath := "/model/gameMenu/saveGame"
    let $redirection := "/game/" || $gameId
    let $savedGameData := gmc:savedGameParamsToXML($gameId, $gameName, $gamePassword)
    let $game := ch:callModelFunction("post", $saveGamePath, $savedGameData)[2]/game
    return web:redirect($redirection)
};

declare %private
    function gmc:savedGameParamsToXML($gameId as xs:string, $gameName as xs:string, $gamePassword as xs:string) 
    as element(savedGameData)
{
    <savedGameData>
        <gameId>{$gameId}</gameId>
        <gameName>{$gameName}</gameName>
        <gamePassword>{$gamePassword}</gamePassword>
    </savedGameData>
};

declare
    %rest:path("/gameMenu/exit")
    %rest:POST
    %rest:form-param("gameId","{$gameId}")
    function gmc:exitGame($gameId as xs:string)
{
    let $deleteGamePath := "/model/database/deleteGame/" || $gameId
    let $redirection := "/menu"
    let $dummy := ch:callModelFunction("post", $deleteGamePath, ())[2]
    return web:redirect($redirection)
};