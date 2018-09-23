<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xslth="/memory/src/model/xslt/xsltParameters"
    version="2.0">
    
    <xsl:variable name="pathToCardImages" select="'/static/images/cards/'"/>
    
    <!-- Card Size -->
    <xsl:variable name="heightRelativeToContainer" select="'100%'"/>
    <xsl:variable name="widthRelativeToContainer" select="'100%'"/>
    <xsl:variable name="bigCardHeight" select="170"/>
    <xsl:variable name="bigCardWidth" select="170"/>
    <xsl:variable name="smallCardHeight" select="140"/>
    <xsl:variable name="smallCardWidth" select="140"/>
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
    
    <!-- Player Info Style -->
    <xsl:variable name="playerBoxWidth" select="'20%'"/>
    <xsl:variable name="playerActiveColor" select="'#FAB218'"/>
    <xsl:variable name="playerInactiveColor" select="'white'"/>
    <xsl:variable name="playerNameStrokeColor" select="'white'"/>
    <xsl:variable name="playerStrokeWidth" select="3"/>
    <xsl:variable name="playerScoreColor" select="'#C2BFB8'"/>
    <xsl:variable name="playerBoxXPos" select="30"/>
    <xsl:variable name="playerNameRelYPos" select="'30%'"/>
    <xsl:variable name="playerScoreRelYPos" select="'60%'"/>
    <xsl:variable name="playerTextSize" select="22"/>
    <xsl:variable name="playerTextFont" select="'Impact'"/>
    
    <!-- Functions -->
    <xsl:function name="xslth:calcImageXPos">
        <xsl:param name="cardWidth"/>
        <xsl:value-of select="$cardWidth * 0.08"/>
    </xsl:function>
    
    <xsl:function name="xslth:calcImageYPos">
        <xsl:param name="cardHeight"/>
        <xsl:value-of select="$cardHeight * 0.08"/>
    </xsl:function>
    
    <xsl:function name="xslth:calcImageWidth">
        <xsl:param name="cardWidth"/>
        <xsl:value-of select="$cardWidth - 2 * xslth:calcImageXPos($cardWidth)"/>
    </xsl:function>
    
    <xsl:function name="xslth:calcImageHeight">
        <xsl:param name="cardHeight"/>
        <xsl:value-of select="$cardHeight - 2 * xslth:calcImageXPos($cardHeight)"/>
    </xsl:function>
    
    <xsl:function name="xslth:calcXCardPos">
        <xsl:param name="column"/>
        <xsl:param name="cardWidth"/>
        <xsl:value-of select="$cardXMargin + $column * ($cardWidth + $cardXMargin)"/>
    </xsl:function>
    
    <xsl:function name="xslth:calcYCardPos">
        <xsl:param name="row"/>
        <xsl:param name="cardHeight"/>
        <xsl:value-of select="$cardYMargin + $row * ($cardHeight + $cardYMargin)"/>
    </xsl:function>
    
    <xsl:function name="xslth:calcYPlayerPos">
        <xsl:param name="number"/>
        <xsl:value-of select="xslth:calcYCardPos($number, $bigCardHeight)"/>
    </xsl:function>
    
    <xsl:function name="xslth:calcGameboardWidth">
        <xsl:param name="columns"/>
        <xsl:param name="cardWidth"/>
        <xsl:value-of select="xslth:calcXCardPos($columns, $cardWidth) + $cardXMargin"/>
    </xsl:function>
    
    <xsl:function name="xslth:calcGameboardHeight">
        <xsl:param name="rows"/>
        <xsl:param name="cardHeight"/>
        <xsl:value-of select="xslth:calcYCardPos($rows, $cardHeight) + $cardYMargin"/>
    </xsl:function>
    
    <xsl:function name="xslth:buildPathToGame">
        <xsl:param name="file"/>
        <xsl:value-of select="concat($pathToCardImages, $file)"/>
    </xsl:function>
</xsl:stylesheet>