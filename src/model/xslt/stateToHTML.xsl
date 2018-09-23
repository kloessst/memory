<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xslth="/memory/src/model/xslt/xsltParameters"
    exclude-result-prefixes="xslth">
    
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:include href="xsltParameters.xsl"/>
    
    <xsl:variable name="gameId" select="/game/@id"/>
    <xsl:variable name="numberOfCards" select="/game/@numberOfCards"/>
    
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
                        <a href="#saveDialog">Save Game</a>
                    </li>
                    <li><a href="#">Exit</a></li>
                </ul>
            </div>
            
            <dialog id="saveDialog" class="dialog"> 
                <h2>Save Game</h2> 
                <form action="/gameMenu/saveGame" method="post">
                    <input type="hidden" id="gameId" name="gameId" value="{$gameId}"/>
                    <div>
                        <label for="gameName">Enter a game name: </label>
                        <input id="gameName" name="gameName" type="text" /> 
                    </div>
                    <div>
                        <label for="gamePassword">Enter a password:</label>
                        <input id="gamePassword" name="gamePassword" type="password" /> 
                    </div>
                    <br/>
                    <a href="#" class="button">Cancel</a>
                    <button type="submit">Confirm</button>
                </form> 
            </dialog>
            
        </body>     
    </xsl:template>
    
    <xsl:template match="players">
            <!-- Iterate over players and display information -->
            <xsl:for-each select="player">
                <xsl:variable name="playerCalcYPos" select="xslth:calcYPlayerPos(position())"/>
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
                   
                <svg y="{$playerCalcYPos}" alignment-baseline="hanging" font-size="{$playerTextSize}" 
                    font-family="{$playerTextFont}" stroke-width="{$playerStrokeWidth}">
                    <text x="{$playerBoxXPos}" y="{$playerNameRelYPos}" fill="{$usernameFill}" stroke-color="{$playerNameStrokeColor}">
                        <xsl:value-of select="username"/>
                    </text>
                    <text x="{$playerBoxXPos}" y="{$playerScoreRelYPos}" fill="{$playerScoreColor}">
                        <xsl:value-of select="score"/>
                    </text>
                </svg>
            </xsl:for-each>
        
    </xsl:template>
    
    <xsl:template match="gameBoard">
        
        <xsl:variable name="cardWidth">
            <xsl:choose>
                <xsl:when test="$numberOfCards > 20">
                    <xsl:value-of select="$smallCardWidth"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$bigCardWidth"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="cardHeight">
            <xsl:choose>
                <xsl:when test="$numberOfCards > 20">
                    <xsl:value-of select="$smallCardHeight"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$bigCardHeight"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <svg width="{xslth:calcGameboardWidth(@columns, $cardWidth)}" height="{xslth:calcGameboardHeight(@rows, $cardHeight)}">
            <xsl:copy-of select="doc('../../../static/svgs/svgGameElements.svg')/svg/defs"/>            
            
            <!-- Iterate over every card -->
            <xsl:for-each select="cards/card">
                <!-- Calculate card position -->
                <xsl:variable name="cardXPos" select="xslth:calcXCardPos(@column, $cardWidth)"/>
                <xsl:variable name="cardYPos" select="xslth:calcYCardPos(@row, $cardHeight)"/>
                <xsl:variable name="graphic" select="xslth:buildPathToGame(graphic)"/>
                
                <!-- Render card: If card is facedown use cardFaceDown template, otherwise
                        use the card template given by the motiv attribute-->
                <xsl:choose>
                    <xsl:when test="@revealed = true() or @solved = true()">
                        <svg x="{$cardXPos}" y="{$cardYPos}" width="{$cardWidth}" height="{$cardHeight}">
                            <use href="#cardRevealed"/>
                            <image href="{$graphic}" x="{xslth:calcImageXPos($cardWidth)}" y="{xslth:calcImageYPos($cardHeight)}" 
                                width="{xslth:calcImageWidth($cardWidth)}" height="{xslth:calcImageHeight($cardHeight)}"/>
                        </svg>
                    </xsl:when>
                    <xsl:otherwise>
                        <a href="/game/{$gameId}/revealCard/{@id}">
                            <svg x="{$cardXPos}" y="{$cardYPos}" width="{$cardWidth}" height="{$cardHeight}">
                                <use href="#cardFacedown"/>
                            </svg>               
                        </a>
                    </xsl:otherwise>
                </xsl:choose>          
            </xsl:for-each>
        </svg>
    </xsl:template>
    
</xsl:transform>
