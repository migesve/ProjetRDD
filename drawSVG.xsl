<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="sudoku">
        <svg width="450" height="450">


            <xsl:for-each select="region">

                <xsl:for-each select="row">
                    <xsl:variable name="xLoc" select="1-substring(@name,4,5)" as="xsd:integer()"/>
                    <xsl:for-each
                        select="col">
                        <xsl:variable name="yLoc" select="1-substring(@name,4,5)" as="xsd:integer()" />


                        <rect
                            x="{$xLoc}" y="{$yLoc}" width="50" height="50"
                            style="fill:none; stroke:black; stroke-width:1" />  
                <text x="17" y="35"
                            font-size="30" fill="black">
                            <xsl:value-of select="@val" />
                        </text>

                <rect
                            x="{50*$xLoc}" y="{50*$yLoc}" width="50" height="50"
                            style="fill:none; stroke:black; stroke-width:1" />
                <text x="{67+50*$xLoc}" y="{35+50*$yLoc}"
                            font-size="30" fill="black">
                            <xsl:value-of select="@val" />
                        </text>
                <rect
                            x="{100*$xLoc}" y="{100*$yLoc}" width="50" height="50"
                            style="fill:none; stroke:black; stroke-width:1" />
                <text x="{117+100*$xLoc}" y="{35+50*$yLoc}"
                            font-size="30" fill="black">
                            <xsl:value-of select="@val" />
                        </text>


                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>

        </svg>
    </xsl:template>


</xsl:stylesheet>