<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="matrice">
        <html>
            <body>
                <table border="1">
                    <xsl:for-each select="row">
                        <tr>
                            <xsl:for-each select="col">
                                <td><xsl:value-of select="col" /></td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>


</xsl:stylesheet>