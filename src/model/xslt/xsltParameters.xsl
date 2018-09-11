<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xslth="/memory/src/model/xslt/xsltParameters"
    version="2.0">
    
    <xsl:variable name="pathToCardImages" select="'/static/images/cards/'"/>
    
    <!-- Game Table -->
    <xsl:variable name="tableXPos" select="50"/>
    <xsl:variable name="tableYPos" select="50"/>
    
    <!-- Game Table Symbol -->
    <xsl:variable name="tableSymbolHeigth" select="'100%'"/>
    <xsl:variable name="tableSymbolWidth" select="'100%'"/>
    <xsl:variable name="tableSymbolStroke" select="'black'"/>
    <xsl:variable name="tableSymbolFill" select="'green'"/>
    <xsl:variable name="tableSymbolRx" select="'2%'"/>
    <xsl:variable name="tableSymbolRy" select="'2%'"/>
    
    <!-- Player HUD -->
    <xsl:variable name="hudHeight" select="50"/>
    <xsl:variable name="hudXPos" select="$tableXPos"/>
    
    <!-- Card Size -->
    <xsl:variable name="cardHeight" select="100"/>
    <xsl:variable name="cardWidth" select="100"/>
    <xsl:variable name="cardXMargin" select="20"/>
    <xsl:variable name="cardYMargin" select="20"/>
    
    <!-- Card Frame -->
    <xsl:variable name="frameRx" select="'2%'"/>
    <xsl:variable name="frameRy" select="'2%'"/>
    <xsl:variable name="frameStroke" select="'gray'"/>
    <xsl:variable name="frameStrokeWidth" select="2"/>
    <xsl:variable name="frameBackgroundOpen" select="'white'"/>
    
    <!-- Card Symbol Position -->
    <xsl:variable name="symbolXPosition" select="'50%'"/>
    <xsl:variable name="symbolYPosition" select="'50%'"/>
    
    <!-- Symbol Circle -->
    <xsl:variable name="circleRadius" select="'25%'"/>
    
    <!-- Symbol Rect -->
    <xsl:variable name="rectHeight" select="'50%'"/>
    <xsl:variable name="rectWidth" select="'50%'"/>

    <!-- Button Size/Layout-->
    <xsl:variable name="buttonHeight" select="40"/>
    <xsl:variable name="buttonWidth" select="80"/>
    <xsl:variable name="labelXPosition" select="'50%'"/>
    <xsl:variable name="labelYPosition" select="'50%'"/>
    
    <!-- Menu Button Style-->
    <xsl:variable name="menuButtonText" select="'Menü'"/>
    <xsl:variable name="menuButtonTextColor" select="'white'"/>
    <xsl:variable name="menuButtonColor" select="'blue'"/>
    
    <!-- Player Info Style -->
    <xsl:variable name="playerActiveColor" select="'red'"/>
    <xsl:variable name="playerInactiveColor" select="'black'"/>
    <xsl:variable name="playerNameYPos" select="'30%'"/>
    <xsl:variable name="playerScoreYPos" select="'60%'"/>
    <xsl:variable name="textSize" select="15"/>
    
    <!-- Functions -->   
    <xsl:function name="xslth:calcXPos">
        <xsl:param name="column"/>
        <xsl:value-of select="$cardXMargin + $column * ($cardWidth + $cardXMargin)"/>
    </xsl:function>
    
    <xsl:function name="xslth:calcYPos">
        <xsl:param name="row"/>
        <xsl:value-of select="$cardYMargin + $row * ($cardHeight + $cardYMargin)"/>
    </xsl:function>
    
    <xsl:function name="xslth:buildPathToGame">
        <xsl:param name="file"/>
        <xsl:value-of select="concat($pathToCardImages, $file)"/>
    </xsl:function>
</xsl:stylesheet>