<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:ds="http://statline.org/StatFileData.xsd"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl"
                >  
  <xsl:output indent="no" method="text" omit-xml-declaration="yes" />
  <!--<xsl:output indent="no" method="text" encoding="ISO-8859-1"/>-->
  <xsl:include href="StatFileReferralDetail.xslt"/>  
  <xsl:template match="ds:StatFileData">    
    <xsl:variable name="ReferralDetail">
      <xsl:if test="$tableName = 'Created'">
        <xsl:for-each  select="ds:CreatedDateReferral">
          <ReferralDetail>
            <xsl:copy-of select="node()"/>
          </ReferralDetail>
        </xsl:for-each>
      </xsl:if>
      <xsl:if test="$tableName = 'LastModified'">
        <xsl:for-each  select="ds:LastModifiedDateReferral">
          <ReferralDetail>
            <xsl:copy-of select="node()"/>
          </ReferralDetail>
        </xsl:for-each>
      </xsl:if>
    </xsl:variable>    
    <xsl:call-template name="ProcessExtendedReferralDetail2006">
      <xsl:with-param name="ReferralDetail" select="exsl:node-set($ReferralDetail)"/>
    </xsl:call-template>
  </xsl:template> 
</xsl:stylesheet>

