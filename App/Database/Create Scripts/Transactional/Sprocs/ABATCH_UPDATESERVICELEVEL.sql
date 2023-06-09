IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'ABATCH_UPDATESERVICELEVEL')
	BEGIN
		PRINT 'Dropping ABATCH_UPDATESERVICELEVEL'
		DROP  Procedure  ABATCH_UPDATESERVICELEVEL
	END

GO

PRINT 'Creating Procedure ABATCH_UPDATESERVICELEVEL'
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE ABATCH_UPDATESERVICELEVEL

AS

/******************************************************************************
**		File: ABATCH_UPDATESERVICELEVEL.sql
**		Name: ABATCH_UPDATESERVICELEVEL
**		Desc: 
**
**		Notes:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------		-------------------------------------------
**      06/06/2007		ccarroll		added TBIPrefix
**      06/10/2007		Thien Ta		added VerifySex,VerifyWeight
**		07/10/2008		ccarroll		added ServiceLevelBillApproachOnly
**      10/2010         jim h           replaced getting the id with max method to using scope_identity
**		09/13/2011		ccarroll		Added ServiceLevelPNEAllowSaveWithoutContactRequired
**		02/05/2018		mberenson		Added ServiceLevelDCDPotentialMessageEnabled
**		10/04/2018		Serge Hurko		#61432 - Add Pending Case setting to the Screen Configuration (Service Level) screen.
*******************************************************************************/

