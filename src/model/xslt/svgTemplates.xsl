<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xlink="http://www.w3.org/1999/xlink">
    
    <xsl:output
        method="xml"
        indent="yes"
        standalone="no"
        doctype-public="-//W3C//DTD SVG 1.1//EN"
        doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"
        media-type="image/svg" />
    
    <xsl:include href="xsltParameters.xsl"/>
    
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg">
            <defs>       
                <!-- Kartenrücken Muster -->
                <pattern id="cardBackPattern" x="0" y="0" height="8" width="8" patternUnits="userSpaceOnUse"
                    patternTransform="rotate(45)">
                    <rect height="8" width="8" fill="white" stroke="blue" stroke-width="2.5" stroke-opacity="0.5"/>     
                </pattern>
                
                <!-- Rahmen-->
                <rect id="cardFrame" rx="{$frameRx}" ry="{$frameRy}" 
                    height="100%" width="100%" 
                    stroke="{$frameStroke}" stroke-width="{$frameStrokeWidth}"/>
                
                <!-- Rahmen aufgedeckt-->
                <use id="cardFrameOpen" xlink:href="#cardFrame" fill="{$frameBackgroundOpen}"/>
                
                <!-- Verdeckte Karte -->
                <svg id="cardFacedown" height="{$cardHeight}" width="{$cardWidth}">
                    <use xlink:href="#cardFrame" fill="url(#cardBackPattern)"/>
                </svg>          
                
                <!-- Table Symbol -->
                <rect id="tableSymbol" height="{$tableSymbolHeigth}" width="{$tableSymbolWidth}" 
                    stroke="{$tableSymbolStroke}" fill="{$tableSymbolFill}" 
                    rx="{$tableSymbolRx}" ry="{$tableSymbolRy}"/>
            </defs>
        </svg>
    </xsl:template>
</xsl:transform>