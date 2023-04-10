
		/******************************************************************************
		**	File: ServiceLevel.sql
		**	Name: AlterServiceLevel
		**	Desc: Create table and add default columns for the table ServiceLevel
		**	Auth: ccarroll
		**	Date: 12/14/2009
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to ServiceLevel'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'ServiceLevel')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'ServiceLevel'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ServiceLevel]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[ServiceLevel]
			(
			ServiceLevelID int IDENTITY(1,1) NOT NULL, 
			ServiceLevelGroupName varchar(80) NULL, 
			ServiceLevelTriageLevel smallint NULL, 
			ServiceLevelOTEMROLevel smallint NULL, 
			ServiceLevelTEMROLevel smallint NULL, 
			ServiceLevelEMROLevel smallint NULL, 
			ServiceLevelLastName smallint NULL, 
			ServiceLevelFirstName smallint NULL, 
			ServiceLevelRecNum smallint NULL, 
			ServiceLevelSSN smallint NULL, 
			ServiceLevelGender smallint NULL, 
			ServiceLevelAge smallint NULL, 
			ServiceLevelWeight smallint NULL, 
			ServiceLevelWeightAgeLimit numeric(3,0) NULL, 
			ServiceLevelRace smallint NULL, 
			ServiceLevelVent smallint NULL, 
			ServiceLevelPrevVentClass smallint NULL, 
			ServiceLevelDead smallint NULL, 
			ServiceLevelDeathDate smallint NULL, 
			ServiceLevelDeathTime smallint NULL, 
			ServiceLevelAdmitDate smallint NULL, 
			ServiceLevelAdmitTime smallint NULL, 
			ServiceLevelCOD smallint NULL, 
			ServiceLevelDOB smallint NULL, 
			ServiceLevelDOA smallint NULL, 
			ServiceLevelCoroner smallint NULL, 
			ServiceLevelAttendingMD smallint NULL, 
			ServiceLevelPronouncingMD smallint NULL, 
			ServiceLevelApproachMethod smallint NULL, 
			ServiceLevelApproachBy smallint NULL, 
			ServiceLevelApproachOTEPrompt smallint NULL, 
			ServiceLevelApproachTEPrompt smallint NULL, 
			ServiceLevelApproachEPrompt smallint NULL, 
			ServiceLevelApproachROPrompt smallint NULL, 
			ServiceLevelNOK smallint NULL, 
			ServiceLevelRelation smallint NULL, 
			ServiceLevelNOKPhone smallint NULL, 
			ServiceLevelNOKAddress smallint NULL, 
			ServiceLevelAppropriateOrgan smallint NULL, 
			ServiceLevelAppropriateBone smallint NULL, 
			ServiceLevelAppropriateTissue smallint NULL, 
			ServiceLevelAppropriateSkin smallint NULL, 
			ServiceLevelAppropriateValves smallint NULL, 
			ServiceLevelAppropriateEyes smallint NULL, 
			ServiceLevelAppropriateRsch smallint NULL, 
			ServiceLevelApproachOrgan smallint NULL, 
			ServiceLevelApproachBone smallint NULL, 
			ServiceLevelApproachTissue smallint NULL, 
			ServiceLevelApproachSkin smallint NULL, 
			ServiceLevelApproachValves smallint NULL, 
			ServiceLevelApproachEyes smallint NULL, 
			ServiceLevelApproachRsch smallint NULL, 
			ServiceLevelConsentOrgan smallint NULL, 
			ServiceLevelConsentBone smallint NULL, 
			ServiceLevelConsentTissue smallint NULL, 
			ServiceLevelConsentSkin smallint NULL, 
			ServiceLevelConsentValves smallint NULL, 
			ServiceLevelConsentEyes smallint NULL, 
			ServiceLevelConsentRsch smallint NULL, 
			ServiceLevelRecoveryOrgan smallint NULL, 
			ServiceLevelRecoveryBone smallint NULL, 
			ServiceLevelRecoveryTissue smallint NULL, 
			ServiceLevelRecoverySkin smallint NULL, 
			ServiceLevelRecoveryValves smallint NULL, 
			ServiceLevelRecoveryEyes smallint NULL, 
			ServiceLevelRecoveryRsch smallint NULL, 
			LastModified datetime NULL, 
			ServiceLevelExcludePrevVent smallint NULL, 
			ServiceLevelCheckRegistry smallint NULL, 
			ServiceLevelDonorIntentFaxYN smallint NULL, 
			ServiceLevelDonorIntentNurseScript varchar(255) NULL, 
			ServiceLevelDonorIntentOrganizationId int NULL, 
			ServiceLevelDonorIntentFaxId int NULL, 
			ServiceLevelDonorIntentPersonId int NULL, 
			ServiceLevelDonorIntentRetries int NULL, 
			ServiceLevelDonorIntentDocumentName varchar(50) NULL, 
			ServiceLevelRegCheckRegistry smallint NULL, 
			ServiceLevelStatus smallint NULL, 
			WorkingStatusUpdatedFlag smallint NULL, 
			WorkingServiceLevelId int NULL, 
			ServiceLevelEyeCareReminder varchar(255) NULL, 
			ServiceLevelHeartBeat smallint NULL, 
			ServiceLevelNOKConsent smallint NULL, 
			ServiceLevelNOKRegistration smallint NULL, 
			ServiceLevelEmailDisposition smallint NULL, 
			ServiceLevelDonorBrainDeathDate smallint NULL, 
			ServiceLevelDonorBrainDeathTime smallint NULL, 
			ServiceLevelPronouncingMDPhone smallint NULL, 
			ServiceLevelAttendingMDPhone smallint NULL, 
			ServiceLevelDOB_ILB smallint NULL, 
			ServiceLevelDonorNameMI smallint NULL, 
			ServiceLevelDonorSpecificCOD smallint NULL, 
			ServiceLevelApproachLevel int NULL, 
			ServiceLevelDisableASPSave int NULL, 
			ServiceLevelAlwaysPopRegistry smallint NULL, 
			ServiceLevelBillSecondaryManualEnable smallint NULL, 
			ServiceLevelBillFamilyApproachManualEnable smallint NULL, 
			ServiceLevelBillMedSocManualEnable smallint NULL, 
			ServiceLevelVerifyWeight smallint NULL, 
			ServiceLevelVerifySex smallint NULL, 
			ServiceLevelBillApproachOnly smallint NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON ServiceLevel TO PUBLIC
/* THIS SECTION REMOVED UNTIL REWRITE OF ABATCH_UPDATESERVICELEVEL
		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[ServiceLevel]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE ServiceLevel Adding Column LastModified'
			ALTER TABLE ServiceLevel
				ADD LastModified DATETIME
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[ServiceLevel]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE ServiceLevel Adding Column LastStatEmployeeID'
			ALTER TABLE ServiceLevel
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[ServiceLevel]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE ServiceLevel Adding Column AuditLogTypeID'
			ALTER TABLE ServiceLevel
				ADD AuditLogTypeID INT NULL
		END	
		
	*/	
		-- check if ServiceLevelPNEAllowSaveWithoutContactRequired Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[ServiceLevel]')
			AND syscolumns.name = 'ServiceLevelPNEAllowSaveWithoutContactRequired'
			)
		BEGIN
			PRINT 'ALTERING TABLE ServiceLevel Adding Column ServiceLevelPNEAllowSaveWithoutContactRequired'
			ALTER TABLE ServiceLevel
				ADD ServiceLevelPNEAllowSaveWithoutContactRequired smallint NULL DEFAULT (0) 
		END	

		-- check if ServiceLevelDCDPotentialMessageEnabled Exists
		IF NOT EXISTS (
			select 1 from syscolumns where id = OBJECT_ID(N'[dbo].[ServiceLevel]')
			AND syscolumns.name = 'ServiceLevelDCDPotentialMessageEnabled'
			)
		BEGIN
			PRINT 'ALTERING TABLE ServiceLevel Adding Column ServiceLevelDCDPotentialMessageEnabled'
			ALTER TABLE ServiceLevel
				ADD ServiceLevelDCDPotentialMessageEnabled smallint NOT NULL DEFAULT (-1) 
		END	
		
		
		
		
				
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE ServiceLevel SET (LOCK_ESCALATION = TABLE)
		END
		
