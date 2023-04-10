<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:ds="http://statline.org/StatFileData.xsd"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl"
                >
  <!--
  This page is called by
    StatFileExtendedReferralDetail.xslt
    StatFileExtendedReferralDetail2004.xslt
    StatFileExtendedReferralDetailFS.xslt
    StatFileExtendedReferralDetail2006.xslt
    StatFileExtendedReferralDetail2020.xslt
  -->
  <xsl:output indent="no" method="text" omit-xml-declaration="yes" />
  <!--<xsl:output indent="no" method="text" encoding="ISO-8859-1"/>-->
  <xsl:include href="UtilityTemplates.xslt"/>
  <xsl:include href="FileDelimeterTab.xslt"/>
  <xsl:param name="tableName" />
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
    <xsl:call-template name="ProcessReferralDetail">
      <xsl:with-param name="ReferralDetail" select="exsl:node-set($ReferralDetail)"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="ProcessReferralDetail">
    <xsl:param name="ReferralDetail" />
    <xsl:for-each select="exsl:node-set($ReferralDetail)/ReferralDetail">
      <xsl:call-template name="ExtendedReferralDetailFS" >
        <xsl:with-param name="referralDetailDataTable" select="node()"/>
      </xsl:call-template>
      <xsl:copy-of select="$endLineCharReturn"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ProcessExtendedReferralDetail">
    <xsl:param name="ReferralDetail" />
    <xsl:for-each select="exsl:node-set($ReferralDetail)/ReferralDetail">
      <xsl:call-template name="ExtendedReferralDetail" >
        <xsl:with-param name="referralDetailDataTable" select="node()"/>
      </xsl:call-template>
      <xsl:copy-of select="$endLineCharReturn"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ProcessExtendedReferralDetail2004">
    <xsl:param name="ReferralDetail" />
    <xsl:for-each select="exsl:node-set($ReferralDetail)/ReferralDetail">
      <xsl:call-template name="ExtendedReferralDetail2004" >
        <xsl:with-param name="referralDetailDataTable" select="node()"/>
      </xsl:call-template>
      <xsl:copy-of select="$endLineCharReturn"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ProcessExtendedReferralDetailFS">
    <xsl:param name="ReferralDetail" />
    <xsl:for-each select="exsl:node-set($ReferralDetail)/ReferralDetail">
      <xsl:call-template name="ExtendedReferralDetailFS" >
        <xsl:with-param name="referralDetailDataTable" select="node()"/>
      </xsl:call-template>
      <xsl:copy-of select="$endLineCharReturn"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ProcessExtendedReferralDetail2006">
    <xsl:param name="ReferralDetail" />
    <xsl:for-each select="exsl:node-set($ReferralDetail)/ReferralDetail">
      <xsl:call-template name="ExtendedReferralDetail2006" >
        <xsl:with-param name="referralDetailDataTable" select="node()"/>
      </xsl:call-template>
      <xsl:copy-of select="$endLineCharReturn"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ProcessExtendedReferralDetail2020">
    <xsl:param name="ReferralDetail" />
    <xsl:for-each select="exsl:node-set($ReferralDetail)/ReferralDetail">
      <xsl:call-template name="ExtendedReferralDetail2020" >
        <xsl:with-param name="referralDetailDataTable" select="node()"/>
      </xsl:call-template>
      <xsl:copy-of select="$endLineCharReturn"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="ReferralDetail">
    <xsl:param name="referralDetailDataTable" />
    <!--Note: The named templates below with an error can be ignored included in another xslt include list -->
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:LastModified"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CallNumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:CallDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:StatEmployee"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralTypeID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralTypeName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralStatusID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralStatus"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CallerPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralCallerExtension"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:Caller"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:PersonTypeName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:OrganizationUserCode"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:OrganizationName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CallerOrganizationUnit"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorFirstName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorLastName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorRecNumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="RoundDecimal">
      <xsl:with-param name="fieldValue" select="ds:ReferralDonorAge"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorAgeUnit"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorRaceID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:RaceName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorGender"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="RoundDecimal">
      <xsl:with-param name="fieldValue" select="ds:ReferralDonorWeight"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorCauseOfDeathID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CauseOfDeathName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="SetFieldLength">
      <xsl:with-param name="fieldValue" select="ds:ReferralNotesCase" />
      <xsl:with-param name="fieldLength" select="255" />
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <!-- This is filler for Field 29-->
    <xsl:text>0</xsl:text>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:ReferralDonorAdmitDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorAdmitTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorOnVentilator"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <!-- This is filler for Field 33-->
    <xsl:text>0</xsl:text>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:ReferralDonorDeathDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorDeathTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralApproachTypeID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ApproachTypeName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ApproachBy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralApproachNOK"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralApproachRelation"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralOrganAppropriateID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralBoneAppropriateID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralTissueAppropriateID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralSkinAppropriateID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralValvesAppropriateID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralEyesTransAppropriateID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralOrganApproachID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralBoneApproachID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralTissueApproachID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralSkinApproachID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralValvesApproachID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralEyesTransApproachID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralOrganConsentID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralBoneConsentID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralTissueConsentID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralSkinConsentID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralValvesConsentID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralEyesTransConsentID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralOrganConversionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralBoneConversionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralTissueConversionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralSkinConversionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralValvesConversionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralEyesTransConversionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralOrganDispositionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralAllTissueDispositionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralEyesDispositionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralBoneDispositionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralTissueDispositionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralSkinDispositionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralValvesDispositionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralGeneralConsent"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralExtubated"/>
    <!-- do not include a columnDelimeter on end of column definition templateds-->
  </xsl:template>
  <xsl:template name="ExtendedReferralDetail">
    <xsl:param name="referralDetailDataTable" />
    <!-- Calls the previous file version-->
    <xsl:call-template name="ReferralDetail" >
      <xsl:with-param name="referralDetailDataTable" select="exsl:node-set($referralDetailDataTable)"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <!--Note: The named templates below with an error can be ignored included in another xslt include list -->
    <xsl:value-of select="ds:ReferralDOB"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorSSN"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralCoronersCase"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CountyName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralEyesRschAppropriateID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralEyesRschApproachID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralEyesRschConsentID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralEyesRschConversionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralRschDispositionID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_1"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_2"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_3"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_4"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_5"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_6"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_7"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_8"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_9"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_10"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_11"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_12"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_13"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_14"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_15"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:customField_16"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_1"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_2"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_3"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_4"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_5"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_6"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_7"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_8"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_9"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_10"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_11"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_12"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_13"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_14"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_15"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ServiceLevelCustomFieldLabel_16"/>
    <!-- do not include a columnDelimeter on end of column definition templateds-->

  </xsl:template>
  <xsl:template name="ExtendedReferralDetail2004">
    <xsl:param name="referralDetailDataTable" />
    <!-- Calls the previous file version-->
    <xsl:call-template name="ExtendedReferralDetail" >
      <xsl:with-param name="referralDetailDataTable" select="exsl:node-set($referralDetailDataTable)"/>
    </xsl:call-template>
    <!-- call column delimeter between each template-->
    <xsl:copy-of select="$columnDelimeter"/>
    <!--Note: The named templates below with an error can be ignored included in another xslt include list -->
    <xsl:value-of select="ds:CoronerState"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CoronerOrganization"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CoronerName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CoronerPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CoronerNote"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:NOKPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralNOKAddress"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:RegistryStatusID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:RegistryStatusType"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:PatientHasHeartbeat"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:DOA"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:AttendingPhysician"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:PronouncingPhysician"/>
    <!-- do not include a columnDelimeter on end of column definition templateds-->
  </xsl:template>
  <xsl:template name="ExtendedReferralDetailFS">
    <xsl:param name="referralDetailDataTable" />
    <!-- Calls the previous file version-->
    <xsl:call-template name="ExtendedReferralDetail2004" >
      <xsl:with-param name="referralDetailDataTable" select="exsl:node-set($referralDetailDataTable)"/>
    </xsl:call-template>
    <!-- call column delimeter between each template-->
    <xsl:copy-of select="$columnDelimeter"/>
    <!--Note: The named templates below with an error can be ignored included in another xslt include list -->
    <xsl:value-of select="ds:FSCaseId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseCreateUserId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseCreateDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseOpenUserId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseOpenDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseSysEventsUserId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseSysEventsDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseSecCompUserId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseSecCompDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseApproachUserId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseApproachDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseFinalUserId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseFinalDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseUpdate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseUserId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseBillSecondaryUserID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseBillDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseBillApproachUserID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseBillApproachDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseBillMedSocUserID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseBillMedSocDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryManualBillPersonId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryUpdatedFlag"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseTotalTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseSeconds"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseBillFamUnavailUserId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseBillFamUnavailDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseBillCryoFormUserId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDateTime">
      <xsl:with-param name="DateTime" select="ds:FSCaseBillCryoFormDateTime"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseBillApproachCount"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseBillMedSocCount"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:FSCaseBillCryoFormCount"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryWhoAreWe"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKaware"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFamilyConsent"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFamilyInterested"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKatHospital"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryEstTimeSinceLeft"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryTimeLeftInMT"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKNextDest"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKETA"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientMiddleName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientHeightFeet"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientHeightInches"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientBMICalc"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientTOD1"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientTOD2"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <!-- NOT Used -->
    <xsl:value-of select="ds:SecondaryPatientDeathType1"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <!-- NOT Used -->
    <xsl:value-of select="ds:SecondaryPatientDeathType2"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryTriageHX"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCircumstanceOfDeath"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryMedicalHistory"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAdmissionDiagnosis"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCOD"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCODSignatory"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCODTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCODSignedBy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientVent"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <!-- NOT Used -->
    <xsl:value-of select="ds:SecondaryIntubationDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryIntubationTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryBrainDeathDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBrainDeathTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryDNRDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryERORDeath"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <!-- NOT Used -->
    <xsl:value-of select="ds:SecondaryEMSArrivalToPatientDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryEMSArrivalToPatientTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <!-- NOT Used -->
    <xsl:value-of select="ds:SecondaryEMSArrivalToHospitalDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryEMSArrivalToHospitalTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientTerminal"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryDeathWitnessed"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryDeathWitnessedBy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryLSADate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryLSATime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryLSABy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryACLSProvided"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryACLSProvidedTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryGestationalAge"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryParentName1"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryParentName2"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBirthCBO"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryActiveInfection"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryActiveInfectionType"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFluidsGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodLoss"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondarySignOfInfection"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryMedication"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPCPName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPCPPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryMDAttending"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryMDAttendingPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPhysicalAppearance"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryInternalBloodLossCC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryExternalBloodLossCC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProducts"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPreTransfusionSampleRequired"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPreTransfusionSampleAvailable"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryPreTransfusionSampleDrawnDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPreTransfusionSampleDrawnTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPreTransfusionSampleQuantity"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPreTransfusionSampleHeldAt"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryPreTransfusionSampleHeldDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPreTransfusionSampleHeldTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPreTransfusionSampleHeldTechnician"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPostMordemSampleTestSuitable"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPostMordemSampleLocation"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPostMordemSampleContact"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryPostMordemSampleCollectionDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPostMordemSampleCollectionTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondarySputumCharacteristics"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKAltPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKLegal"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKAltContact"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKAltContactPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKPostMortemAuthorization"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKPostMortemAuthorizationReminder"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCoronerCaseNumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCoronerCounty"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCoronerReleased"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCoronerReleasedStipulations"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAutopsy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryAutopsyDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAutopsyTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAutopsyLocation"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAutopsyBloodRequested"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAutopsyCopyRequested"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFuneralHomeSelected"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFuneralHomeName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFuneralHomePhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFuneralHomeAddress"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFuneralHomeContact"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFuneralHomeNotified"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFuneralHomeMorgueCooled"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryHoldOnBody"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryHoldOnBodyTag"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryBodyRefrigerationDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyRefrigerationTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyLocation"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyMedicalChartLocation"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyIDTagLocation"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyCoolingMethod"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryUNOSNumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryClientNumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCryolifeNumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryMTFNumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryLifeNetNumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFreeText"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryHistorySubstanceAbuse"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondarySubstanceAbuseDetail"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryExtubationDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryExtubationTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAutopsyReminderYN"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryFHReminderYN"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyCareReminderYN"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryWrapUpReminderYN"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKNotifiedBy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryNOKNotifiedDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKNotifiedTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryNOKGender"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCODOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAutopsyLocationOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientHospitalPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCoronerCase"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientABO"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryPatientSuffix"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryMDAttendingId"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAdditionalComments"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryRhythm"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAdditionalMedications"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryBodyHoldPlaced"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyHoldPlacedWith"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyFutureContact"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyHoldPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyHoldInstructionsGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondarySteroid"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBodyHoldPlacedTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic1Name"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic1Dose"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic1StartDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic1EndDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic2Name"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic2Dose"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic2StartDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic2EndDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic3Name"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic3Dose"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic3StartDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic3EndDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic4Name"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic4Dose"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic4StartDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic4EndDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic5Name"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic5Dose"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic5StartDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic5EndDate"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived1Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived1Units"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived1TypeCC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived1TypeUnitGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived2Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived2Units"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived2TypeCC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived2TypeUnitGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived3Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived3Units"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived3TypeCC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived3TypeUnitGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused1Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused1Units"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused1CC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused1UnitGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused2Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused2Units"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused2CC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused2UnitGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused3Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused3Units"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused3CC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused3UnitGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids1Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids1Units"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids1CC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids1UnitGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids2Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids2Units"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids2CC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids2UnitGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids3Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids3Units"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids3CC"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids3UnitGiven"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryWBC1Date"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryWBC1"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryWBC1Bands"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryWBC2Date"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryWBC2"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryWBC2Bands"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryWBC3Date"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryWBC3"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryWBC3Bands"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryLabTemp1"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryLabTemp1Date"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryLabTemp1Time"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryLabTemp2"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryLabTemp2Date"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryLabTemp2Time"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryLabTemp3"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryLabTemp3Date"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryLabTemp3Time"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCulture1Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCulture1Other"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryCulture1DrawnDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCulture1Growth"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCulture2Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCulture2Other"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryCulture2DrawnDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCulture2Growth"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCulture3Type"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCulture3Other"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryCulture3DrawnDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCulture3Growth"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCXRAvailable"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryCXR1Date"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCXR1Finding"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryCXR2Date"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCXR2Finding"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:SecondaryCXR3Date"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCXR3Finding"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic1NameOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic2NameOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic3NameOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic4NameOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryAntibiotic5NameOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived1TypeOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived2TypeOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryBloodProductsReceived3TypeOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused1TypeOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused2TypeOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryColloidsInfused3TypeOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids1TypeOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids2TypeOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryCrystalloids3TypeOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryApproached"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryApproachedBy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryApproachType"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryApproachOutcome"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryApproachReason"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryConsented"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryConsentBy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryConsentOutcome"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryConsentResearch"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryRecoveryLocation"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryHospitalApproach"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryHospitalApproachedBy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryHospitalOutcome"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryConsentMedSocPaperwork"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryConsentMedSocObtainedBy"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryConsentFuneralPlans"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryConsentFuneralPlansOther"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:SecondaryConsentLongSleeves"/>
    <!-- do not include a columnDelimeter on end of column definition templateds-->
  </xsl:template>
  <xsl:template name="ExtendedReferralDetail2006">
    <xsl:param name="referralDetailDataTable" />
    <!-- Calls the previous file version-->
    <xsl:call-template name="ExtendedReferralDetailFS" >
      <xsl:with-param name="referralDetailDataTable" select="exsl:node-set($referralDetailDataTable)" />
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <!--Note: The named templates below with an error can be ignored included in another xslt include list -->
    <xsl:value-of select="ds:ReferralDonor_ILB"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="SetFieldLength">
      <xsl:with-param name="fieldValue" select="ds:ReferralDonorSpecificCOD"/>
      <xsl:with-param name="fieldLength" select="400"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:ReferralDonorBrainDeathDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorBrainDeathTime"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralAttendingMDPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralPronouncingMDPhone"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CurrentReferralTypeID"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:MedicalHistory"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:NOKFirstName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:NOKLastName"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:NOKCity"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:NOKState"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:NOKZip"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorNameMI"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:CoronorsCase"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralNOKAddress"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:PatientWeight_Decimal"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:TBINumber"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:TBINotNeeded"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:TBIComment"/>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:ReferralDonorLSADate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralDonorLSATime"/>
    <!-- do not include a columnDelimeter on end of column definition templates-->
  </xsl:template>
  <xsl:template name="ExtendedReferralDetail2020">
    <xsl:param name="referralDetailDataTable" />
    <!-- Calls the previous file version-->
    <xsl:call-template name="ExtendedReferralDetail2006" >
      <xsl:with-param name="referralDetailDataTable" select="exsl:node-set($referralDetailDataTable)" />
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <!--Note: The named templates below with an error can be ignored included in another xslt include list -->
    <xsl:call-template name="FormatDate">
      <xsl:with-param name="DateTime" select="ds:ReferralExtubatedDate"/>
    </xsl:call-template>
    <xsl:copy-of select="$columnDelimeter"/>
    <xsl:value-of select="ds:ReferralExtubatedTime"/>
    <!-- do not include a columnDelimeter on end of column definition templates-->
  </xsl:template>
</xsl:stylesheet>
