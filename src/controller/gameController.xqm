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
    %output:method("html")
    %output:version("5.0")
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
    %output:method("html")
    %output:version("5.0")
    function gc:createGamePage($gameId as xs:string)
{   
    let $xsltPath := "../model/xslt/stateToHTML.xsl"
    let $getGamePath := "/model/database/getGame/" || $gameId
    let $game := ch:callModelFunction("get", $getGamePath, ())[2]
    let $body := xslt:transform($game, $xsltPath)
    let $head := doc("../views/gameHeader.xml")
    return ch:buildHTML($head, $body)
};

declare
    %rest:path("/game/{$gameId}/revealCard/{$cardId}")
    %rest:GET
    %output:method("html")
    %output:version("5.0")
    function gc:revealCard($gameId as xs:string, $cardId as xs:string)
{   
    let $redirection := "/game/" || $gameId
    let $handleRevealPath := "/model/" || $gameId || "/revealCard/" || $cardId
    let $replaceGamePath := "/model/database/replaceGame"
    let $updatedGame := ch:callModelFunction("post", $handleRevealPath, ())[2]
    let $replaceResponse := ch:callModelFunction("post", $replaceGamePath, $updatedGame)[2]
    return web:redirect($redirection)
};

declare
    %rest:path("/game/load")
    %rest:POST("{$body}")
    %output:method("html")
    %output:version("5.0")
    function gc:loadGame($body)
{
    let $gameId := $body/loadGame/gameId/text() 
    let $getSavedGamePath := "/model/database/getSavedGame/" || $gameId
    let $savedGame := ch:callModelFunction("get", $getSavedGamePath, ())[2]/savedGame
    let $passwordMatches := xs:boolean($savedGame/gamePassword/text() = $body/loadGame/password/text())
    let $dummy := 
        if ($passwordMatches) then
            gc:activateSavedGame($savedGame)
        else ()
    let $redirection := 
        if ($passwordMatches) then
            "/game/" || $gameId
        else
            "/menu"
    return web:redirect($redirection)
};

declare %private
    function gc:activateSavedGame($savedGame as element(savedGame))
{
    let $gameId := string($savedGame/game/@id)
    let $redirection := "/game/" || $gameId
    let $insertRunningPath := "/model/database/createGame"
    let $deletePath := "/model/database/deleteSavedGame/" || $gameId
    let $insertResponse := ch:callModelFunction("post", $insertRunningPath, $savedGame/game)
    let $deleteResponse := ch:callModelFunction("post", $deletePath, ())
    return ()
};