declare @NewServiceLevelId int,
	@i int,
	@Working_Status smallint,
	@Current_Status smallint,
	@Historical_Status smallint,
	@Original_Status smallint,
	@UpdatedFlag_On smallint,
	@UpdatedFlag_Off smallint,
	
	@ServiceLevelID int,
	@ServiceLevelGroupName varchar(80),
	@ServiceLevelTriageLevel smallint,
	@ServiceLevelOTEMROLevel smallint,
	@ServiceLevelTEMROLevel smallint,
	@ServiceLevelEMROLevel smallint,
	@ServiceLevelLastName smallint,
	@ServiceLevelFirstName smallint,
	@ServiceLevelRecNum smallint,
	@ServiceLevelSSN smallint,
	@ServiceLevelGender smallint,
	@ServiceLevelAge smallint,
	@ServiceLevelWeight smallint,
	@ServiceLevelWeightAgeLimit numeric(3, 0),
	@ServiceLevelRace smallint,
	@ServiceLevelVent smallint,
	@ServiceLevelPrevVentClass smallint,
	@ServiceLevelDead smallint,
	@ServiceLevelDeathDate smallint,
	@ServiceLevelDeathTime smallint,
	@ServiceLevelAdmitDate smallint,
	@ServiceLevelAdmitTime smallint,
	@ServiceLevelCOD smallint,
	@ServiceLevelDOB smallint,
	@ServiceLevelDOA smallint,
	@ServiceLevelCoroner smallint,
	@ServiceLevelAttendingMD smallint,
	@ServiceLevelPronouncingMD smallint,
	@ServiceLevelApproachMethod smallint,
	@ServiceLevelApproachBy smallint,
	@ServiceLevelApproachOTEPrompt smallint,
	@ServiceLevelApproachTEPrompt smallint,
	@ServiceLevelApproachEPrompt smallint,
	@ServiceLevelApproachROPrompt smallint,
	@ServiceLevelNOK smallint,
	@ServiceLevelRelation smallint,
	@ServiceLevelNOKPhone smallint,
	@ServiceLevelNOKConsent smallint,
	@ServiceLevelNOKRegistration smallint,
	@ServiceLevelNOKAddress smallint,
	@ServiceLevelAppropriateOrgan smallint,
	@ServiceLevelAppropriateBone smallint,
	@ServiceLevelAppropriateTissue smallint,
	@ServiceLevelAppropriateSkin smallint,
	@ServiceLevelAppropriateValves smallint,
	@ServiceLevelAppropriateEyes smallint,
	@ServiceLevelAppropriateRsch smallint,
	@ServiceLevelApproachOrgan smallint,
	@ServiceLevelApproachBone smallint,
	@ServiceLevelApproachTissue smallint,
	@ServiceLevelApproachSkin smallint,
	@ServiceLevelApproachValves smallint,
	@ServiceLevelApproachEyes smallint,
	@ServiceLevelApproachRsch smallint,
	@ServiceLevelConsentOrgan smallint,
	@ServiceLevelConsentBone smallint,
	@ServiceLevelConsentTissue smallint,
	@ServiceLevelConsentSkin smallint,
	@ServiceLevelConsentValves smallint,
	@ServiceLevelConsentEyes smallint,
	@ServiceLevelConsentRsch smallint,
	@ServiceLevelRecoveryOrgan smallint,
	@ServiceLevelRecoveryBone smallint,
	@ServiceLevelRecoveryTissue smallint,
	@ServiceLevelRecoverySkin smallint,
	@ServiceLevelRecoveryValves smallint,
	@ServiceLevelRecoveryEyes smallint,
	@ServiceLevelRecoveryRsch smallint,
	@LastModified datetime,
	@ServiceLevelExcludePrevVent smallint,
	@ServiceLevelCheckRegistry smallint,
	@ServiceLevelDonorIntentFaxYN smallint,
	@ServiceLevelDonorIntentNurseScript varchar(255),
	@ServiceLevelDonorIntentOrganizationId int,
	@ServiceLevelDonorIntentFaxId int,
	@ServiceLevelDonorIntentPersonId int,
	@ServiceLevelDonorIntentRetries int,
	@ServiceLevelDonorIntentDocumentName varchar(50),
	@ServiceLevelRegCheckRegistry smallint,
	@ServiceLevelStatus smallint,
	@WorkingStatusUpdatedFlag smallint,
	@WorkingServiceLevelId int,
	@ServiceLevelEyeCareReminder varchar(255),
	-- 01/07/04 mds Added HeartBeat field
	@ServiceLevelHeartBeat smallint,
	
	@ServiceLevelSourceCodeID int,
	@SLSCServiceLevelID int,
	@SourceCodeID int,
	@Unused int,
	@SLSCLastModified smalldatetime,
	@SLSCUpdatedFlag smallint,
	
	@ServiceLevelOrganizationID int,
	@SLOServiceLevelID int,
	@OrganizationID int,
	@SLOLastModified datetime,
	@SLOUpdatedFlag smallint,
	
	@SLCFServiceLevelID int,
	@ServiceLevelCustomOn smallint,
	@ServiceLevelCustomTextAlert varchar(255),
	@ServiceLevelCustomListAlert varchar(255),
	@ServiceLevelCustomFieldLabel1 varchar(40),
	@ServiceLevelCustomFieldLabel2 varchar(40),
	@ServiceLevelCustomFieldLabel3 varchar(40),
	@ServiceLevelCustomFieldLabel4 varchar(40),
	@ServiceLevelCustomFieldLabel5 varchar(40),
	@ServiceLevelCustomFieldLabel6 varchar(40),
	@ServiceLevelCustomFieldLabel7 varchar(40),
	@ServiceLevelCustomFieldLabel8 varchar(40),
	@ServiceLevelCustomFieldLabel9 varchar(40),
	@ServiceLevelCustomFieldLabel10 varchar(40),
	@ServiceLevelCustomFieldLabel11 varchar(40),
	@ServiceLevelCustomFieldLabel12 varchar(40),
	@ServiceLevelCustomFieldLabel13 varchar(40),
	@ServiceLevelCustomFieldLabel14 varchar(40),
	@ServiceLevelCustomFieldLabel15 varchar(40),
	@ServiceLevelCustomFieldLabel16 varchar(40),
	@SLCFLastModified datetime,
	
	@SLCLServiceLevelID int,
	@ServiceLevelListField smallint,
	@ServiceLevelListItem varchar(40),
	@ServiceLevelCustomListID int,
	@SLCLLastModified smalldatetime,

	@SLSServiceLevelID int,
	@ServiceLevelSecondaryOn smallint,
	@ServiceLevelSecondaryAlert varchar(750),
	@ServiceLevelSecondaryHistory smallint,
	@ServiceLevelSecondaryHemodilution smallint,
	@SLSLastModified smalldatetime,
	@ServiceLevelSecondaryTBIPrefix varchar(2), --ccarroll 06/06/2007 StatTrac 8.4 requirement 3.6 - TBI

	@ServiceLevelDRDSNID int,
	@DRDSNID smallint,
	@SLDServiceLevelID int,
	@SLDLastModified smalldatetime,
	@SLDCreateDate smalldatetime,

	@ServiceLevelEmailDisposition smallint,

	@ServiceLevelDonorBrainDeathDate smallint,
	@ServiceLevelDonorBrainDeathTime smallint,
	@ServiceLevelPronouncingMDPhone smallint,
	@ServiceLevelAttendingMDPhone smallint,
	@ServiceLevelDOB_ILB smallint,
	@ServiceLevelDonorNameMI smallint,
	@ServiceLevelDonorSpecificCOD smallint,
	@ServiceLevelApproachLevel smallint,
	@ServiceLeveldisableASPSave smallint,
	@ServiceLevelAlwaysPopRegistry smallint,
	@ServiceLevelBillSecondaryManualEnable smallint,  --ccarroll StatTrac 8.4 release requirement 3.2
	@ServiceLevelBillFamilyApproachManualEnable smallint, --ccarroll StatTrac 8.4 release requirement 3.2
	@ServiceLevelBillMedSocManualEnable smallint,  --ccarroll StatTrac 8.4 release requirement 3.2
	@ServiceLevelVerifyWeight smallint,	-- T.T release 8.4 requirement 2.4
	@ServiceLevelVerifySex smallint,		-- T.T release 8.4 requirement 2.4
	@ServiceLevelBillApproachOnly smallint, -- ccarroll StatTrac 8.4.6 release
	@ServiceLevelPNEAllowSaveWithoutContactRequired smallint, -- ccarroll CCRST151  
	@ServiceLevelDCDPotentialMessageEnabled smallint,
	@ServiceLevelPendingCase smallint
	
	
	select @Working_Status = 0
	select @Current_Status = 1
	select @Historical_Status = 2
	select @Original_Status = 3
	select @UpdatedFlag_Off = 0
	select @UpdatedFlag_On = 1


