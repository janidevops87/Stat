SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_SFSConversionRate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure: sps_rpt_SFSConversionRate'
	drop procedure [dbo].[sps_rpt_FSSummary]
End
go

PRINT 'Creating Procedure: sps_rpt_SFSConversionRate'
GO

CREATE     PROCEDURE sps_rpt_SFSConversionRate
	@ReferralStartDateTime		datetime	= NULL ,
	@ReferralEndDateTime		datetime  	= NULL ,
	@ReportGroupID			int			= NULL , 
	@OrganizationID			int			= NULL ,
	@SourceCodeName			varchar (10) = NULL ,
	@ApproacherData			varchar (2000)	= NULL ,
	@ApproacherTitle		int			= NULL,		
	@ApproacherOrganization int			= NULL,
	@ReportFormat			int			= NULL,
	@DisplayMT				int	= Null
	 
AS
	-- set transaction isolation level
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	
/******************************************************************************
**		File: sps_rpt_SFSConversionRate.sql
**		Name: sps_rpt_SFSConversionRate
**		Desc: 
**
**		Return values:
** 
**		Called by: SFSConversionRate.rdl              
**		Parameters:
**		See above
**		
**		Auth: ccarroll
**		Date: 07/17/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		07/17/2008		ccarroll				Initial Release
****************************************************************************/
DECLARE @SQLString varchar(500)

/* Create Temp table select */
	CREATE TABLE #Temp_SFSConversionRate_Select 
	(	/* Call Details */
		[CallID] [INT] ,
		[CallDateTime] [DATETIME] , 
		[CallSourceCodeID] [INT] NULL , 
		[CallStatEmployeeID] [INT] NULL,

		/* Approach Person Selection Details */
		[ApproachPersonID][INT] NULL,					/* Approach Person order of presidence: */
		[LogEventIncomingSecondaryID] [INT] NULL,		/* 1. Incomming Event after Secondary */
		[LogEventOutgoingCallID] [INT] NULL,			/* 2. Outgoing Event after Secondary */
		[SecondaryApproachedBy] [INT] NULL ,			/* 3. FS Informed Approach */
		[SecondaryConsentBy] [INT] NULL,				/* 4. FS Consent Paperworked Obtained */
		[SecondaryConsentMedSocObtainedBy] [INT] NULL,	/* -. FS MedSoc Paperwork Obtained By */
		[FSCaseBillMedSocUserID] [INT] NULL,			/* -. FS Case Management MedSoc Approacher */
		
		[FSCaseBillMedSocCount] [INT] NULL,
		
		[ReferralGeneralConsent] [INT] NULL,
		[ReferralTypeID] [INT] NULL,
		[ReferralCallerOrganizationID] [INT] NULL, 
		[RegistryStatus] [INT] NULL,

		[ReferralOrganAppropriateID] [INT] NULL , 
		[ReferralBoneAppropriateID] [INT] NULL , 
		[ReferralTissueAppropriateID] [INT] NULL , 
		[ReferralSkinAppropriateID] [INT] NULL , 
		[ReferralEyesTransAppropriateID] [INT] NULL , 
		[ReferralEyesRschAppropriateID] [INT] NULL , 
		[ReferralValvesAppropriateID] [INT] NULL , 

		[ReferralOrganApproachID] [INT] NULL , 
		[ReferralBoneApproachID] [INT] NULL , 
		[ReferralTissueApproachID] [INT] NULL , 
		[ReferralSkinApproachID] [INT] NULL , 
		[ReferralEyesTransApproachID] [INT] NULL , 
		[ReferralEyesRschApproachID] [INT] NULL , 
		[ReferralValvesApproachID] [INT] NULL , 

		[ReferralOrganConsentID] [INT] NULL , 
		[ReferralBoneConsentID] [INT] NULL , 
		[ReferralTissueConsentID] [INT] NULL , 
		[ReferralSkinConsentID] [INT] NULL , 
		[ReferralEyesTransConsentID] [INT] NULL , 
		[ReferralEyesRschConsentID] [INT] NULL , 
		[ReferralValvesConsentID] [INT] NULL , 

		[ReferralOrganConversionID] [INT] NULL , 
		[ReferralBoneConversionID] [INT] NULL , 
		[ReferralTissueConversionID] [INT] NULL , 
		[ReferralSkinConversionID] [INT] NULL , 
		[ReferralEyesTransConversionID] [INT] NULL , 
		[ReferralEyesRschConversionID] [INT] NULL , 
		[ReferralValvesConversionID] [INT]  NULL 
	)

	/*	Create virtual table used in finial display */
	DECLARE	@TempCounts TABLE
	 ( 
		ID int identity(1,1),
		FormatCode int NULL, -- Values to format row: -1 Hidden, 0 = None, 1 = Bold, 2 = Bold & Italic
		FormatCategory varchar (100) Null, /* FormatCategory 0-Standard (Bone, Tissue, etc.) 1-By Client(CAOL, CODA, etc.)*/
		MedSuitable int NULL,
		FamilyUnavail int NULL,
		RegistryApproach int NULL,
		FSApproach int NULL,
		RegistryConsent int NULL,
		FSConsent int NULL,
		RegistryRecovered int NULL,
		TotalRecovered int NULL,
		CNR int NULL,
		UnknownRecovery int NULL,
		TotalsReferralType int, NULL /* Hidden */
	 )

	/*	ApproacherIDs for TotalRecovered */
