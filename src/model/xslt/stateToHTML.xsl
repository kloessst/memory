<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xslth="/memory/src/model/xslt/xsltParameters"
    exclude-result-prefixes="xslth">
    
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:include href="xsltParameters.xsl"/>
    
    <xsl:variable name="gameId" select="/game/@id"/>
    
    <!-- Transformations -->
    
    <xsl:template match="/">
        
        <body class="background">
            <div class="players">
                <xsl:apply-templates select="game/players"/> 
            </div>
            <div class="gameBoard">
                <xsl:apply-templates select="game/gameBoard"/> 
            </div>
            <!-- Display Menu Button -->
            <div class="dropdown-menu">
                <a href="#">Menu</a>
                <ul class="dropdown-menu-content">
                    <li>
                        <a href="#meinDialog">Save Game</a>
                    </li>
                    <li><a href="#">Exit</a></li>
                </ul>
            </div>
            
            <dialog id="meinDialog"> 
                <h2>Save Game</h2> 
                <form action="/gameMenu/saveGame" method="post">
                    <input type="hidden" id="gameId" name="gameId" value="{$gameId}"/>
                    <div>
                        <label for="gameName">Enter a name for the saved game: </label>
                        <input id="gameName" name="gameName" type="text" /> 
                    </div>
                    <div>
                        <label for="gamePassword">Enter a password:</label>
                        <input id="gamePassword" name="gamePassword" type="password" /> 
                    </div>
                    <a href="#" class="button">Cancel</a>
                    <button type="submit">Confirm</button>
                </form> 
            </dialog>
        </body>     
    </xsl:template>
    
    <xsl:template match="players">
        
        <!-- Iterate over players and display information -->
        <xsl:for-each select="player">
            <xsl:variable name="spielerXPos" select="xslth:calcXPos(position())"/>
            <xsl:variable name="usernameFill">
                <xsl:choose>
                    <xsl:when test="@active = true()">
                        <xsl:value-of select="$playerActiveColor"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$playerInactiveColor"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
               
            <svg x="{$spielerXPos}" alignment-baseline="hanging" font-size="{$textSize}">
                <text y="{$playerNameYPos}" fill="{$usernameFill}">
                    <xsl:value-of select="username"/>
                </text>
                <text y="{$playerScoreYPos}">
                    <xsl:value-of select="score"/>
                </text>             
            </svg>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="gameBoard">
        <svg width="{xslth:calcXPos(@columns) + $cardXMargin}" height="{xslth:calcYPos(@rows) + $cardYMargin}">
        
            <!-- Iterate over every card -->
            <xsl:for-each select="cards/card">
                <!-- Calculate card position -->
                <xsl:variable name="cardXPos" select="xslth:calcXPos(@column)"/>
                <xsl:variable name="cardYPos" select="xslth:calcYPos(@row)"/>
                <xsl:variable name="graphic" select="xslth:buildPathToGame(graphic)"/>
                
                <!-- Render card: If card is facedown use cardFaceDown template, otherwise
                        use the card template given by the motiv attribute-->
                <xsl:choose>
                    <xsl:when test="@revealed = true() or @solved = true()">
                        <svg x="{$cardXPos}" y="{$cardYPos}" width="{$cardWidth}" height="{$cardHeight}">
                            <image href="{$graphic}" height="100%" width="100%"/>
                        </svg>
                    </xsl:when>
                    <xsl:otherwise>
                        <a href="/game/{$gameId}/revealCard/{@id}">
                            <svg x="{$cardXPos}" y="{$cardYPos}" width="{$cardWidth}" height="{$cardHeight}">
                                <use href="/static/svgs/svgElements.svg#cardFrame" height="100%" width="100%"/>
                            </svg>               
                        </a>
                    </xsl:otherwise>
                </xsl:choose>          
            </xsl:for-each>
        </svg>
    </xsl:template>
    
</xsl:transform>
