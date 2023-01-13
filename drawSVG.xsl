<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="sudoku">
        <svg width="450" height="450">


            <xsl:for-each select="region">

                <xsl:for-each select="row">
                    <xsl:variable name="xLoc" select="substring(@name,4,4)-1" as="xsd:integer()" />
                    <xsl:for-each select="col">
                        <xsl:variable name="yLoc" select="substring(@name,4,4)-1" as="xsd:integer()" />

                        <rect x="{50*$xLoc}" y="{50*$yLoc}" width="50" height="50" style="fill:none; stroke:black; stroke-width:1" />
                        <text x="{17+50*$xLoc}" y="{35+50*$yLoc}" font-size="30" fill="black">
                            <xsl:value-of select="@val" />
                        </text>


                    </xsl:for-each>


                </xsl:for-each>

            </xsl:for-each>

            <!-- la grille est gagnante -->
            <xsl:variable name="cols">
                <xsl:for-each select="//col">
                    <xsl:if test="not(@val = preceding::col/@val)">
                        <xsl:value-of select="@name"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>

            <xsl:variable name="rows">
                <xsl:for-each select="//row">
                    <xsl:if test="count(col[@val]) = 9 and count(col[@val = preceding::row/col/@val]) = 0">
                        <xsl:value-of select="@name"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>

            <xsl:variable name="regions">
                <xsl:for-each select="//region">
                    <xsl:if test="count(row/col[@val]) = 9 and count(row/col[@val = preceding::region/row/col/@val]) = 0">
                        <xsl:value-of select="@name"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>

            <xsl:if test="string-length($cols) = 9 and string-length($rows) = 9 and string-length($regions) = 9">
                <xsl:text>La grille de sudoku est gagante.</xsl:text>
            </xsl:if>

            <!-- La grille est incorrect ou correct -->
            <xsl:variable name="valide" select="true()"/>
            <xsl:for-each select="region">
                <xsl:for-each select="row">
                    <xsl:for-each select="col">
                        <xsl:if test="count(preceding-sibling::col[@val=current()/@val]) &gt; 0">
                            <xsl:variable name="valide" select="false()"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
            <xsl:if test="$valide = true()">
                <xsl:text>La grille de sudoku est correct</xsl:text>
            </xsl:if>
            <xsl:if test="$valide = false()">
                <xsl:text>La grille de sudoku est incorrect</xsl:text>
            </xsl:if>

        </svg>
    </xsl:template>


</xsl:stylesheet>