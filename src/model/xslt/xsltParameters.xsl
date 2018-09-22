<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xslth="/memory/src/model/xslt/xsltParameters"
    version="2.0">
    
    <xsl:variable name="pathToCardImages" select="'/static/images/cards/'"/>
    
    <!-- Card Size -->
    <xsl:variable name="heightRelativeToContainer" select="'100%'"/>
    <xsl:variable name="widthRelativeToContainer" select="'100%'"/>
    <xsl:variable name="cardHeight" select="170"/>
    <xsl:variable name="cardWidth" select="170"/>
    <xsl:variable name="cardXMargin" select="25"/>
    <xsl:variable name="cardYMargin" select="25"/>
    
    <!-- Card Frame -->
    <xsl:variable name="frameRx" select="'15%'"/>
    <xsl:variable name="frameRy" select="'15%'"/>
    <xsl:variable name="frameStroke" select="'#666668'"/>
    <xsl:variable name="frameStrokeWidth" select="8"/>
    <xsl:variable name="frameBackgroundOpen" select="'white'"/>
    
    <!-- Card Back Pattern -->
    <xsl:variable name="cardBackSquareLength" select="20"/>
    <xsl:variable name="cardBackPatternFill" select="'white'"/>
    <xsl:variable name="cardBackPatternStroke" select="'#666668'"/>
    <xsl:variable name="cardBackPatternStrokeOpacity" select="0.5"/>
    <xsl:variable name="cardBackPatternStrokeWidth" select="3"/>
    
    <!-- Image -->
    <xsl:variable name="imagePaddingWidth" select="0.08 * $cardWidth"/>
    <xsl:variable name="imagePaddingHeight" select="0.08 * $cardHeight"/>
    <xsl:variable name="imageWidth" select="$cardWidth - 2 * $imagePaddingWidth"/>
    <xsl:variable name="imageHeight" select="$cardHeight - 2 * $imagePaddingHeight"/>
    
    <!-- Player Info Style -->
    <xsl:variable name="playerActiveColor" select="'red'"/>
    <xsl:variable name="playerInactiveColor" select="'white'"/>
    <xsl:variable name="playerScoreColor" select="'grey'"/>
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