/* SERVICELEVEL ******************************************************************************************************************************/
--GET WORKING CRITERIA WHOSE UPDATED FLAG IS TURNED ON
declare cServiceLevel cursor for 
  select * from ServiceLevel where servicelevelstatus = @Working_Status
  and workingstatusupdatedflag = @UpdatedFlag_On

-- 01/07/04 mds Added @ServiceLevelHeartBeat field to the end of the INTO statement
-- 06/27/05 C.Chaput - Added new referral screen fields. MD Phones, Brain Death Date/time,Specific COD, Patient MI
open cServiceLevel
fetch next from cServiceLevel into @ServiceLevelID,@ServiceLevelGroupName,@ServiceLevelTriageLevel,@ServiceLevelOTEMROLevel,@ServiceLevelTEMROLevel,@ServiceLevelEMROLevel,@ServiceLevelLastName,@ServiceLevelFirstName,@ServiceLevelRecNum,@ServiceLevelSSN,@ServiceLevelGender,@ServiceLevelAge,@ServiceLevelWeight,@ServiceLevelWeightAgeLimit,@ServiceLevelRace,@ServiceLevelVent,@ServiceLevelPrevVentClass,@ServiceLevelDead,@ServiceLevelDeathDate,@ServiceLevelDeathTime,@ServiceLevelAdmitDate,@ServiceLevelAdmitTime,@ServiceLevelCOD,@ServiceLevelDOB,@ServiceLevelDOA,@ServiceLevelCoroner,@ServiceLevelAttendingMD,@ServiceLevelPronouncingMD,@ServiceLevelApproachMethod,@ServiceLevelApproachBy,@ServiceLevelApproachOTEPrompt,@ServiceLevelApproachTEPrompt,@ServiceLevelApproachEPrompt,@ServiceLevelApproachROPrompt,@ServiceLevelNOK,@ServiceLevelRelation,@ServiceLevelNOKPhone,@ServiceLevelNOKAddress,@ServiceLevelAppropriateOrgan,@ServiceLevelAppropriateBone,@ServiceLevelAppropriateTissue,@ServiceLevelAppropriateSkin,@ServiceLevelAppropriateValves,@ServiceLevelAppropriateEyes,@ServiceLevelAppropriateRsch,@ServiceLevelApproachOrgan,@ServiceLevelApproachBone,@ServiceLevelApproachTissue,@ServiceLevelApproachSkin,@ServiceLevelApproachValves,@ServiceLevelApproachEyes,@ServiceLevelApproachRsch,@ServiceLevelConsentOrgan,@ServiceLevelConsentBone,@ServiceLevelConsentTissue,@ServiceLevelConsentSkin,@ServiceLevelConsentValves,@ServiceLevelConsentEyes,@ServiceLevelConsentRsch,@ServiceLevelRecoveryOrgan,@ServiceLevelRecoveryBone,@ServiceLevelRecoveryTissue,@ServiceLevelRecoverySkin,@ServiceLevelRecoveryValves,@ServiceLevelRecoveryEyes,@ServiceLevelRecoveryRsch,@LastModified,@ServiceLevelExcludePrevVent,@ServiceLevelCheckRegistry,@ServiceLevelDonorIntentFaxYN,@ServiceLevelDonorIntentNurseScript,@ServiceLevelDonorIntentOrganizationId,@ServiceLevelDonorIntentFaxId,@ServiceLevelDonorIntentPersonId,@ServiceLevelDonorIntentRetries,@ServiceLevelDonorIntentDocumentName,@ServiceLevelRegCheckRegistry,@ServiceLevelStatus,@WorkingStatusUpdatedFlag,@WorkingServiceLevelId, @ServiceLevelEyeCareReminder, @ServiceLevelHeartBeat,@ServiceLevelNOKConsent,@ServiceLevelNOKRegistration,@ServiceLevelEmailDisposition,@ServiceLevelDonorBrainDeathDate,@ServiceLevelDonorBrainDeathTime,@ServiceLevelPronouncingMDPhone,@ServiceLevelAttendingMDPhone,@ServiceLevelDOB_ILB,@ServiceLevelDonorNameMI,@ServiceLevelDonorSpecificCOD,@ServiceLevelApproachLevel,@ServiceLevelDisableASPSave,@ServiceLevelAlwaysPopRegistry, @ServiceLevelBillSecondaryManualEnable, @ServiceLevelBillFamilyApproachManualEnable, @ServiceLevelBillMedSocManualEnable, @ServiceLevelVerifyWeight, @ServiceLevelVerifySex, @ServiceLevelBillApproachOnly, @ServiceLevelPNEAllowSaveWithoutContactRequired, @ServiceLevelDCDPotentialMessageEnabled, @ServiceLevelPendingCase
	
