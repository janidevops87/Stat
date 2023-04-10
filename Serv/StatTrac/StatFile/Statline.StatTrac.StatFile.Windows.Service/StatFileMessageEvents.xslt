<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:ds="http://statline.org/StatFileData.xsd"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl"
                >
  <!--
  This page is called by
    StatFileReferralEvents2004.xslt
  -->
  <xsl:output indent="no" method="text" omit-xml-declaration="yes" />
  <!--<xsl:output indent="no" method="text" encoding="ISO-8859-1"/>-->
  <xsl:include href="UtilityTemplates.xslt"/>
  <xsl:include href="FileDelimeterTab.xslt"/>
  <xsl:param name="tableName" />
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
    <xsl:call-template name="ProcessMessageEvents">
      <xsl:with-param name="EventDetail" select="exsl:node-set($EventDetail)"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="ProcessMessageEvents">
    <xsl:param name="EventDetail" />
    <xsl:for-each select="exsl:node-set($EventDetail)/EventDetail">
      <xsl:call-template name="MessageEvents" >
        <xsl:with-param name="eventDetailDataTable" select="node()"/>
      </xsl:call-template>
      <xsl:copy-of select="$endLineCharReturn"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="MessageEvents">
    <xsl:param name="eventDetailDataTable" />
    <!--Note: The named templates below with an error can be ignored included in another xslt include list -->
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:LastModified"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:LogEventID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:MessageID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:CallNumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:LogEventTypeID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:LogEventTypeName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:LogEventDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:PersonID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:LogEventName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:LogEventPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:OrganizationID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:LogEventOrg"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:LogEventDesc"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="ds:LogEventCreatedBy"/>
    <!-- do not include a columnDelimeter on end of column definition templateds-->
  </xsl:template>

</xsl:stylesheet>