--	CREATE TABLE #Temp_TotalRecovered
--	 ( 
--		TempApproacherID int NULL,
--		TempApproacherName varchar (100) NULL
--	 )
	 
	/* #Temp_SFSConversionRate_Select initial selection */ 
		SET @SQLString = 'sps_rpt_SFSConversionRate_Select ' + CHAR(39) +
					CONVERT(varchar, @ReferralStartDateTime, 100) + CHAR(39) + ', ' + CHAR(39) +
					CONVERT(varchar, @ReferralEndDateTime, 100) + CHAR(39) + ', ' + 
					CASE IsNull(@ReportGroupID, 0) WHEN 0 THEN 'Null' ELSE CAST(@ReportGroupID AS varchar) END + ', ' +
					CASE IsNull(@OrganizationID, 0) WHEN 0 THEN 'Null' ELSE CAST(@OrganizationID AS varchar) END + ', ' +
					CASE IsNull(@SourceCodeName, '') WHEN '' THEN 'Null' ELSE CHAR(39) + @SourceCodeName + CHAR(39) END + ', ' +
					CASE IsNull(@ApproacherData, '') WHEN '' THEN 'Null' ELSE CHAR(39) + @ApproacherData + CHAR(39) END + ', ' +
					CASE IsNull(@ApproacherTitle, 0) WHEN 0 THEN 'Null' ELSE CAST(@ApproacherTitle AS varchar) END + ', ' +		
					CASE IsNull(@ApproacherOrganization, 0) WHEN 0 THEN 'Null' ELSE CAST(@ApproacherOrganization AS varchar) END + ', ' +		
					CAST(IsNull(@DisplayMT, 0) AS varchar) + ''


			INSERT INTO #Temp_SFSConversionRate_Select
				EXEC (@SQLString)
				--PRINT 'EXEC ' + IsNull(@SQLString, '')


If @ReportFormat = 0 /* Standard Format */
/* Add values to Count table */
BEGIN

/*** Start MedSuitable ***/
INSERT INTO @TempCounts
SELECT
	0 AS 'FormatCode',
	'Bone' AS 'FormatCategory',
	



END

	SourceCode.SourceCodeName AS 'SourceCodeName',
	Approacher.PersonID AS 'ApproacherID',
	ISNULL(Approacher.PersonFirst,' ') + ' ' + ISNULL(Approacher.PersonLast,' ') AS 'ApproacherName',
	SUM(CASE WHEN ReferralBoneAppropriateID = 1
				OR ReferralTissueAppropriateID = 1
				OR ReferralSkinAppropriateID = 1
				OR ReferralValvesAppropriateID = 1
				OR ReferralEyesTransAppropriateID = 1
				OR ReferralEyesRschAppropriateID = 1
				AND IsNull(LogEventIncomingSecondaryID, IsNull(LogEventOutgoingCallID, 0)) = ApproachPersonID
				THEN 1 ELSE 0 END) AS 'MedSuitable',
		0 AS 'RegistryApproach', 
		0 AS 'FSApproach',
		0 AS 'RegistryConsent',
		0 AS 'FSConsent',
		0 AS 'MedSoc',
		0 AS 'TotalRecovered'
FROM #Temp_SFSConversionRate_Select SFSConversionRateSelect
JOIN Person Approacher ON Approacher.PersonID = IsNull(SFSConversionRateSelect.LogEventIncomingSecondaryID, SFSConversionRateSelect.LogEventOutgoingCallID)
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SFSConversionRateSelect.CallSourceCodeID
GROUP BY
		SourceCode.SourceCodeName,
		Approacher.PersonID,
		Approacher.PersonLast,
		Approacher.PersonFirst

