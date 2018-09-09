xquery version "3.0"  encoding "UTF-8";
(:~
 : This controller contains the routes to handle the database initialization and deletion
 :)
 
module namespace dbc = "memory/src/controller/databaseController";

import module namespace ch = "memory/src/controller/controllerHelper" at "controllerHelper.xqm";

(:~
 : Initializes the database. Creates games and highscores container files
 : @return launch HTML page if db was initialized
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
            (<failedToInitDB></failedToInitDB>)
};

(:~
 : Drops the database
 : @return ()
 :)
declare
    %rest:path("/database/drop")
    %rest:GET
    function dbc:dropDatabase()
{   
    let $path := "/model/database/drop"
    let $result := ch:callModelFunction("post", $path, ())
    return <Dropped></Dropped>
};