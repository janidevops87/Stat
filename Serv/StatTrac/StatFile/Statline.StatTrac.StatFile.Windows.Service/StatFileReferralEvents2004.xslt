<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:ds="http://statline.org/StatFileData.xsd"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl"
                >
  <xsl:output indent="no" method="text" omit-xml-declaration="yes" />
  <!--<xsl:output indent="no" method="text" encoding="ISO-8859-1"/>-->
  <xsl:include href="StatFileReferralEvents.xslt"/>
  <xsl:template match="ds:StatFileData">
    <xsl:variable name="EventDetail">
      <xsl:if test="$tableName = 'Created'">
        <xsl:for-each  select="ds:CreatedDateEvent">
          <EventDetail>
            <xsl:copy-of select="node()"/>
          </EventDetail>
        </xsl:for-each>
      </xsl:if>
      <xsl:if test="$tableName = 'LastModified'">
        <xsl:for-each  select="ds:LastModifiedDateEvent">
          <EventDetail>
            <xsl:copy-of select="node()"/>
          </EventDetail>
        </xsl:for-each>
      </xsl:if>
    </xsl:variable>
    <xsl:call-template name="ProcessStatFileReferralEvents2004">
      <xsl:with-param name="EventDetail" select="exsl:node-set($EventDetail)"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>

