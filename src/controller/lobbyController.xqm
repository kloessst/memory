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
    function lc:main()
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
    %rest:path("/create-game")
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
    %rest:path("/load-game")
    %rest:GET
    function lc:loadGame()
{
    doc("../views/loadGameXForms.xml")
};

declare
    %rest:path("/highscore")
    %rest:GET
    %output:method("html")
    %output:version("5.0")
    function lc:highscore()
{
    let $head := doc("../views/lobbyHeader.xml")
    let $body := doc("../views/highscore.xml")
    return ch:buildHTML($head, $body)
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

