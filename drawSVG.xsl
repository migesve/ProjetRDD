<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <svg width="700" height="700">
 
        <xsl:template match="sudoku">
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
        </xsl:template>
            <rect x="10" y="500" width="500" height="50" style="fill:none; stroke:black; stroke-width:1" />
                       
        <!-- <xsl:template match="/">
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
                <xsl:text x="10" y="515">La grille de sudoku est gagante.</xsl:text>
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
        
    </xsl:template> -->
    
        <xsl:template match="/">
            <xsl:variable name="all-numbers" select="'123456789'"/>

            <xsl:variable name="rows" select="//row"/>
            <xsl:variable name="cols" select="//col"/>
            <xsl:variable name="regions" select="//region"/>

            <xsl:variable name="row-count" select="count($rows)"/>
            <xsl:variable name="col-count" select="count($cols)"/>
            <xsl:variable name="region-count" select="count($regions)"/>

            <xsl:variable name="valid-row" select="true()"/>
            <xsl:variable name="valid-col" select="true()"/>
            <xsl:variable name="valid-region" select="true()"/>

            <!-- Check rows -->
            <xsl:for-each select="$rows">
                <xsl:variable name="row-values" select="concat(col/@val,'')"/>
                <xsl:variable name="missing-values" select="$all-numbers"/>

                <xsl:for-each select="col[@val]">
                    <xsl:variable name="current-value" select="@val"/>
                    <xsl:variable name="missing-values" select="translate($missing-values,$current-value,'')"/>
                </xsl:for-each>

                <xsl:if test="string-length($missing-values) != 0 or string-length($row-values) != $col-count">
                    <xsl:variable name="valid-row" select="false()"/>
                </xsl:if>
            </xsl:for-each>

            <!-- Check columns -->
            <xsl:for-each select="$cols">
                <xsl:variable name="col-values" select="concat(ancestor::row/col[@name = current()/@name]/@val,'')"/>
                <xsl:variable name="missing-values" select="$all-numbers"/>

                <xsl:for-each select="ancestor::row/col[@name = current()/@name][@val]">
                    <xsl:variable name="current-value" select="@val"/>
                    <xsl:variable name="missing-values" select="translate($missing-values,$current-value,'')"/>
                </xsl:for-each>

                <xsl:if test="string-length($missing-values) != 0 or string-length($col-values) != $row-count">
                    <xsl:variable name="valid-col" select="false()"/>
                </xsl:if>
            </xsl:for-each>

            <!-- Check regions -->
            <xsl:for-each select="$regions">
                <xsl:variable name="reg-values" select="concat(row/col[@name >= current()/@start-col and @name <= current()/@end-col]/@val,'')"/>
                <xsl:variable name="missing-values" select="$all-numbers"/>
                <xsl:for-each select="row/col[@name >= current()/@start-col and @name <= current()/@end-col][@val]">
                    <xsl:variable name="current-value" select="@val"/>
                    <xsl:variable name="missing-values" select="translate($missing-values,$current-value,'')"/>
              </xsl:for-each>

            <xsl:if test="string-length($missing-values) != 0 or string-length($reg-values) != $col-count">
                <xsl:variable name="valid-reg" select="false()"/>
            </xsl:if>
            </xsl:for-each>

        <xsl:if test="$valid-row and $valid-col and $valid-reg">
            <xsl:text>The Sudoku grid is valid</xsl:text>
        </xsl:if>
        <xsl:if test="not($valid-row or $valid-col or $valid-reg)">
            <xsl:text>The Sudoku grid is not valid</xsl:text>
        </xsl:if>

        </xsl:template>
        


    </svg>

</xsl:stylesheet>
