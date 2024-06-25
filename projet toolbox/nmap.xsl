<!-- nmap.xsl: Feuille de style pour convertir les résultats Nmap XML en texte -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" />

  <xsl:template match="/">
    <xsl:apply-templates select="//host" />
  </xsl:template>

  <xsl:template match="host">
    <xsl:for-each select="ports/port">
      <xsl:text>| </xsl:text>
      <xsl:value-of select="@portid" />
      <xsl:text> | </xsl:text>
      <xsl:value-of select="state/@state" />
      <xsl:text> | </xsl:text>
      <xsl:value-of select="service/@name" />
      <xsl:text> | </xsl:text>
      <xsl:value-of select="service/@version" />
      <xsl:text> |\n</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
