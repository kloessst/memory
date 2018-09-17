xquery version "3.1"  encoding "UTF-8";

module namespace gco = "memory/src/model/gameConstructor";

import module namespace dbf = "memory/src/model/databaseFunctions" at "databaseFunctions.xqm";
import module namespace ch = "memory/src/controller/controllerHelper" at "../controller/controllerHelper.xqm";
import module namespace map = "http://www.w3.org/2005/xpath-functions/map";
import module namespace hash = "http://basex.org/modules/hash";
import module namespace random = "http://basex.org/modules/random";

declare variable $gco:cardsToBoardLayout := map {
    12: (3,4), 20: (4,5), 28: (4, 7)
};

declare variable $gco:numberOfCardGraphics := count(doc("../../static/svgs/cardSet.xml")//card);

(:
 : REST API and functions for creating the game in the database
 :)

declare
    %rest:path("/model/game/create")
    %rest:POST("{$body}")
    function gco:createGame($body) as element(game)
{
    let $numberOfCards := $body//numberOfCards/text()
    let $numberOfPlayers := $body//numberOfPlayers/text()
    let $key := string-join($body//player/text())
    let $id := gco:createUniqueGameId($key)
    let $players := gco:createPlayers($body//players)
    let $gameState := gco:createGameState()
    let $gameBoard := gco:createGameBoard($numberOfCards)
    let $game := gco:createGame($id, $gameState, $gameBoard, $players, $numberOfPlayers, $numberOfCards)
    return $game
};

declare %private
    function gco:createUniqueGameId($message as xs:string) as xs:string
{
    let $hash := string(xs:hexBinary(hash:md5($message)))
    return 
        if (dbf:gameIdExists($hash)) then
            gco:createUniqueGameId($hash || random:integer())
        else
            $hash
};

declare %private
    function gco:createGame($id as xs:string, $gameState as element(gameState), $gameBoard as element(gameBoard), $players as element(players),
        $numberOfPlayers as xs:int, $numberOfCards as xs:int)
    as element(game)
{   
    <game id="{$id}" numberOfPlayers="{$numberOfPlayers}" numberOfCards="{$numberOfCards}">
        {$gameState}
        {$players}
        {$gameBoard}
    </game>
};

declare %private
    function gco:createPlayers($players as element(players)) as element(players)
{
    <players>{
        for $player at $count in $players/player
            let $username := $player/text()
            let $active := 
                if ($count = 1) then
                    true()
                else
                    false()
            return 
                <player id="{$count}" active="{$active}">
                    <username>{$username}</username>
                    <score>0</score>
                </player>
    }</players>       
};

declare %private
    function gco:createGameState() as element(gameState)
{
    <gameState>
        <state>running</state>
        <guessPhase>0</guessPhase>
        <firstGuess></firstGuess>
        <secondGuess></secondGuess>
    </gameState>
};

declare %private
    function gco:createGameBoard($numberOfCards as xs:int) as element(gameBoard)
{
    let $cards := gco:createCards($numberOfCards)
    let $boardRows := gco:getRowsForCardCount($numberOfCards)
    let $boardColumns := gco:getColumnsForCardCount($numberOfCards)
    return 
        <gameBoard rows="{$boardRows}" columns="{$boardColumns}">
            {$cards}
        </gameBoard>
};

declare %private
    function gco:createCards($numberOfCards as xs:int) as element(cards)
{   
    <cards>{
        let $boardRows := gco:getRowsForCardCount($numberOfCards)
        let $boardColumns := gco:getColumnsForCardCount($numberOfCards)
        let $cardIdSequence := gco:getRandomCardIdSequence($numberOfCards)
        for $id at $count in $cardIdSequence
            let $row := xs:int(($count -1) div $boardColumns)
            let $column := xs:int(($count - 1) mod $boardColumns)
            let $graphic := doc("../../static/svgs/cardSet.xml")//card[$id]/file/text()
            return
                <card id="{$count}" pairId="{$id}" row="{$row}" column="{$column}" solved="{false()}" revealed="{false()}">
                    <graphic>{$graphic}</graphic>
                </card>
    }</cards>
};

declare %private
    function gco:getRandomCardIdSequence($numberOfCards as xs:int)
{
    let $uniqueCards := $numberOfCards div 2
    let $rng := random-number-generator(random:uuid())
    let $permutation := $rng("permute")(1 to $gco:numberOfCardGraphics)
    let $cardIdSequence := subsequence($permutation, 1, $uniqueCards)
    let $completeSetOfIds := ($cardIdSequence, $cardIdSequence)
    let $competeRandomSetOfIds := $rng("permute")($completeSetOfIds)
    return $competeRandomSetOfIds
};

declare %private
    function gco:getRowsForCardCount($numberOfCards as xs:int)
{
    map:get($gco:cardsToBoardLayout, $numberOfCards)[1]
};

declare %private
    function gco:getColumnsForCardCount($numberOfCards as xs:int)
{
    map:get($gco:cardsToBoardLayout, $numberOfCards)[2]
};