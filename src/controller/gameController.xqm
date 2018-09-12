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
    %rest:path("/game/{$id}")
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function gc:createGamePage($id as xs:string)
{   
    let $xsltPath := "../model/xslt/stateToHTML.xsl"
    let $getGamePath := "/model/database/getGame/" || $id
    let $game := ch:callModelFunction("get", $getGamePath, ())[2]
    return xslt:transform($game, $xsltPath)
};

declare
    %rest:path("/game/{$gameId}/revealCard/{$cardId}")
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function gc:revealCard($gameId as xs:string, $cardId as xs:int)
{   
    let $handleRevealPath := "../model/xslt/stateToHTML.xsl"
    let $getGamePath := "/model/database/getGame/" || $gameId
    let $game := ch:callModelFunction("get", $getGamePath, ())[2]
    let $updatedGame := ch:callModelFunction("get", $handleRevealPath, $game)[2]
    return $updatedGame
}; 