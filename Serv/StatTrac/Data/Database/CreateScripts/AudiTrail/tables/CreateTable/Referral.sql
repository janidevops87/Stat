		/******************************************************************************
		**	File: Referral.sql
		**	Name: AlterReferral
		**	Desc: Create table and add default columns for the table Referral
		**	Auth: ccarroll
		**	Date: 9/2/2011
		**	Revisions:
		******************************************************************************/

		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Referral]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
		/* Create Referral If not exists */
					CREATE TABLE [dbo].[Referral](
					[ReferralID] [int] IDENTITY(1,1) NOT NULL,
					[CallID] [int] NULL,
					[ReferralCallerPhoneID] [int] NULL,
					[ReferralCallerExtension] [varchar](10) NULL,
					[ReferralCallerOrganizationID] [int] NULL,
					[ReferralCallerSubLocationID] [int] NULL,
					[ReferralCallerSubLocationLevel] [varchar](4) NULL,
					[ReferralCallerPersonID] [int] NULL,
					[ReferralDonorName] [varchar](80) NULL,
					[ReferralDonorRecNumber] [varchar](30) NULL,
					[ReferralDonorAge] [varchar](4) NULL,
					[ReferralDonorAgeUnit] [varchar](10) NULL,
					[ReferralDonorRaceID] [int] NULL,
					[ReferralDonorGender] [char](1) NULL
				) ON [PRIMARY]
				SET ANSI_PADDING ON
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorWeight] [varchar](7) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorAdmitDate] [smalldatetime] NULL
				SET ANSI_PADDING OFF
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorAdmitTime] [varchar](10) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorDeathDate] [smalldatetime] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorDeathTime] [varchar](10) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorCauseOfDeathID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorOnVentilator] [varchar](20) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorDead] [varchar](4) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralTypeID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralApproachTypeID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralApproachedByPersonID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralApproachNOK] [varchar](50) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralApproachRelation] [varchar](50) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralOrganAppropriateID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralOrganApproachID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralOrganConsentID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralOrganConversionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralBoneAppropriateID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralBoneApproachID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralBoneConsentID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralBoneConversionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralTissueAppropriateID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralTissueApproachID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralTissueConsentID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralTissueConversionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralSkinAppropriateID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralSkinApproachID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralSkinConsentID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralSkinConversionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralEyesTransAppropriateID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralEyesTransApproachID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralEyesTransConsentID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralEyesTransConversionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralEyesRschAppropriateID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralEyesRschApproachID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralEyesRschConsentID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralEyesRschConversionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralValvesAppropriateID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralValvesApproachID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralValvesConsentID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralValvesConversionID] [int] NULL
				SET ANSI_PADDING ON
				ALTER TABLE [dbo].[Referral] ADD [ReferralNotesCase] [varchar](400) NULL
				SET ANSI_PADDING OFF
				ALTER TABLE [dbo].[Referral] ADD [ReferralNotesPrevious] [varchar](255) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralVerifiedOptions] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralCoronersCase] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [Inactive] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralCallerLevelID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [LastModified] [datetime] NULL
				ALTER TABLE [dbo].[Referral] ADD [UnusedField1] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorFirstName] [varchar](40) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorLastName] [varchar](40) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralOrganDispositionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralBoneDispositionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralTissueDispositionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralSkinDispositionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralValvesDispositionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralEyesDispositionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralRschDispositionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralAllTissueDispositionID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralPronouncingMD] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [UnusedField3] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralNOKPhone] [varchar](14) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralAttendingMD] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralGeneralConsent] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralNOKAddress] [varchar](255) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralCoronerName] [varchar](80) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralCoronerPhone] [varchar](14) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralCoronerOrganization] [varchar](80) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralCoronerNote] [varchar](255) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralApproachTime] [numeric](7, 0) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralConsentTime] [numeric](7, 0) NULL
				ALTER TABLE [dbo].[Referral] ADD [Unused] [smalldatetime] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDOA] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDOB] [datetime] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorSSN] [varchar](11) NULL
				ALTER TABLE [dbo].[Referral] ADD [UpdatedFlag] [smallint] NULL
				SET ANSI_PADDING ON
				ALTER TABLE [dbo].[Referral] ADD [ReferralExtubated] [varchar](15) NULL
				ALTER TABLE [dbo].[Referral] ADD [DonorRegistryType] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [DonorRegId] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [DonorDMVId] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [DonorDMVTable] [varchar](255) NULL
				ALTER TABLE [dbo].[Referral] ADD [DonorIntentDone] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [DonorFaxSent] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [DonorDSNID] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorHeartBeat] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralCoronerOrgID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [CurrentReferralTypeId] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorBrainDeathDate] [smalldatetime] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorBrainDeathTime] [varchar](10) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralPronouncingMDPhone] [varchar](14) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralAttendingMDPhone] [varchar](14) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDOB_ILB] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorSpecificCOD] [varchar](250) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralDonorNameMI] [varchar](2) NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralNOKID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [ReferralQAReviewComplete] [smallint] NULL
				ALTER TABLE [dbo].[Referral] ADD [LastStatEmployeeID] [int] NULL
				ALTER TABLE [dbo].[Referral] ADD [AuditLogTypeID] [int] NULL
				/****** Object:  Index [PK_Referral_1__24]    Script Date: 09/22/2011 13:52:38 ******/
				ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [PK_Referral_1__24] PRIMARY KEY NONCLUSTERED 
				(
					[ReferralID] ASC
				)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]

				SET ANSI_PADDING OFF

				ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_UnusedField3]  DEFAULT (0) FOR [UnusedField3]
				ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_DonorRegistryType]  DEFAULT (0) FOR [DonorRegistryType]
				ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_DonorRegId]  DEFAULT (0) FOR [DonorRegId]
				ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_DonorDMVId]  DEFAULT (0) FOR [DonorDMVId]
				ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_DonorIntentDone]  DEFAULT (0) FOR [DonorIntentDone]
				ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_DonorFaxSent]  DEFAULT (0) FOR [DonorFaxSent]
		END	

		-- check if ReferralDonorLSADate Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Referral]')
			AND syscolumns.name = 'ReferralDonorLSADate'
			)
		BEGIN
			PRINT 'ALTERING TABLE Referral Adding Column ReferralDonorLSADate'
			ALTER TABLE Referral
				ADD ReferralDonorLSADate smalldatetime null
		END	
		-- check if ReferralDonorLSATime Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Referral]')
			AND syscolumns.name = 'ReferralDonorLSATime'
			)
		BEGIN
			PRINT 'ALTERING TABLE Referral Adding Column ReferralDonorLSATime'
			ALTER TABLE Referral
				ADD ReferralDonorLSATime nvarchar(10) null
		END		
		-- Check to see if the column ReferralDCDPotential exists
		IF NOT EXISTS (
			SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
			AND syscolumns.name = 'ReferralDCDPotential'
			)
		BEGIN
			PRINT 'ALTERING TABLE Referral Adding Column ReferralDCDPotential'
			ALTER TABLE Referral
				ADD ReferralDCDPotential SMALLINT NULL;
		END		
		-- Check to see if the column ReferralPendingCase exists
		IF NOT EXISTS (
			SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
			AND syscolumns.name = 'ReferralPendingCase'
			)
		BEGIN
			PRINT 'ALTERING TABLE Referral Adding Column ReferralPendingCase'
			ALTER TABLE Referral
				ADD ReferralPendingCase SMALLINT NULL;
		END			
		-- Check to see if the column ReferralPendingCaseCoordinator exists
		IF NOT EXISTS (
			SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
			AND syscolumns.name = 'ReferralPendingCaseCoordinator'
			)
		BEGIN
			PRINT 'ALTERING TABLE Referral Adding Column ReferralPendingCaseCoordinator'
			ALTER TABLE Referral
				ADD ReferralPendingCaseCoordinator SMALLINT NULL;
		END			
		-- Check to see if the column ReferralPendingCaseComment exists
		IF NOT EXISTS (
			SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
			AND syscolumns.name = 'ReferralPendingCaseComment'
			)
		BEGIN
			PRINT 'ALTERING TABLE Referral Adding Column ReferralPendingCaseComment'
			ALTER TABLE Referral
				ADD ReferralPendingCaseComment VARCHAR(50) NULL;
		END			
		-- Check to see if the column ReferralPendingCaseLastModified exists
		IF NOT EXISTS (
			SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
			AND syscolumns.name = 'ReferralPendingCaseLastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE Referral Adding Column ReferralPendingCaseLastModified'
			ALTER TABLE Referral
				ADD ReferralPendingCaseLastModified DATETIME NULL;
		END			
