xquery version "3.0"  encoding "UTF-8";

module namespace hf = "memory/src/model/gameMenuFunctions";

import module namespace ch = "memory/src/controller/controllerHelper" at "../controller/controllerHelper.xqm";

(:
 : REST API and functions responsible for creating and reading highscores
 :)
 
declare variable $hf:highscoreLimit := 20;

declare
    %rest:path("model/highscore/save")
    %rest:POST("{$body}")
    function hf:saveHighscores($body)
{
    let $numberOfCards := string($body/game/@numberOfCards)
    let $scores := hf:scoresToHighscoresFormat($body/game/players, $numberOfCards)
    let $getHighscoresPath := "/model/database/highscores/" || $numberOfCards
    let $highscores := ch:callModelFunction("get", $getHighscoresPath, ())[2]/highscores
    let $newHighscores := hf:determineBestScores($highscores, $scores)
    let $deleteHighscoresPath := "/model/database/deleteHighscores/" || $numberOfCards
    let $insertHighscoresPath := "/model/database/insertHighscores"
    let $res1 := ch:callModelFunction("post", $deleteHighscoresPath, ())
    let $res2 := ch:callModelFunction("post", $insertHighscoresPath, $newHighscores)
    return $newHighscores
};

declare %private
    function hf:scoresToHighscoresFormat($players as element(players), $numberOfCards as xs:string) as element(highscores)
{   
    <highscores>{
    for $p in $players/player
        return
            <highscore numberOfCards="{$numberOfCards}">
                <player>{$p/username/text()}</player>
                <score>{$p/score/text()}</score>
                <date>{current-dateTime()}</date>
            </highscore>
    }</highscores>
};

declare %private
    function hf:determineBestScores($highscores as element(highscores), $scores as element(highscores)) 
    as element(highscores)
{   
    let $combinedScores := 
        <highscores>
            {$highscores}
            {$scores}
        </highscores>
    return
        <highscores>{
            (for $s in $combinedScores//highscore
                where $s/score > 0
                order by $s/score descending
                return $s)[position() le $hf:highscoreLimit]
        }</highscores>
};

declare
    %rest:path("model/highscore/{$numberOfCards}")
    %rest:GET
    function hf:getHighscores($numberOfCards as xs:string)
{
    ""
};