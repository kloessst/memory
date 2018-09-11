xquery version "3.0"  encoding "UTF-8";

module namespace dbf = "memory/src/model/databaseFunctions";

declare variable $dbf:dbName := "memoryDB";
declare variable $dbf:gamesPath := "games.xml";
declare variable $dbf:highscoresPath := "highscores.xml";
declare variable $dbf:gamesTemplate := doc("../database/config.xml")/dbConfig/dbGamesTemplate/games;
declare variable $dbf:highscoresTemplate := doc("../database/config.xml")/dbConfig/dbHighscoresTemplate/highscores;

declare variable $dbf:games := db:open("memoryDB", "games.xml")/games;
declare variable $dbf:higscores := db:open($dbf:dbName, $dbf:highscoresPath)/highscores;

(:
 : REST API for functions initializing/deleting the database. Creates games and highscores container files
 : using the database config file. Contains functions interacting with the database.
 :)

declare
    %rest:path("/model/database/init")
    %rest:POST
    %updating
    function dbf:initDatabase() 
{
    if (db:exists($dbf:dbName)) then
        ()
    else 
        db:create($dbf:dbName, ($dbf:gamesTemplate, $dbf:highscoresTemplate), ($dbf:gamesPath, $dbf:highscoresPath))
};

declare
    %rest:path("/model/database/drop")
    %rest:POST
    %updating
    function dbf:dropDatabase() 
{   
    db:drop($dbf:dbName)
};

declare
    %rest:path("/model/database/getGame/{$id}")
    %rest:GET
    function dbf:dropDatabase($id as xs:string) 
{   
    $dbf:games/game[@id = $id]
};

declare
    %rest:path("/model/database/createGame")
    %rest:POST("{$body}")
    %updating
    function dbf:createGame($body)
{   
    insert node $body as last into $dbf:games
};

declare 
    function dbf:gameIdExists($id as xs:string) as xs:boolean 
{   
    if (count($dbf:games/game[@id = $id]) > 0) then
        true()
    else
        false()
};