xquery version "3.0"  encoding "UTF-8";
(:~
 : This module controls the ingame menu interactions
 :)
 
module namespace gmc = "memory/src/controller/gameMenuController";

import module namespace ch = "memory/src/controller/controllerHelper" at "controllerHelper.xqm";

(:~
 :  
 :)
declare
    %rest:path("....")
    %rest:POST()
    function gmc:createGame()
{
}; 