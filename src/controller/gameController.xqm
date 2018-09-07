xquery version "3.0"  encoding "UTF-8";
(:~
 : This module is the controller responsible for all basic game interactions
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
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function gc:createGame($body)
{
    $body
}; 