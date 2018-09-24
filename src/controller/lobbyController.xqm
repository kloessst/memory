xquery version "3.0"  encoding "UTF-8";
(:~
 : This module contains the routes to navigate the lobby
 :)

module namespace lc = "memory/src/controller/lobbyController";

import module namespace ch = "memory/src/controller/controllerHelper" at "controllerHelper.xqm";

(:~
 : Returns the mainpage
 : @return HTML page
 :)
declare
    %rest:path("/")
    %rest:GET
    %output:method("html")
    %output:version("5.0")
    function lc:start()
{
    let $head := doc("../views/lobbyHeader.xml")
    let $body := doc("../views/start.xml")
    return ch:buildHTML($head, $body)
}; 

(:~
 : Returns the menu
 : @return HTML page
 :)
declare
    %rest:path("/menu")
    %rest:GET
    %output:method("html")
    %output:version("5.0")
    function lc:menu()
{
    let $head := doc("../views/lobbyHeader.xml")
    let $body := doc("../views/mainMenu.xml")
    return ch:buildHTML($head, $body)
};

(:~
 : Returns the create a new game site
 : @return HTML page
 :)
declare
    %rest:path("/createGame")
    %rest:GET
    function lc:createGame()
{
    doc("../views/createGameXForms.xml")
};

(:~
 : Returns the load a game site
 : @return HTML page
 :)
declare
    %rest:path("/loadGame")
    %rest:GET
    function lc:loadGame()
{
    doc("../views/loadGameXForms.xml")
};

declare
    %rest:path("/getHighscores/{$numberOfCards}")
    %rest:GET
    function lc:getHighscores($numberOfCards)
{
    ""
};

declare
    %rest:path("/savedGames")
    %rest:GET
    function lc:getSavedGames()
{
    let $getSavedGamesPath := "/model/database/getAllSavedGames"
    let $savedGames := ch:callModelFunction("get", $getSavedGamesPath, ())[2]/savedGames 
    return lc:createSaveGameList($savedGames)
};

declare
    %private
    function lc:createSaveGameList($savedGames as element(savedGames))
    as element(savedGamesList)
{
    <savedGamesList>{
        for $sGame in $savedGames/savedGame
            let $gameId := string($sGame/game/@id)
            let $gameName := $sGame/gameName
            let $date := $sGame/date
            return
                <savedGame>
                    <gameId>{$gameId}</gameId>
                    {$gameName}
                    {$date}
                </savedGame>
        }
        <loadGame>
            <gameId/>
            <password/>
        </loadGame>
    </savedGamesList>    
};

