xquery version "3.0"  encoding "UTF-8";
(:~
 : This module controls the ingame menu interactions
 :)
 
module namespace gmc = "memory/src/controller/gameMenuController";

import module namespace ch = "memory/src/controller/controllerHelper" at "controllerHelper.xqm";

(:~
 : This route saves a running game. The whole gamestate is saved together with a name and a password
 : which is needed to run the game again
 : @return HTML page
 :)
declare
    %rest:path("/game/save")
    %rest:POST("{$body}")
    function gmc:saveGame($body)
{
    let $saveGamePath := "/model/game/save"
    let $game := ch:callModelFunction("post", $saveGamePath, $body)[2]
    return ""
};