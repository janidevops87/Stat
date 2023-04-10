<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:ds="http://statline.org/StatFileData.xsd"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="StatFileMessageDetail.xslt"/>
  
  <xsl:output indent="no" method="text" omit-xml-declaration="yes" />
   
  <!-- Overriding base template -->
  <xsl:template name="MessageDetail">
    <xsl:call-template name="MessageDetailBase"/>
    <xsl:call-template name="MessageDetail2019"/>
  </xsl:template>
  
  <!-- Define a template with extra columns -->
  <xsl:template name="MessageDetail2019">
    <xsl:copy-of select="$columnDelimeter"/>
    <!-- Parsing organ name, truncating to max. 20 chars  -->
    <xsl:value-of select="substring(normalize-space(substring-before(substring-after(ds:MessageDescription,'Organ:'), 'Donor ID:')), 0, 20)"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:copy-of select="substring(ds:MessageDescription, 0, 1000)"/>
    <!-- do not include a columnDelimeter on end of column definition templates-->
  </xsl:template>
</xsl:stylesheet>