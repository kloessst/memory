xquery version "3.0"  encoding "UTF-8";

module namespace dbf = "memory/src/model/databaseFunctions";

declare variable $dbf:dbName := doc("../database/config.xml")/dbConfig/dbName/text();
declare variable $dbf:gamesPath := doc("../database/config.xml")/dbConfig/dbGamesTemplate/@path;
declare variable $dbf:highscoresPath := doc("../database/config.xml")/dbConfig/dbHighscoresTemplate/@path;
declare variable $dbf:gamesTemplate := doc("../database/config.xml")/dbConfig/dbGamesTemplate/games;
declare variable $dbf:highscoresTemplate := doc("../database/config.xml")/dbConfig/dbHighscoresTemplate/highscores;

(:
 : REST API for functions initializing/deleting the database. Creates games and highscores container files
 : using the database config file. Contains functions to clear parts or the whole database.
 :)

declare
    %rest:path("/model/database/init")
    %rest:POST
    %updating
function dbf:initDatabase() {
    if (db:exists($dbf:dbName)) then
        ()
    else 
        db:create($dbf:dbName, ($dbf:gamesTemplate, $dbf:highscoresTemplate), ($dbf:gamesPath, $dbf:highscoresPath))
};

declare
    %rest:path("/model/database/drop")
    %rest:POST
    %updating
function dbf:dropDatabase() {   
    db:drop($dbf:dbName)
};