while @@fetch_status = 0
  begin
  
    	--TURN OFF SERVICELEVEL'S UPDATED FLAG
	update servicelevel
	set workingstatusupdatedflag = @UpdatedFlag_Off
	where servicelevelid = @ServiceLevelId

	--CHANGE THE EXISTING CURRENT SERVICELEVEL's STATUS TO HISTORICAL
	update servicelevel
	set servicelevelstatus = @Historical_Status
	where servicelevelstatus = @Current_Status
    	and workingservicelevelid = @ServiceLevelId
  
    -- 01/07/04 mds Added ServiceLevelHeartBeat to the end of the INSERT and VALUES statements
    -- Added @ServiceLevelEmailDisposition to INSERT and VALUES statements.  Ver. 7.7.2 12/09/04 - SAP
    --06/27/05 C.Chaput - Added new referral screen fields. MD Phones, Brain Death Date/time,Specific COD, Patient MI
    --MAKE A COPY OF THE WORKING CRITERIA AND MAKE IT THE NEW CURRENT CRITERIA
    insert servicelevel(ServiceLevelGroupName,ServiceLevelTriageLevel,ServiceLevelOTEMROLevel,ServiceLevelTEMROLevel,ServiceLevelEMROLevel,ServiceLevelLastName,ServiceLevelFirstName,ServiceLevelRecNum,ServiceLevelSSN,ServiceLevelGender,ServiceLevelAge,ServiceLevelWeight,ServiceLevelWeightAgeLimit,ServiceLevelRace,ServiceLevelVent,ServiceLevelPrevVentClass,ServiceLevelDead,ServiceLevelDeathDate,ServiceLevelDeathTime,ServiceLevelAdmitDate,ServiceLevelAdmitTime,ServiceLevelCOD,ServiceLevelDOB,ServiceLevelDOA,ServiceLevelCoroner,ServiceLevelAttendingMD,ServiceLevelPronouncingMD,ServiceLevelApproachMethod,ServiceLevelApproachBy,ServiceLevelApproachOTEPrompt,ServiceLevelApproachTEPrompt,ServiceLevelApproachEPrompt,ServiceLevelApproachROPrompt,ServiceLevelNOK,ServiceLevelRelation,ServiceLevelNOKPhone,ServiceLevelNOKAddress,ServiceLevelAppropriateOrgan,ServiceLevelAppropriateBone,ServiceLevelAppropriateTissue,ServiceLevelAppropriateSkin,ServiceLevelAppropriateValves,ServiceLevelAppropriateEyes,ServiceLevelAppropriateRsch,ServiceLevelApproachOrgan,ServiceLevelApproachBone,ServiceLevelApproachTissue,ServiceLevelApproachSkin,ServiceLevelApproachValves,ServiceLevelApproachEyes,ServiceLevelApproachRsch,ServiceLevelConsentOrgan,ServiceLevelConsentBone,ServiceLevelConsentTissue,ServiceLevelConsentSkin,ServiceLevelConsentValves,ServiceLevelConsentEyes,ServiceLevelConsentRsch,ServiceLevelRecoveryOrgan,ServiceLevelRecoveryBone,ServiceLevelRecoveryTissue,ServiceLevelRecoverySkin,ServiceLevelRecoveryValves,ServiceLevelRecoveryEyes,ServiceLevelRecoveryRsch,LastModified,ServiceLevelExcludePrevVent,ServiceLevelCheckRegistry,ServiceLevelDonorIntentFaxYN,ServiceLevelDonorIntentNurseScript,ServiceLevelDonorIntentOrganizationId,ServiceLevelDonorIntentFaxId,ServiceLevelDonorIntentPersonId,ServiceLevelDonorIntentRetries,ServiceLevelDonorIntentDocumentName,ServiceLevelRegCheckRegistry,ServiceLevelStatus,WorkingStatusUpdatedFlag,WorkingServiceLevelId,ServiceLevelEyeCareReminder,ServiceLevelHeartBeat,ServiceLevelNOKConsent,ServiceLevelNOKRegistration,ServiceLevelEmailDisposition,ServiceLevelDonorBrainDeathDate,ServiceLevelDonorBrainDeathTime,ServiceLevelPronouncingMDPhone,ServiceLevelAttendingMDPhone,ServiceLevelDOB_ILB,ServiceLevelDonorNameMI,ServiceLevelDonorSpecificCOD,ServiceLevelApproachLevel,ServiceLevelDisableASPSave,ServiceLevelAlwaysPopRegistry, ServiceLevelBillSecondaryManualEnable, ServiceLevelBillFamilyApproachManualEnable, ServiceLevelBillMedSocManualEnable,ServiceLevelVerifyWeight,ServiceLevelVerifySex, ServiceLevelBillApproachOnly, ServiceLevelPNEAllowSaveWithoutContactRequired, ServiceLevelDCDPotentialMessageEnabled, ServiceLevelPendingCase)
    values(@ServiceLevelGroupName,@ServiceLevelTriageLevel,@ServiceLevelOTEMROLevel,@ServiceLevelTEMROLevel,@ServiceLevelEMROLevel,@ServiceLevelLastName,@ServiceLevelFirstName,@ServiceLevelRecNum,@ServiceLevelSSN,@ServiceLevelGender,@ServiceLevelAge,@ServiceLevelWeight,@ServiceLevelWeightAgeLimit,@ServiceLevelRace,@ServiceLevelVent,@ServiceLevelPrevVentClass,@ServiceLevelDead,@ServiceLevelDeathDate,@ServiceLevelDeathTime,@ServiceLevelAdmitDate,@ServiceLevelAdmitTime,@ServiceLevelCOD,@ServiceLevelDOB,@ServiceLevelDOA,@ServiceLevelCoroner,@ServiceLevelAttendingMD,@ServiceLevelPronouncingMD,@ServiceLevelApproachMethod,@ServiceLevelApproachBy,@ServiceLevelApproachOTEPrompt,@ServiceLevelApproachTEPrompt,@ServiceLevelApproachEPrompt,@ServiceLevelApproachROPrompt,@ServiceLevelNOK,@ServiceLevelRelation,@ServiceLevelNOKPhone,@ServiceLevelNOKAddress,@ServiceLevelAppropriateOrgan,@ServiceLevelAppropriateBone,@ServiceLevelAppropriateTissue,@ServiceLevelAppropriateSkin,@ServiceLevelAppropriateValves,@ServiceLevelAppropriateEyes,@ServiceLevelAppropriateRsch,@ServiceLevelApproachOrgan,@ServiceLevelApproachBone,@ServiceLevelApproachTissue,@ServiceLevelApproachSkin,@ServiceLevelApproachValves,@ServiceLevelApproachEyes,@ServiceLevelApproachRsch,@ServiceLevelConsentOrgan,@ServiceLevelConsentBone,@ServiceLevelConsentTissue,@ServiceLevelConsentSkin,@ServiceLevelConsentValves,@ServiceLevelConsentEyes,@ServiceLevelConsentRsch,@ServiceLevelRecoveryOrgan,@ServiceLevelRecoveryBone,@ServiceLevelRecoveryTissue,@ServiceLevelRecoverySkin,@ServiceLevelRecoveryValves,@ServiceLevelRecoveryEyes,@ServiceLevelRecoveryRsch,@LastModified,@ServiceLevelExcludePrevVent,@ServiceLevelCheckRegistry,@ServiceLevelDonorIntentFaxYN,@ServiceLevelDonorIntentNurseScript,@ServiceLevelDonorIntentOrganizationId,@ServiceLevelDonorIntentFaxId,@ServiceLevelDonorIntentPersonId,@ServiceLevelDonorIntentRetries,@ServiceLevelDonorIntentDocumentName,@ServiceLevelRegCheckRegistry,@Current_Status,@UpdatedFlag_Off,@WorkingServiceLevelId,@ServiceLevelEyeCareReminder,@ServiceLevelHeartBeat,@ServiceLevelNOKConsent,@ServiceLevelNOKRegistration,@ServiceLevelEmailDisposition,@ServiceLevelDonorBrainDeathDate,@ServiceLevelDonorBrainDeathTime,@ServiceLevelPronouncingMDPhone,@ServiceLevelAttendingMDPhone,@ServiceLevelDOB_ILB,@ServiceLevelDonorNameMI,@ServiceLevelDonorSpecificCOD,@ServiceLevelApproachLevel,@ServiceLevelDisableASPSave,@ServiceLevelAlwaysPopRegistry, @ServiceLevelBillSecondaryManualEnable, @ServiceLevelBillFamilyApproachManualEnable, @ServiceLevelBillMedSocManualEnable,@ServiceLevelVerifyWeight,@ServiceLevelVerifySex, @ServiceLevelBillApproachOnly, @ServiceLevelPNEAllowSaveWithoutContactRequired, @ServiceLevelDCDPotentialMessageEnabled, @ServiceLevelPendingCase)
    --replaced getting the id with max method to using scope_identity 10/10 jim h
	SET @NewServiceLevelId = SCOPE_IDENTITY()
    --select @NewServiceLevelId = max(servicelevelid) from servicelevel

    /* SOURCECODES ******************************************************************************************************************************/
   declare cSOURCECODE cursor for 
      select * from servicelevelsourcecode where servicelevelid = @ServiceLevelId

    open cSOURCECODE
    fetch next from cSOURCECODE into @ServiceLevelSourceCodeID,@SLSCServiceLevelID,@SourceCodeID,@Unused,@SLSCLastModified,@SLSCUpdatedFlag
    
    while @@fetch_status = 0
    begin
    
      insert servicelevelsourcecode(ServiceLevelID,SourceCodeID,Unused,LastModified,UpdatedFlag)
      values(@NewServiceLevelID,@SourceCodeID,@Unused,@SLSCLastModified,@SLSCUpdatedFlag)
    
      fetch next from cSOURCECODE into @ServiceLevelSourceCodeID,@SLSCServiceLevelID,@SourceCodeID,@Unused,@SLSCLastModified,@SLSCUpdatedFlag
    end

    close cSOURCECODE

    deallocate cSOURCECODE


    /* ORGANIZATION ******************************************************************************************************************************/
    declare cORGANIZATION cursor for 
      select * from servicelevel30organization where servicelevelid = @ServiceLevelId

    open cORGANIZATION
    fetch next from cORGANIZATION into @ServiceLevelOrganizationID,@SLOServiceLevelID,@OrganizationID,@SLOLastModified,@SLOUpdatedFlag
    
    while @@fetch_status = 0
    begin
      insert servicelevel30organization(ServiceLevelID,OrganizationID,LastModified,UpdatedFlag)
      values(@NewServiceLevelID,@OrganizationID,@SLOLastModified,@SLOUpdatedFlag)
    
      fetch next from cORGANIZATION into @ServiceLevelOrganizationID,@SLOServiceLevelID,@OrganizationID,@SLOLastModified,@SLOUpdatedFlag
    end

    close cORGANIZATION
    deallocate cORGANIZATION

    /* CUSTOMFIELD ******************************************************************************************************************************/
    declare cCUSTOMFIELD cursor for 
      select * from servicelevelcustomfield where servicelevelid = @ServiceLevelId

    open cCUSTOMFIELD
    fetch next from cCUSTOMFIELD into @SLCFServiceLevelID,@ServiceLevelCustomOn,@ServiceLevelCustomTextAlert,@ServiceLevelCustomListAlert,@ServiceLevelCustomFieldLabel1,@ServiceLevelCustomFieldLabel2,@ServiceLevelCustomFieldLabel3,@ServiceLevelCustomFieldLabel4,@ServiceLevelCustomFieldLabel5,@ServiceLevelCustomFieldLabel6,@ServiceLevelCustomFieldLabel7,@ServiceLevelCustomFieldLabel8,@ServiceLevelCustomFieldLabel9,@ServiceLevelCustomFieldLabel10,@ServiceLevelCustomFieldLabel11,@ServiceLevelCustomFieldLabel12,@ServiceLevelCustomFieldLabel13,@ServiceLevelCustomFieldLabel14,@ServiceLevelCustomFieldLabel15,@ServiceLevelCustomFieldLabel16,@SLCFLastModified
    
    while @@fetch_status = 0
    begin
      insert servicelevelcustomfield(ServiceLevelID,ServiceLevelCustomOn,ServiceLevelCustomTextAlert,ServiceLevelCustomListAlert,ServiceLevelCustomFieldLabel1,ServiceLevelCustomFieldLabel2,ServiceLevelCustomFieldLabel3,ServiceLevelCustomFieldLabel4,ServiceLevelCustomFieldLabel5,ServiceLevelCustomFieldLabel6,ServiceLevelCustomFieldLabel7,ServiceLevelCustomFieldLabel8,ServiceLevelCustomFieldLabel9,ServiceLevelCustomFieldLabel10,ServiceLevelCustomFieldLabel11,ServiceLevelCustomFieldLabel12,ServiceLevelCustomFieldLabel13,ServiceLevelCustomFieldLabel14,ServiceLevelCustomFieldLabel15,ServiceLevelCustomFieldLabel16,LastModified)
      values(@NewServiceLevelID,@ServiceLevelCustomOn,@ServiceLevelCustomTextAlert,@ServiceLevelCustomListAlert,@ServiceLevelCustomFieldLabel1,@ServiceLevelCustomFieldLabel2,@ServiceLevelCustomFieldLabel3,@ServiceLevelCustomFieldLabel4,@ServiceLevelCustomFieldLabel5,@ServiceLevelCustomFieldLabel6,@ServiceLevelCustomFieldLabel7,@ServiceLevelCustomFieldLabel8,@ServiceLevelCustomFieldLabel9,@ServiceLevelCustomFieldLabel10,@ServiceLevelCustomFieldLabel11,@ServiceLevelCustomFieldLabel12,@ServiceLevelCustomFieldLabel13,@ServiceLevelCustomFieldLabel14,@ServiceLevelCustomFieldLabel15,@ServiceLevelCustomFieldLabel16,@SLCFLastModified)
    
      fetch next from cCUSTOMFIELD into @SLCFServiceLevelID,@ServiceLevelCustomOn,@ServiceLevelCustomTextAlert,@ServiceLevelCustomListAlert,@ServiceLevelCustomFieldLabel1,@ServiceLevelCustomFieldLabel2,@ServiceLevelCustomFieldLabel3,@ServiceLevelCustomFieldLabel4,@ServiceLevelCustomFieldLabel5,@ServiceLevelCustomFieldLabel6,@ServiceLevelCustomFieldLabel7,@ServiceLevelCustomFieldLabel8,@ServiceLevelCustomFieldLabel9,@ServiceLevelCustomFieldLabel10,@ServiceLevelCustomFieldLabel11,@ServiceLevelCustomFieldLabel12,@ServiceLevelCustomFieldLabel13,@ServiceLevelCustomFieldLabel14,@ServiceLevelCustomFieldLabel15,@ServiceLevelCustomFieldLabel16,@SLCFLastModified
    end

    close cCUSTOMFIELD
    deallocate cCUSTOMFIELD
  
    /* CUSTOMLIST ******************************************************************************************************************************/
    declare cCUSTOMLIST cursor for 
          select * from servicelevelcustomlist where servicelevelid = @ServiceLevelId
    
        open cCUSTOMLIST
        fetch next from cCUSTOMLIST into @SLCLServiceLevelID,@ServiceLevelListField,@ServiceLevelListItem,@ServiceLevelCustomListID,@SLCLLastModified
        
        while @@fetch_status = 0
        begin
          insert servicelevelcustomlist(ServiceLevelID,ServiceLevelListField,ServiceLevelListItem,LastModified)
          values(@NewServiceLevelID,@ServiceLevelListField,@ServiceLevelListItem,@SLCLLastModified)
        
          fetch next from cCUSTOMLIST into @SLCLServiceLevelID,@ServiceLevelListField,@ServiceLevelListItem,@ServiceLevelCustomListID,@SLCLLastModified
        end
    
        close cCUSTOMLIST
    	deallocate cCUSTOMLIST

    /* SECONDARY ******************************************************************************************************************************/
    declare cSecondary cursor for 
          select * from servicelevelsecondary where servicelevelid = @ServiceLevelId
    
        open cSecondary
        fetch next from cSecondary into @SLSServiceLevelID,@ServiceLevelSecondaryOn,@ServiceLevelSecondaryAlert,@ServiceLevelSecondaryHistory,@ServiceLevelSecondaryHemodilution,@SLSLastModified, @ServiceLevelSecondaryTBIPrefix
        
        while @@fetch_status = 0
        begin
          insert servicelevelsecondary(ServiceLevelID,ServiceLevelSecondaryOn,ServiceLevelSecondaryAlert,ServiceLevelSecondaryHistory,ServiceLevelSecondaryHemodilution,LastModified, ServiceLevelSecondaryTBIPrefix)
          values(@NewServiceLevelID,@ServiceLevelSecondaryOn,@ServiceLevelSecondaryAlert,@ServiceLevelSecondaryHistory,@ServiceLevelSecondaryHemodilution,@SLSLastModified,@ServiceLevelSecondaryTBIPrefix)
        
          fetch next from cSecondary into @SLSServiceLevelID,@ServiceLevelSecondaryOn,@ServiceLevelSecondaryAlert,@ServiceLevelSecondaryHistory,@ServiceLevelSecondaryHemodilution,@SLSLastModified, @ServiceLevelSecondaryTBIPrefix
        end
    
        close cSecondary
    	deallocate cSecondary
    	
    /* SECONDARYDATATREE ******************************************************************************************************************************/
           
      EXEC spi_ServiceLevelData @NewServiceLevelID, @ServiceLevelID
       
    /* *************************************************************************************************************************************************/


   /* DONOR REGISTRY DATASOURCE (DRDSN) ******************************************************************************************************************************/
    declare cDataSource cursor for 
          select * from serviceleveldrdsn where servicelevelid = @ServiceLevelId
    
        open cDataSource
        fetch next from cDataSource into @ServiceLevelDRDSNID,@DRDSNID,@SLDServiceLevelID,@SLDLastModified,@SLDCreateDate
        
        while @@fetch_status = 0
        begin
          insert serviceleveldrdsn(ServiceLevelID,DRDSNID,LastModified,CreateDate)
          values(@NewServiceLevelID,@DRDSNID,@SLDLastModified,@SLDCreateDate)
        
          fetch next from cDataSource into @ServiceLevelDRDSNID,@DRDSNID,@SLDServiceLevelID,@SLDLastModified,@SLDCreateDate
        end
    
        close cDataSource
    	deallocate cDataSource
    

    -- 1/13/04 mds Added @ServiceLevelHeartBeat field to the end of the INTO statement
    -- Added @ServiceLevelEmailDisposition to INTO statement.  Ver. 7.7.2 12/09/04 - SAP
    --06/27/05 C.Chaput - Added new referral screen fields. MD Phones, Brain Death Date/time,Specific COD, Patient MI
    fetch next from cServiceLevel into  @ServiceLevelID,@ServiceLevelGroupName,@ServiceLevelTriageLevel,@ServiceLevelOTEMROLevel,@ServiceLevelTEMROLevel,@ServiceLevelEMROLevel,@ServiceLevelLastName,@ServiceLevelFirstName,@ServiceLevelRecNum,@ServiceLevelSSN,@ServiceLevelGender,@ServiceLevelAge,@ServiceLevelWeight,@ServiceLevelWeightAgeLimit,@ServiceLevelRace,@ServiceLevelVent,@ServiceLevelPrevVentClass,@ServiceLevelDead,@ServiceLevelDeathDate,@ServiceLevelDeathTime,@ServiceLevelAdmitDate,@ServiceLevelAdmitTime,@ServiceLevelCOD,@ServiceLevelDOB,@ServiceLevelDOA,@ServiceLevelCoroner,@ServiceLevelAttendingMD,@ServiceLevelPronouncingMD,@ServiceLevelApproachMethod,@ServiceLevelApproachBy,@ServiceLevelApproachOTEPrompt,@ServiceLevelApproachTEPrompt,@ServiceLevelApproachEPrompt,@ServiceLevelApproachROPrompt,@ServiceLevelNOK,@ServiceLevelRelation,@ServiceLevelNOKPhone,@ServiceLevelNOKAddress,@ServiceLevelAppropriateOrgan,@ServiceLevelAppropriateBone,@ServiceLevelAppropriateTissue,@ServiceLevelAppropriateSkin,@ServiceLevelAppropriateValves,@ServiceLevelAppropriateEyes,@ServiceLevelAppropriateRsch,@ServiceLevelApproachOrgan,@ServiceLevelApproachBone,@ServiceLevelApproachTissue,@ServiceLevelApproachSkin,@ServiceLevelApproachValves,@ServiceLevelApproachEyes,@ServiceLevelApproachRsch,@ServiceLevelConsentOrgan,@ServiceLevelConsentBone,@ServiceLevelConsentTissue,@ServiceLevelConsentSkin,@ServiceLevelConsentValves,@ServiceLevelConsentEyes,@ServiceLevelConsentRsch,@ServiceLevelRecoveryOrgan,@ServiceLevelRecoveryBone,@ServiceLevelRecoveryTissue,@ServiceLevelRecoverySkin,@ServiceLevelRecoveryValves,@ServiceLevelRecoveryEyes,@ServiceLevelRecoveryRsch,@LastModified,@ServiceLevelExcludePrevVent,@ServiceLevelCheckRegistry,@ServiceLevelDonorIntentFaxYN,@ServiceLevelDonorIntentNurseScript,@ServiceLevelDonorIntentOrganizationId,@ServiceLevelDonorIntentFaxId,@ServiceLevelDonorIntentPersonId,@ServiceLevelDonorIntentRetries,@ServiceLevelDonorIntentDocumentName,@ServiceLevelRegCheckRegistry,@ServiceLevelStatus,@WorkingStatusUpdatedFlag,@WorkingServiceLevelId, @ServiceLevelEyeCareReminder, @ServiceLevelHeartBeat,@ServiceLevelNOKConsent,@ServiceLevelNOKRegistration,@ServiceLevelEmailDisposition,@ServiceLevelDonorBrainDeathDate,@ServiceLevelDonorBrainDeathTime,@ServiceLevelPronouncingMDPhone,@ServiceLevelAttendingMDPhone,@ServiceLevelDOB_ILB,@ServiceLevelDonorNameMI,@ServiceLevelDonorSpecificCOD,@ServiceLevelApproachLevel,@ServiceLevelDisableASPSave,@ServiceLevelAlwaysPopRegistry, @ServiceLevelBillSecondaryManualEnable, @ServiceLevelBillFamilyApproachManualEnable, @ServiceLevelBillMedSocManualEnable, @ServiceLevelVerifyWeight, @ServiceLevelVerifySex, @ServiceLevelBillApproachOnly, @ServiceLevelPNEAllowSaveWithoutContactRequired, @ServiceLevelDCDPotentialMessageEnabled, @ServiceLevelPendingCase
  end
close cServiceLevel
deallocate cServiceLevel

--FOR TESTING ONLY; REMOVE TO GO LIVE
--select "ok"
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
