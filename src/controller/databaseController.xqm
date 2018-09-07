xquery version "3.0"  encoding "UTF-8";

(:~
 : This controller contains the routes to handle the database initialization and deletion
 :)
 
module namespace dbc = 'memory/src/controller/databaseController';

import module namespace ch = "memory/src/controller/controllerHelper" at "controllerHelper.xqm";
import module namespace rest = "http://exquery.org/ns/restxq";

(:~
 : Initializes the database. Creates games and highscores container files
 : @return launch HTML page
 :)
declare
    %rest:path("/database/init")
    %rest:GET
    function dbc:initDatabase()
{   
    let $path := "/model/database/init"
    let $redirection := "/"
    let $result := ch:callModelFunction("post", $path, ())
    return 
        if (fn:string($result/@status) = "200") then
            web:redirect($redirection)
        else 
            ()
};