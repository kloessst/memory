xquery version "3.0"  encoding "UTF-8";

module namespace dbf = "memory/src/model/databaseFunctions";

declare variable $dbf:dbName := "memoryDB";
declare variable $dbf:gamesPath := "games.xml";
declare variable $dbf:highscoresPath := "highscores.xml";
declare variable $dbf:savedGamesPath := "savedGames.xml";
declare variable $dbf:gamesTemplate := doc("../database/config.xml")/dbConfig/dbGamesTemplate/games;
declare variable $dbf:highscoresTemplate := doc("../database/config.xml")/dbConfig/dbHighscoresTemplate/highscores;
declare variable $dbf:savedGamesTemplate := doc("../database/config.xml")/dbConfig/dbSavedGamesTemplate/savedGames;

declare variable $dbf:games := db:open("memoryDB", "games.xml")/games;
declare variable $dbf:higscores := db:open($dbf:dbName, $dbf:highscoresPath)/highscores;
declare variable $dbf:savedGames := db:open("memoryDB", "savedGames.xml")/savedGames;

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
        db:create($dbf:dbName, ($dbf:gamesTemplate, $dbf:highscoresTemplate, $dbf:savedGamesTemplate), ($dbf:gamesPath, $dbf:highscoresPath, $dbf:savedGamesPath))
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
    function dbf:getGame($id as xs:string) 
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
    %rest:path("/model/database/replaceGame")
    %rest:POST("{$body}")
    %updating
    function dbf:replaceGame($body)
{   
    let $gameId := $body/game/@id
    return replace node $dbf:games/game[@id = $gameId] with $body/game
};

declare
    %rest:path("/model/database/createSaveGame")
    %rest:POST("{$body}")
    %updating
    function dbf:saveGame($body)
{   
    insert node $body as first into $dbf:savedGames
};

declare
    %rest:path("/model/database/getAllSavedGames")
    %rest:GET
    function dbf:getAllSavedGames()
{   
    $dbf:savedGames
};

declare
    %rest:path("/model/database/getSavedGame/{$id}")
    %rest:GET
    function dbf:getSavedGame($id as xs:string) 
{   
    $dbf:savedGames/savedGame[game/@id = $id]
};

declare
    %rest:path("/model/database/deleteSavedGame/{$id}")
    %rest:POST
    %updating
    function dbf:deleteSavedGame($id as xs:string) 
{   
    delete node $dbf:savedGames/savedGame[game/@id = $id]
};

declare
    %rest:path("/model/database/gameIdExists/{$id}")
    %rest:GET
    function dbf:gameIdExists($id as xs:string)
{   
    if (count($dbf:games/game[@id = $id]) > 0 or count($dbf:savedGames/savedGame/game[@id = $id]) > 0) then
        <boolean>{true()}</boolean>
    else
        <boolean>{false()}</boolean>
};

declare
    %rest:path("/model/database/getHighscore/{$numberOfCards}")
    %rest:GET
    function dbf:getGame($numberOfCards)
{
    $dbf:games/game/[@numberOfCards = $numberOfCards]
};