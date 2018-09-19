xquery version "3.0"  encoding "UTF-8";
(:~
 : This module is the controller responsible for game board interactions
 :)
 
module namespace gc = "memory/src/controller/gameController";

import module namespace ch = "memory/src/controller/controllerHelper" at "controllerHelper.xqm";

(:~
 : This route creates a new game with the parameters selected by the user in the new game lobby page.
 : @return HTML page
 :)
declare
    %rest:path("/createGame")
    %rest:POST("{$body}")
    function gc:createGame($body)
{
    let $pathToCreate := "/model/game/create"
    let $pathToSave := "/model/database/createGame"
    let $game := ch:callModelFunction("post", $pathToCreate, $body)[2]
    let $gameId := $game/game/@id/data()
    let $redirection := "/game/" || $gameId
    let $response := ch:callModelFunction("post", $pathToSave, $game)
    return web:redirect($redirection)
};

declare
    %rest:path("/game/{$gameId}")
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function gc:createGamePage($gameId as xs:string)
{   
    let $xsltPath := "../model/xslt/stateToHTML.xsl"
    let $getGamePath := "/model/database/getGame/" || $gameId
    let $game := ch:callModelFunction("get", $getGamePath, ())[2]
    let $body := xslt:transform($game, $xsltPath)
    let $head := doc("../views/lobbyHeader.xml")
    return ch:buildHTML($head, $body)
};

declare
    %rest:path("/game/{$gameId}/revealCard/{$cardId}")
    %rest:GET
    function gc:revealCard($gameId as xs:string, $cardId as xs:string)
{   
    let $redirection := "/game/" || $gameId
    let $handleRevealPath := "/model/" || $gameId || "/revealCard/" || $cardId
    let $replaceGamePath := "/model/database/replaceGame"
    let $updatedGame := ch:callModelFunction("post", $handleRevealPath, ())[2]
    let $replaceResponse := ch:callModelFunction("post", $replaceGamePath, $updatedGame)[2]
    return web:redirect($redirection)
}; 