(:~
 : This module contains some basic examplex for TESTXQ annotations
 : @author BaseX Team
 :)
module namespace page = 'http://basec.org/modulex/-webpage';

declare function page:buildHTML($head, $body) 
{
    <html xmlns="http://www.w3.org/1999/xhtml">
        {$head}
        {$body}
    </html>
};

(:~
 : Returns the mainpage
 : @return HTML page
 :)
declare
    %rest:path("/")
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function page:main()
    as element(Q{http://www.w3.org/1999/xhtml}html)
{
    let $head := doc("../views/lobbyHeader.xml")
    let $body := doc("../views/start.xml")
    return page:buildHTML($head, $body)
}; 

(:~
 : Returns the menu
 : @return HTML page
 :)
declare
    %rest:path("/menu")
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function page:menu()
    as element(Q{http://www.w3.org/1999/xhtml}html)
{
    let $head := doc("../views/lobbyHeader.xml")
    let $body := doc("../views/mainMenu.xml")
    return page:buildHTML($head, $body)
};

(:~
 : Returns the create a new game site
 : @return HTML page
 :)
declare
    %rest:path("/create-game")
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function page:createGame()
    as element(Q{http://www.w3.org/1999/xhtml}html)
{
    let $head := doc("../views/lobbyHeader.xml")
    let $body := doc("../views/createGame.xml")
    return page:buildHTML($head, $body)
};

(:~
 : Returns the load a game site
 : @return HTML page
 :)
declare
    %rest:path("/load-game")
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function page:loadGame()
    as element(Q{http://www.w3.org/1999/xhtml}html)
{
    let $head := doc("../views/lobbyHeader.xml")
    let $body := doc("../views/loadGame.xml")
    return page:buildHTML($head, $body)
};

declare
    %rest:path("/highscore")
    %rest:GET
    %output:method("xhtml")
    %output:omit-xml-declaration("no")
    %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
    %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
    function page:highscore()
    as element(Q{http://www.w3.org/1999/xhtml}html)
{
    let $head := doc("../views/lobbyHeader.xml")
    let $body := doc("../views/highscore.xml")
    return page:buildHTML($head, $body)
};