/*** End MedSuitable ***/			


/*** Start RegistryApproach ***/
INSERT INTO @TempCounts
SELECT
	SourceCode.SourceCodeName AS 'SourceCodeName',
	Approacher.PersonID AS 'ApproacherID',
	ISNULL(Approacher.PersonFirst,' ') + ' ' + ISNULL(Approacher.PersonLast,' ') AS 'ApproacherName',
	0 AS 'MedSuitable',
	SUM(CASE WHEN ReferralBoneApproachID = 1
				OR ReferralTissueApproachID = 1
				OR ReferralSkinApproachID = 1
				OR ReferralValvesApproachID = 1
				OR ReferralEyesTransApproachID = 1
				OR ReferralEyesRschApproachID = 1
				AND IsNull(SecondaryApproachedBy, IsNull(SecondaryConsentBy, 0)) = ApproachPersonID
				AND IsNull(RegistryStatus, 0) IN (1, 2, 4) /*(1) StateRegistry,
																(2) WebRegistry,
																(4) Manually Found */ 
				THEN 1 ELSE 0 END) AS 'RegistryApproach', 
	0 AS 'FSApproach',
	0 AS 'RegistryConsent',
	0 AS 'FSConsent',
	0 AS 'MedSoc',
	0 AS 'TotalRecovered'
FROM #Temp_SFSConversionRate_Select SFSConversionRateSelect
JOIN Person Approacher ON Approacher.PersonID = IsNull(SFSConversionRateSelect.SecondaryApproachedBy, SFSConversionRateSelect.SecondaryConsentBy) 
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SFSConversionRateSelect.CallSourceCodeID
GROUP BY
		SourceCode.SourceCodeName,
		Approacher.PersonID,
		Approacher.PersonLast,
		Approacher.PersonFirst
/*** End RegistryApproach ***/			


/*** Start FS Approached ***/
INSERT INTO @TempCounts
SELECT
	SourceCode.SourceCodeName AS 'SourceCodeName',
	Approacher.PersonID AS 'ApproacherID',
	ISNULL(Approacher.PersonFirst,' ') + ' ' + ISNULL(Approacher.PersonLast,' ') AS 'ApproacherName',
	0 AS 'MedSuitable',
	0 AS 'RegistryApproach', 
	SUM(CASE WHEN ReferralBoneApproachID = 1
				OR ReferralTissueApproachID = 1
				OR ReferralSkinApproachID = 1
				OR ReferralValvesApproachID = 1
				OR ReferralEyesTransApproachID = 1
				OR ReferralEyesRschApproachID = 1
				AND IsNull(SecondaryApproachedBy, IsNull(SecondaryConsentBy, 0)) = ApproachPersonID
				AND IsNull(RegistryStatus, 0) IN (0, 3, 5) /*(0) Blank,
																(3) Not on Registry,
																(5) Not Checked */
				THEN 1 ELSE 0 END) AS 'FSApproach',
	0 AS 'RegistryConsent',
	0 AS 'FSConsent',
	0 AS 'MedSoc',
	0 AS 'TotalRecovered'
FROM #Temp_SFSConversionRate_Select SFSConversionRateSelect
JOIN Person Approacher ON Approacher.PersonID = IsNull(SFSConversionRateSelect.SecondaryApproachedBy, SFSConversionRateSelect.SecondaryConsentBy) 
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SFSConversionRateSelect.CallSourceCodeID
GROUP BY
		SourceCode.SourceCodeName,
		Approacher.PersonID,
		Approacher.PersonLast,
		Approacher.PersonFirst
/*** End FS Approached ***/			


