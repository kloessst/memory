<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    
    <xsl:output
        method="xml"
        indent="yes"/>
    
    <xsl:include href="xsltParameters.xsl"/>
    
    <xsl:template match="/">
        <svg>
            <defs>       
                <!-- Kartenrücken Muster -->
                <pattern id="cardBackPattern" x="0" y="0" height="{$cardBackSquareLength}" width="{$cardBackSquareLength}" patternUnits="userSpaceOnUse"
                    patternTransform="rotate(45)">
                    <rect height="{$cardBackSquareLength}" width="{$cardBackSquareLength}" fill="{$cardBackPatternFill}" 
                        stroke="{$cardBackPatternStroke}" stroke-width="{$cardBackPatternStrokeWidth}" 
                        stroke-opacity="{$cardBackPatternStrokeOpacity}"/>     
                </pattern>
                
                <!-- Rahmen-->
                <rect id="cardFrame" rx="{$frameRx}" ry="{$frameRy}" 
                    height="{$heightRelativeToContainer}" width="{$widthRelativeToContainer}" 
                    stroke="{$frameStroke}" stroke-width="{$frameStrokeWidth}" stroke-linejoin="round"/>
                
                <!-- Rahmen aufgedeckt-->
                <use id="cardRevealed" href="#cardFrame" fill="{$frameBackgroundOpen}"/>
                
                <!-- Verdeckte Karte -->
                <use id="cardFacedown" href="#cardFrame" fill="url(#cardBackPattern)"/>                                     
            </defs>
        </svg>
    </xsl:template>
</xsl:transform>