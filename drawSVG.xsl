<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="sudoku">
        <svg width="700" height="700">


            <xsl:for-each select="region">

                <xsl:for-each select="row">
                    <xsl:variable name="xLoc" select="substring(@name,4,4)" as="xsd:integer()" />
                    <xsl:for-each select="col">
                        <xsl:variable name="yLoc" select="substring(@name,4,4)" as="xsd:integer()" />

                        <rect x="{50*$xLoc}" y="{50*$yLoc}" width="50" height="50" style="fill:none; stroke:black; stroke-width:1" />
                        <text x="{17+50*$xLoc}" y="{35+50*$yLoc}" font-size="30" fill="black">
                            <xsl:value-of select="@val" />
                        </text>


                    </xsl:for-each>


                </xsl:for-each>

            </xsl:for-each>
            <rect x="10" y="500" width="500" height="50" style="fill:none; stroke:black; stroke-width:1" />
                       
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
                <xsl:text x="10" y="475">La grille de sudoku est gagante.</xsl:text>
            </xsl:if>

            <!-- La grille est incorrect ou correct -->
            <!-- <xsl:variable name="valid" select="true()">
                <xsl:for-each select="region">
                    <xsl:for-each select="row">
                        <xsl:for-each select="col">
                            <xsl:if test="count(following-sibling::col[@val=current()/@val]) &gt; 0">
                                <xsl:variable name="valid" select="false()"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:variable>
            <xsl:if test="$valid = true()">
                <xsl:text x="10" y="500">La grille de sudoku est correct</xsl:text>
            </xsl:if>
            <xsl:if test="$valid = false()">
                <xsl:text x="10" y="500">La grille de sudoku est incorrect</xsl:text>
            </xsl:if> -->
            
            <xsl:if test="not(string-length($cols) = 9)">
                <xsl:text>Les colonnes suivantes ne sont pas valides : </xsl:text>
                <xsl:value-of select="$cols"/>
            </xsl:if>
            <xsl:if test="not(string-length($rows) = 9)">
                <xsl:text>Les lignes suivantes ne sont pas valides : </xsl:text>
                <xsl:value-of select="$rows"/>
            </xsl:if>
            <xsl:if test="not(string-length($regions) = 9)">
                <xsl:text>Les régions suivantes ne sont pas valides : </xsl:text>
                <xsl:value-of select="$regions"/>
            </xsl:if>
        </svg>
    </xsl:template>


</xsl:stylesheet>