/*** Start RegistryConsent ***/
INSERT INTO @TempCounts
SELECT
	SourceCode.SourceCodeName AS 'SourceCodeName',
	Approacher.PersonID AS 'ApproacherID',
	ISNULL(Approacher.PersonFirst,' ') + ' ' + ISNULL(Approacher.PersonLast,' ') AS 'ApproacherName',
	0 AS 'MedSuitable',
	0 AS 'RegistryApproach', 
	0 AS 'FSApproach',
	SUM(CASE WHEN ReferralBoneConsentID = 1
				OR ReferralTissueConsentID = 1
				OR ReferralSkinConsentID = 1
				OR ReferralValvesConsentID = 1
				OR ReferralEyesTransConsentID = 1
				OR ReferralEyesRschConsentID = 1
				AND IsNull(ReferralGeneralConsent, 0)= 1	/* (1) Yes Written */
				--AND IsNull(SecondaryApproachedBy, IsNull(SecondaryConsentBy, 0)) = ApproachPersonID
				AND IsNull(RegistryStatus, 0) IN (1, 2, 4) /*(1) StateRegistry,
																(2) WebRegistry,
																(4) Manually Found */ 
				THEN 1 ELSE 0 END) AS 'RegistryConsent',
	0 AS 'FSConsent',
	0 AS 'MedSoc',
	0 AS 'TotalRecovered'
FROM #Temp_SFSConversionRate_Select SFSConversionRateSelect
/* Note: The consent for paperwork is the primary selection */
JOIN Person Approacher ON Approacher.PersonID = IsNull(SFSConversionRateSelect.SecondaryConsentBy, SFSConversionRateSelect.SecondaryApproachedBy) 
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SFSConversionRateSelect.CallSourceCodeID
GROUP BY
		SourceCode.SourceCodeName,
		Approacher.PersonID,
		Approacher.PersonLast,
		Approacher.PersonFirst
/*** End RegistryConsent ***/			


/*** Start FSConsent ***/
INSERT INTO @TempCounts
SELECT
	SourceCode.SourceCodeName AS 'SourceCodeName',
	Approacher.PersonID AS 'ApproacherID',
	ISNULL(Approacher.PersonFirst,' ') + ' ' + ISNULL(Approacher.PersonLast,' ') AS 'ApproacherName',
	0 AS 'MedSuitable',
	0 AS 'RegistryApproach', 
	0 AS 'FSApproach',
	0 AS 'RegistryConsent',
	SUM(CASE WHEN ReferralBoneConsentID = 1
				OR ReferralTissueConsentID = 1
				OR ReferralSkinConsentID = 1
				OR ReferralValvesConsentID = 1
				OR ReferralEyesTransConsentID = 1
				OR ReferralEyesRschConsentID = 1
				AND IsNull(ReferralGeneralConsent, 0)= 1	  /*(1) Yes Written */
				--AND IsNull(SecondaryApproachedBy, IsNull(SecondaryConsentBy, 0)) = ApproachPersonID
				AND IsNull(RegistryStatus, 0) IN (0, 3, 5) /*(0) Blank,
																(3) Not on Registry,
																(5) Not Checked */
				THEN 1 ELSE 0 END) AS 'FSConsent',
	0 AS 'MedSoc',
	0 AS 'TotalRecovered'
FROM #Temp_SFSConversionRate_Select SFSConversionRateSelect
/* Note: The consent for paperwork is the primary selection */
JOIN Person Approacher ON Approacher.PersonID = IsNull(SFSConversionRateSelect.SecondaryConsentBy, SFSConversionRateSelect.SecondaryApproachedBy) 
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SFSConversionRateSelect.CallSourceCodeID
GROUP BY
		SourceCode.SourceCodeName,
		Approacher.PersonID,
		Approacher.PersonLast,
		Approacher.PersonFirst
/*** End FSConsent ***/			

/*** Start MedSoc ***/
INSERT INTO @TempCounts
SELECT
	SourceCode.SourceCodeName AS 'SourceCodeName',
	CASE WHEN IsNull(ApproacherMSOB.PersonID, -1) < 0 
		 THEN ApproacherMSUID.PersonID 
		 ELSE ApproacherMSOB.PersonID
	END AS 'ApproacherID',

	CASE WHEN IsNull(ApproacherMSOB.PersonID, -1) < 0
		 THEN  IsNull(ApproacherMSUID.PersonFirst,' ') + ' ' + ISNULL(ApproacherMSUID.PersonLast,' ')
		 ELSE  IsNull(ApproacherMSOB.PersonFirst,' ') + ' ' + ISNULL(ApproacherMSOB.PersonLast,' ')
	END AS 'ApproacherName',
	
	0 AS 'MedSuitable',
	0 AS 'RegistryApproach', 
	0 AS 'FSApproach',
	0 AS 'RegistryConsent',
	0 AS 'FSConsent',
	SUM (Isnull(FSCaseBillMedSocCount, 0)) AS 'MedSoc',
	0 AS 'TotalRecovered'
