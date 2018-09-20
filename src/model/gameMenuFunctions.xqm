xquery version "3.0"  encoding "UTF-8";

module namespace gmf = "memory/src/model/gameMenuFunctions";

import module namespace ch = "memory/src/controller/controllerHelper" at "../controller/controllerHelper.xqm";

(:
 : REST API and functions responsible for handling the interactions with the ingame menu
 :)
 
declare
    %rest:path("model/gameMenu/saveGame")
    %rest:POST("{$body}")
    function gmf:saveGame($body)
{
    let $getGamePath := "/model/database/getGame/" || $body/savedGameData/gameId
    let $insertSavedGamePath := "/model/database/createSaveGame"
    let $game := ch:callModelFunction("get", $getGamePath, ())[2]/game
    let $savedGame := gmf:createSaveGameData($body/savedGameData, $game)
    let $saveResponse := ch:callModelFunction("post", $insertSavedGamePath, $savedGame)
    return ""
};

declare %private
    function gmf:createSaveGameData($savedGameData as element(savedGameData), $game as element(game)) 
    as element(savedGame)
{
    <savedGame>
        <gameName>
            {$savedGameData/gameName/text()}
        </gameName>
        <gamePassword>
            {$savedGameData/gamePassword/text()}
        </gamePassword>
        <date>
            {current-dateTime()}
        </date>
        {$game}
    </savedGame>
};