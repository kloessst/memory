(:~
 : This module is the controller responsible for all basic game interactions
 :)
module namespace gc = 'memory/src/controller/gameController';

declare function gc:buildHTML($head, $body) 
{
    <html xmlns="http://www.w3.org/1999/xhtml">
        {$head}
        {$body}
    </html>
};

(:~
 : This route creates a new game with the parameters selected by the user in the new game lobby page.
 : @return HTML page
 :)
declare
    %rest:path("/createGame")
    %rest:POST
    %rest:form-param("numberOfPlayers", "{$numberOfPlayers}", 1)
    %rest:form-param("numberOfCards", "{$numberOfCards}", 20)
    %rest:form-param("username1", "{$username1}")
    %rest:form-param("username2", "{$username2}")
    %rest:form-param("username3", "{$username3}")
    %rest:form-param("username4", "{$username4}")
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function gc:createGame($numberOfPlayers as xs:int, $numberOfCards as xs:int, 
        $username1 as xs:string, $username2 as xs:string, $username3 as xs:string, $username4 as xs:string)
    as element(form)
{
    let $p1 := if ($username1) then
                <player>
                    <username>{$username1}</username>
                </player>
            else
                ()
    let $p2 := if ($username2) then
                <player>
                    <username>{$username2}</username>
                </player>
            else
                ()
    let $p3 := if ($username3) then
                <player>
                    <username>{$username3}</username>
                </player>
            else
                ()
    let $p4 := if ($username4) then
                <player>
                    <username>{$username4}</username>
                </player>
            else
                ()
    return 
    <form>
        <numberOfCards>{$numberOfCards}</numberOfCards>
        <numberOfPlayers>{$numberOfPlayers}</numberOfPlayers>
        <players>
            {$p1}
            {$p2}
            {$p3}
            {$p4}
        </players>
    </form>
}; 