FROM #Temp_SFSConversionRate_Select SFSConversionRateSelect
LEFT JOIN Person ApproacherMSOB ON ApproacherMSOB.PersonID = SFSConversionRateSelect.SecondaryConsentMedSocObtainedBy
LEFT JOIN Person ApproacherMSUID ON  ApproacherMSUID.PersonID = SFSConversionRateSelect.FSCaseBillMedSocUserID
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SFSConversionRateSelect.CallSourceCodeID
WHERE IsNull(ApproacherMSOB.PersonID, -1 ) > 0 OR
	  IsNull(ApproacherMSUID.PersonID, -1 ) > 0
GROUP BY
		SourceCode.SourceCodeName,
		ApproacherMSOB.PersonID,
		ApproacherMSOB.PersonLast,
		ApproacherMSOB.PersonFirst,

		ApproacherMSUID.PersonID,
		ApproacherMSUID.PersonLast,
		ApproacherMSUID.PersonFirst
		
		
/*** End MedSoc ***/			




INSERT INTO #Temp_TotalRecovered
	SELECT DISTINCT TRA.ApproacherID, TRA.ApproacherName FROM @Tempcounts AS TRA
	GROUP BY
				TRA.ApproacherID,
				TRA.ApproacherName

/*** Start TotalRecovered ***/
INSERT INTO @TempCounts
SELECT
	SourceCode.SourceCodeName AS 'SourceCodeName',
	TTR.TempApproacherID,
	TTR.TempApproacherName AS 'ApproacherName',

	0 AS 'MedSuitable',
	0 AS 'RegistryApproach', 
	0 AS 'FSApproach',
	0 AS 'RegistryConsent',
	0 AS 'FSConsent',
	0 AS 'MedSoc',

		SUM (CASE WHEN ReferralBoneConversionID = 1
				OR ReferralTissueConversionID = 1
				OR ReferralSkinConversionID = 1
				OR ReferralValvesConversionID = 1
				OR ReferralEyesTransConversionID = 1
				OR ReferralEyesRschConversionID = 1
				THEN 1 ELSE 0 
		END) AS 'TotalRecovered'

FROM #Temp_TotalRecovered TTR, #Temp_SFSConversionRate_Select FSS
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = CallSourceCodeID

WHERE 
		(FSS.ReferralBoneConversionID = 1
		 OR FSS.ReferralTissueConversionID = 1
		 OR FSS.ReferralSkinConversionID = 1
		 OR FSS.ReferralValvesConversionID = 1
		 OR FSS.ReferralEyesTransConversionID = 1
		 OR FSS.ReferralEyesRschConversionID = 1
		)
 AND (  TTR.TempApproacherID = IsNull(FSS.LogEventIncomingSecondaryID, IsNull(FSS.LogEventOutgoingCallID, -2))
	 OR TTR.TempApproacherID = IsNull(FSS.SecondaryApproachedBy, -2)
	 OR TTR.TempApproacherID = IsNull(FSS.SecondaryConsentBy, -2)
	 OR TTR.TempApproacherID = IsNull(FSS.SecondaryConsentMedSocObtainedBy, IsNull(FSS.FSCaseBillMedSocUserID, -2))
	 )
 
GROUP BY
		SourceCode.SourceCodeName,
		TTR.TempApproacherID,
		TTR.TempApproacherName
/*** End TotalRecovered ***/							


/* Finial Select Statment */
SELECT
		SourceCodeName AS 'SourceCodeName', 
		ApproacherID   AS 'ApproacherID', 
		ApproacherName AS 'ApproacherName',
		IsNull(Sum(MedSuitable), 0) AS 'MedSuitable',
		IsNull(Sum(RegistryApproach), 0) AS 'RegistryApproach',
		IsNull(Sum(FSApproach), 0) AS 'FSApproach',
		IsNull(Sum(RegistryConsent), 0) AS 'RegistryConsent',
		IsNull(Sum(FSConsent), 0) AS 'FSConsent',
		IsNull(Sum(MedSoc), 0) AS 'MedSoc',
		IsNull(Sum(TotalRecovered), 0) AS 'TotalRecovered'
FROM @TempCounts
GROUP BY
			SourceCodeName,
			ApproacherID,
			ApproacherName

ORDER BY	SourceCodeName,
			ApproacherName



--SELECT * FROM #Temp_SFSConversionRate_Select

DROP TABLE #Temp_SFSConversionRate_Select
--DROP TABLE #Temp_TotalRecovered

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



