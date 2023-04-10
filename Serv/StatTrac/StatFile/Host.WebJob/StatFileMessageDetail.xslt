<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:ds="http://statline.org/StatFileData.xsd"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl"
                >
  <!--
  This page is called by
    
  -->
  <xsl:output indent="no" method="text" omit-xml-declaration="yes" />
  <!--<xsl:output indent="no" method="text" encoding="ISO-8859-1"/>-->
  <xsl:include href="UtilityTemplates.xslt"/>
  <xsl:include href="FileDelimeterTab.xslt"/>
  <xsl:param name="tableName" />
  <xsl:template match="ds:StatFileData">
    <xsl:variable name="MessageDetail">
      <xsl:if test="$tableName = 'Created'">
        <xsl:for-each  select="ds:CreatedDateMessage">
          <MessageDetail>
            <xsl:copy-of select="node()"/>
            </MessageDetail>
        </xsl:for-each>
      </xsl:if>
      <xsl:if test="$tableName = 'LastModified'">
        <xsl:for-each  select="ds:LastModifiedDateMessage">
          <MessageDetail>
            <xsl:copy-of select="node()"/>
          </MessageDetail>
        </xsl:for-each>
      </xsl:if>
    </xsl:variable>
    <xsl:call-template name="ProcessMessageDetail">
      <xsl:with-param name="MessageDetail" select="exsl:node-set($MessageDetail)"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="ProcessMessageDetail">
    <xsl:param name="MessageDetail" />
    <xsl:for-each select="exsl:node-set($MessageDetail)/MessageDetail">
      <xsl:call-template name="MessageDetail" />
      <xsl:copy-of select="$endLineCharReturn"/>
    </xsl:for-each>
  </xsl:template>
  
  <!-- This template can be overridden in "derived" XSLT files -->
  <xsl:template name="MessageDetail">
    <xsl:call-template name="MessageDetailBase" />
  </xsl:template>
  
  <xsl:template name="MessageDetailBase">
    <!--Note: The named templates below with an error can be ignored included in another xslt include list -->
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:LastModified"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:MessageID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:CallNumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:CallDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:MessageTakenBy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:MessageTypeID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:MessageTypeName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:MessageForPerson"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:OrganizationName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="substring(ds:MessageDescription, 0, 255)"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:MessageCallerName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:MessageCallerPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:MessageCallerOrganization"/>
    <!-- do not include a columnDelimeter on end of column definition templates-->
  </xsl:template>
</xsl:stylesheet>

