(:~
 : This module contains some basic examplex for TESTXQ annotations
 : @author BaseX Team
 :)
module namespace page = 'http://basec.org/modulex/-webpage';

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
    <html xmlns="http://www.w3.org/1999/xhtml">

        <head>
            <title>Munich-Memory</title>
            <link rel="stylesheet" type="text/css" href="static/styles.css"/>
        </head>

        <body>

            <!-- embedded munich picture -->
            <!-- 'width: 100%' in css generates a bug -->
            <image src="static/munich.png" width="100%" preserveAspectRatio="none" />   

            <!-- header -->
            <h1>Munich-Memory</h1>

            <!-- 
                <div class="starttext">Welcome to our XML student project at the Technical University of Munich.</div>
                <div class="starttext2">To dive in to the memory fun, just press the play button. :)</div>
             -->

            <!-- startbutton -->
            <div class="button-strip">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <!-- onclick: move to menu -->
                    <a href="http://localhost:8984/menu">
                        <g>
                            <rect rx="100%" ry="100%" />
                            <text x="50%" y="50%">Play ⇪</text>
                        </g>
                    </a>
                </svg>
            </div>

        </body>

    </html>
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
    <html xmlns="http://www.w3.org/1999/xhtml">
        
        <head>
            <title>Munich-Memory</title>
            <link rel="stylesheet" type="text/css" href="static/styles.css"/>
        </head>

        <body class="background">

            <!-- header -->
            <a id="header" href="http://localhost:8984/" style="text-decoration:none;">
                <h1>Munich-Memory</h1>
            </a>

            <!-- menu -->
            <table class="menu-table">
                <tr><td><a href="http://localhost:8984/create-game" style="text-decoration:none;"><div>New Game</div></a></td></tr>
                <tr><td><a href="http://localhost:8984/load-game" style="text-decoration:none;"><div>Load Game</div></a></td></tr>
                <tr><td><a href="http://localhost:8984/highscore" style="text-decoration:none;"><div>Highscore</div></a></td></tr>
            </table>
            
            <image src="static/Silhouette_of_Munich.png" height="50%" width="100%" x="0" ></image>

        </body>

    </html>
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
    <html xmlns="http://www.w3.org/1999/xhtml">

        <head>
            <title>Munich-Memory</title>
            <link rel="stylesheet" type="text/css" href="static/styles.css"/>
        </head>

        <body class="background">

            <!-- header -->
            <h1>New Game</h1>
            
            <div xmlns:xf="http://www.w3.org/2002/xforms">
                <xforms>

                    <model>
                        <instance>
                            <person>
                                <fname/>
                                <lname/>
                            </person>
                        </instance>
                        <submission id="form1" method="get" action="submit.asp"/>
                    </model>

                    <input ref="fname">
                    <label>First Name</label></input><br />

                    <input ref="lname">
                    <label>Last Name</label></input><br /><br />

                    <submit submission="form1">
                    <label>Submit</label></submit>
                </xforms>
            </div>
            <image src="static/Silhouette_of_Munich.png" height="50%" width="100%" x="0" ></image>

        </body>

    </html>
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
    <html xmlns="http://www.w3.org/1999/xhtml">

        <head>
            <title>Munich-Memory</title>
            <link rel="stylesheet" type="text/css" href="static/styles.css"/>
        </head>

        <body class="background">
        
        </body>

    </html>
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
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title>Munich-Memory</title>
            <link rel="stylesheet" type="text/css" href="static/styles.css"/>
        </head>
            
        <body class="background">
        
        </body>

    </html>
};