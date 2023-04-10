PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:1/14/2019 4:14:15 PM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST290PerformanceEnhancements\App\Database\Create Scripts\Transactional\Functions\fn_CreateReferralType.sql
-- C:\Statline\StatTrac\Development\CCRST290PerformanceEnhancements\App\Database\Create Scripts\Transactional\Sprocs\DashboardUpdateSelect.sql
-- C:\Statline\StatTrac\Development\CCRST290PerformanceEnhancements\App\Database\Create Scripts\Transactional\Sprocs\UpdateCurrentReferralType.sql
-- C:\Statline\StatTrac\Development\CCRST290PerformanceEnhancements\App\Database\Create Scripts\Transactional\Sprocs\GetStatFileReferralSelect.sql
-- C:\Statline\StatTrac\Development\CCRST290PerformanceEnhancements\App\Database\Create Scripts\Transactional\Sprocs\sps_FSCaseWithSecondaryBilling.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST290PerformanceEnhancements\App\Database\Create Scripts\Transactional\Functions\fn_CreateReferralType.sql'
GO
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'FN' AND name = 'fn_CreateReferralType')
	BEGIN
		PRINT 'Dropping Function fn_CreateReferralType';
		DROP Function fn_CreateReferralType;
	END
GO

PRINT 'Creating Function fn_CreateReferralType';
GO 

CREATE FUNCTION dbo.fn_CreateReferralType 
(
	@RecoveryId		INT,
	@ConsentId		INT,
	@AppropriateId	INT,
	@ApproachId		INT
)  
RETURNS BIT
AS
/******************************************************************************
**		File: 
**		Name: dbo.fn_CreateReferralType
**		Desc: 
**
**		This function determines whether a referral should be set to a new 
**		ReferralType based on recovery, consent, appropriate, and approach values.
** 
**		Called by:  
**      UpdateCurrentReferralType.sql (called by StatSave.UpdateCurrentReferralType)
**
**		Auth: Mike Berenson
**		Date: 12/4/2018
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/
BEGIN

	--Check Recovery
	IF @RecoveryId = 1
	BEGIN
		RETURN 1;
	END;

	--Check Consent
	IF @ConsentId = 1
	BEGIN
		RETURN 1;
	END;

	--Check Approach
	IF @ApproachId = 1
	BEGIN
		RETURN 1;
	END
	ELSE IF @ApproachId <> 1 AND @ApproachId <> -1
	BEGIN
		RETURN 0;
	END;

	--Check Appropriate
	IF @AppropriateId = 1
	BEGIN
		RETURN 1;
	END;

	RETURN 0;

END;
GO



GO
PRINT 'C:\Statline\StatTrac\Development\CCRST290PerformanceEnhancements\App\Database\Create Scripts\Transactional\Sprocs\DashboardUpdateSelect.sql'
GO
  IF EXISTS (SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'DashboardUpdateSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardUpdateSelect';
		DROP Procedure DashboardUpdateSelect;
	END
GO
PRINT 'Creating Procedure DashboardUpdateSelect';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE DashboardUpdateSelect
	-- Add the parameters for the stored procedure here
	@startDateTime			datetime = null,
	@endDatetime			datetime = null,
	@timeZone				varchar(2),
	@callNumber			varchar(15) = null,
	@organizationName	VARCHAR(80) = NULL,
	@statAbbreviation	VARCHAR(2) = NULL,
	@referralDonorFirstName VARCHAR(40) = NULL,
	@referralDonorLastName VARCHAR(40) = NULL,
	@currentReferralTypeName VARCHAR(50) = NULL,
	@previousReferralTypeName VARCHAR(50) = NULL,
	@sourceCodeName VARCHAR(10) = NULL,
	@statEmployeeFirstName VARCHAR(50) = NULL,
	@statEmployeeLastName VARCHAR(50) = NULL,
	@userOrganizationID int
AS
BEGIN
	/******************************************************************************
	**	File: DashboardUpdateSelect.sql
	**	Name: DashboardUpdateSelect
	**	Desc: List update referrals 
	**	Auth: jth
	**	Date: Sept. 2010
	**	Called By: 
	*******************************************************************************
	**	Change History
	*******************************************************************************
	**	Date:			Author:					Description:
	**	--------		--------				----------------------------------
	**	02/25/2011		ccarroll				Removed Distinct. Changed JOIN order
	**  03/2011			jth						removed qa criteria, don't use max on 
	**											lastmodified, removed statemployee not 888, changed join to statemployee to logevent statemployee
	**  06/11           jth						lookup call in logevent and not call to speed up, added incoming call criteria and use logeventdate instead of lastmod
	**  08/11			jth						was left joining to referral, which meant messages were showing up
	**  11/26/2014		Bret					Cleanup the Where clause to not use functions
	**	12/18/2018		Mike Berenson			Optimized performance
	*******************************************************************************/

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
   -- declare @callid to query only by callid
	DECLARE @callId INT;
	-- adjust the time for the time zone
	SET @startDateTime	= DATEADD(
									hh, 
									-dbo.fn_TimeZoneDifference
										(
											@TimeZone, 
											@startDateTime
										),
									@startDateTime		
								);	

	SET @endDatetime = DATEADD(
									hh, 
									-dbo.fn_TimeZoneDifference
										(
											@TimeZone, 
											@endDatetime
										),
									@endDatetime		
							 );
							 
	IF ((LEN(@callNumber) = 7 OR LEN(@callNumber) = 8) AND PATINDEX('-', @callNumber)=0 )
	BEGIN
		SET @callId = @callNumber;
		SET @startDateTime		= NULL;
		SET @endDatetime		= NULL;
		SET @callNumber			= NULL;
		SET @organizationName	= NULL;
		SET @statAbbreviation	= NULL;
		SET @referralDonorFirstName = NULL;
		SET @referralDonorLastName = NULL;
		SET @currentReferralTypeName = NULL;
		SET @previousReferralTypeName = NULL;
		SET @sourceCodeName = NULL;
		SET @statEmployeeFirstName = NULL;
		SET @statEmployeeLastName = NULL;
	END

	IF(@userOrganizationID=194)
	BEGIN
		SET @userOrganizationID = NULL;

		 SELECT 
				[Call].CallID,
				[Call].CallNumber,
				LogEvent.LogEventDateTime AS 'CallDateTime',
				IsNull(Referral.ReferralDonorFirstName, '') AS ReferralDonorFirstName,
				IsNull(Referral.ReferralDonorLastName, '') AS ReferralDonorLastName,
				Organization.OrganizationName,
				[State].StateAbbrv,
			
				CASE 
					WHEN ([Call].calltypeid = 1 and abs(Referral.ReferralTypeID) = 1) then 'OTE'
					WHEN ([Call].calltypeid = 1 and Referral.ReferralTypeID = 2) THEN  'TE'
					WHEN ([CAll].calltypeid = 1 and Referral.ReferralTypeID = 3) then 'E'
					WHEN ([Call].calltypeid = 1 and Referral.ReferralTypeID = 4) then 'RO' 
				END AS PrevReferralTypeName,
				(Select ReferralAbbreviation from referraltype where ReferralTypeID = abs(Referral.CurrentReferralTypeID)) as ReferralTypeName,
				SourceCode.SourceCodeName,
				StatEmployeeFirstName,
				StatEmployeeLastName,
				Person.OrganizationID

		FROM		[Call]
		JOIN		Referral ON [Call].CallID = Referral.CallID 
		JOIN		LogEvent ON [Call].CallID = LogEvent.CallID 
		LEFT JOIN	Organization ON Referral.ReferralCallerOrganizationID = Organization.OrganizationID
		LEFT JOIN	[State] ON Organization.StateID = [State].StateID
		LEFT JOIN	FSCase ON [Call].CallID = FSCase.CallID
		LEFT JOIN	ReferralType ON Referral.CurrentReferralTypeID = ReferralType.ReferralTypeID 
		LEFT JOIN	ReferralType AS PreReferralType ON Referral.ReferralTypeID = PreReferralType.ReferralTypeId
		LEFT JOIN 	SourceCode ON [Call].SourceCodeID = SourceCode.SourceCodeID
		LEFT JOIN 	StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID  --[Call].CallSaveLastByID /* was Call.CallSaveLastByID OR LogEvent.LastStatEmployeeID*/
		LEFT JOIN 	Person ON StatEmployee.PersonID = Person.PersonID

		WHERE  
			(@CallID IS NULL OR Call.CallID = @CallID)
		AND LogEvent.LogEventDateTime BETWEEN @startDateTime AND @endDatetime
		-- 2. Incoming Call, 7.Consent Outcome, 8.Recovery Outcome, 24.Case Update
		AND LogEvent.LogEventTypeID IN (2,7,8,24)
		AND	LogEvent.StatEmployeeID <> '77' -- Online event update
		--don't get the first incoming call
		And logevent.logeventnumber <> 1    
	
		/* Search (wildcards permitted) - CallNumber */
		AND	(@callNumber IS NULL OR PATINDEX(@callNumber + '%', [Call].CallNumber) > 0)
		/* Search (wildcards permitted) - Location */
		AND (@organizationName IS NULL OR PATINDEX( @organizationName + '%' , Organization.OrganizationName) > 0)
		/* Search (wildcards permitted) - State */
		AND (@statAbbreviation IS NULL OR PATINDEX(@statAbbreviation + '%', State.StateAbbrv) > 0)
		/* Search (wildcards permitted) - PatientFirst */
		AND (@referralDonorFirstName IS NULL OR PATINDEX(@referralDonorFirstName + '%', Referral.ReferralDonorFirstName) > 0)
		/* Search (wildcards permitted) - PatientLast */
		AND (@referralDonorLastName IS NULL OR PATINDEX(@referralDonorLastName + '%', Referral.ReferralDonorLastName) > 0)
		/* Search (wildcards permitted) - ReferralType */
		AND (@currentReferralTypeName IS NULL OR PATINDEX(@currentReferralTypeName + '%', ReferralType.ReferralAbbreviation) > 0)
		/* Search (wildcards permitted) - PreReferralType */
		AND (@previousReferralTypeName IS NULL OR PATINDEX(@previousReferralTypeName + '%', PreReferralType.ReferralAbbreviation) > 0)
		/* Search (wildcards permitted) - SourceCodeName */
		AND (@sourceCodeName IS NULL OR PATINDEX(@sourceCodeName+ '%', SourceCode.SourceCodeName) > 0)
		/* Search (wildcards permitted) - TcName */
		AND (@statEmployeeFirstName IS NULL OR PATINDEX(@statEmployeeFirstName + '%', StatEmployee.StatEmployeeFirstName) > 0)
		AND (@statEmployeeLastName IS NULL OR PATINDEX(@statEmployeeLastName + '%', StatEmployee.StatEmployeeLastName) > 0)
		AND	(
				FSCase.CallID IS NULL
				OR FSCase.FSCaseFinalDateTime IS NOT NULL
			)
		ORDER BY 	CallDateTime DESC;
	END

	IF @userOrganizationID <> 194 
	BEGIN

		 SELECT 
				[Call].CallID,
				[Call].CallNumber,
				LogEvent.LogEventDateTime AS 'CallDateTime',
				IsNull(Referral.ReferralDonorFirstName, '') AS ReferralDonorFirstName,
				IsNull(Referral.ReferralDonorLastName, '') AS ReferralDonorLastName,
				Organization.OrganizationName,
				[State].StateAbbrv,
			
				CASE 
					WHEN ([Call].calltypeid = 1 and abs(Referral.ReferralTypeID) = 1) then 'OTE'
					WHEN ([Call].calltypeid = 1 and Referral.ReferralTypeID = 2) THEN  'TE'
					WHEN ([CAll].calltypeid = 1 and Referral.ReferralTypeID = 3) then 'E'
					WHEN ([Call].calltypeid = 1 and Referral.ReferralTypeID = 4) then 'RO' 
				END AS PrevReferralTypeName,
				(Select ReferralAbbreviation from referraltype where ReferralTypeID = abs(Referral.CurrentReferralTypeID)) as ReferralTypeName,
				SourceCode.SourceCodeName,
				StatEmployeeFirstName,
				StatEmployeeLastName,
				Person.OrganizationID
			

		FROM		[Call]
		JOIN		Referral ON [Call].CallID = Referral.CallID
		JOIN		[LogEvent] ON [Call].CallID = LogEvent.CallID --AND LogEvent.LogEventTypeID IN (7, 8, 24)	
		LEFT JOIN	Organization ON Referral.ReferralCallerOrganizationID = Organization.OrganizationID 
		LEFT JOIN	[State] ON Organization.StateID = [State].StateID
		LEFT JOIN	FSCase ON [Call].CallID = FSCase.CallID
		LEFT JOIN	ReferralType ON Referral.CurrentReferralTypeID = ReferralType.ReferralTypeID
		LEFT JOIN	ReferralType AS PreReferralType ON Referral.ReferralTypeID = PreReferralType.ReferralTypeId
		LEFT JOIN 	SourceCode ON [Call].SourceCodeID = SourceCode.SourceCodeID
		LEFT JOIN 	StatEmployee ON LogEvent.StatEmployeeID  = StatEmployee.StatEmployeeID 
		LEFT JOIN 	Person ON StatEmployee.PersonID = Person.PersonID

		WHERE  
			(@CallID IS NULL OR Call.CallID = @CallID)
		AND LogEvent.LogEventDateTime BETWEEN @startDateTime AND @endDatetime
		-- 2. Incoming Call, 7.Consent Outcome, 8.Recovery Outcome, 24.Case Update
		AND LogEvent.LogEventTypeID IN (2,7,8,24)
		AND	LogEvent.StatEmployeeID <> '77' -- Online event update    
		And logevent.logeventnumber <> 1
		AND 
		Call.SourceCodeID IN
							(
								SELECT
									WebReportGroupSourceCode.SourceCodeID
								FROM
									WebReportGroup
								JOIN	
									WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
								WHERE
									WebReportGroup.OrgHierarchyParentID = @userOrganizationID)	
		/* Search (wildcards permitted) - CallNumber */
		AND	(@callNumber IS NULL OR PATINDEX(@callNumber + '%', [Call].CallNumber) > 0)
		/* Search (wildcards permitted) - Location */
		AND (@organizationName IS NULL OR PATINDEX( @organizationName + '%' , Organization.OrganizationName) > 0)
		/* Search (wildcards permitted) - State */
		AND (@statAbbreviation IS NULL OR PATINDEX(@statAbbreviation + '%', State.StateAbbrv) > 0)

		/* Search (wildcards permitted) - PatientFirst */
		AND (@referralDonorFirstName IS NULL OR PATINDEX(@referralDonorFirstName + '%', Referral.ReferralDonorFirstName) > 0)
		/* Search (wildcards permitted) - PatientLast */
		AND (@referralDonorLastName IS NULL OR PATINDEX(@referralDonorLastName + '%', Referral.ReferralDonorLastName) > 0)
		/* Search (wildcards permitted) - ReferralType */
		AND (@currentReferralTypeName IS NULL OR PATINDEX(@currentReferralTypeName + '%', ReferralType.ReferralAbbreviation) > 0)
		/* Search (wildcards permitted) - PreReferralType */
		AND (@previousReferralTypeName IS NULL OR PATINDEX(@previousReferralTypeName + '%', PreReferralType.ReferralAbbreviation) > 0)
		/* Search (wildcards permitted) - SourceCodeName */
		AND (@sourceCodeName IS NULL OR PATINDEX(@sourceCodeName+ '%', SourceCode.SourceCodeName) > 0)
		/* Search (wildcards permitted) - TcName */
		AND (@statEmployeeFirstName IS NULL OR PATINDEX(@statEmployeeFirstName + '%', StatEmployee.StatEmployeeFirstName) > 0)
		AND (@statEmployeeLastName IS NULL OR PATINDEX(@statEmployeeLastName + '%', StatEmployee.StatEmployeeLastName) > 0)
		AND	(
				FSCase.CallID IS NULL
				OR FSCase.FSCaseFinalDateTime IS NOT NULL
			)
	
		ORDER BY 	CallDateTime DESC;
	END

END
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST290PerformanceEnhancements\App\Database\Create Scripts\Transactional\Sprocs\UpdateCurrentReferralType.sql'
GO
 IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'UpdateCurrentReferralType')
	BEGIN
		PRINT 'Dropping Procedure UpdateCurrentReferralType';
		DROP  Procedure  UpdateCurrentReferralType;
	END
GO

PRINT 'Creating Procedure UpdateCurrentReferralType';
GO

CREATE Procedure UpdateCurrentReferralType
	@CallID				INT,
	@ServiceLevelID		INT,
	@LastStatEmployeeID	INT
AS
/******************************************************************************
**		File: 
**		Name: UpdateCurrentReferralType
**		Desc: Update the referral record with the appropriate CurrentReferralType
**				duplicating functionality in StatValidate.ReferralTypeDefault 
**				(called by FrmReferral)
**              
**		Return values: returns the update call table row
** 
**		Called by:  StatSave.UpdateCurrentReferralType
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		@CallID 			[INT]
**		@ServiceLevelID		[INT]
**		@LastStatEmployeeID	[INT]
**
**		Auth: Mike Berenson
**		Date: 11/28/2018
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		12/05/2018	Mike Berenson		Changed default referral type to ruleout
*******************************************************************************/

DECLARE	
	@ReferralOrganAppropriateID			INT,
	@ReferralOrganApproachID			INT,
	@ReferralOrganConsentID				INT,
	@ReferralOrganRecoveryID			INT,
	@ReferralBoneAppropriateID			INT,
	@ReferralBoneApproachID				INT,
	@ReferralBoneConsentID				INT,
	@ReferralBoneRecoveryID				INT,
	@ReferralTissueAppropriateID		INT,
	@ReferralTissueApproachID			INT,
	@ReferralTissueConsentID			INT,
	@ReferralTissueRecoveryID			INT,
	@ReferralSkinAppropriateID			INT,
	@ReferralSkinApproachID				INT,
	@ReferralSkinConsentID				INT,
	@ReferralSkinRecoveryID				INT,
	@ReferralValvesAppropriateID		INT,
	@ReferralValvesApproachID			INT,
	@ReferralValvesConsentID			INT,
	@ReferralValvesRecoveryID			INT,	
	@ReferralResearchAppropriateID		INT,
	@ReferralResearchApproachID			INT,
	@ReferralResearchConsentID			INT,
	@ReferralResearchRecoveryID			INT,
	@ReferralEyesAppropriateID			INT,
	@ReferralEyesApproachID				INT,
	@ReferralEyesConsentID				INT,
	@ReferralEyesRecoveryID				INT,	
	@ServiceLevelAppropriateOrganID		INT,
	@ServiceLevelAppropriateBoneID		INT,
	@ServiceLevelAppropriateTissueID	INT,
	@ServiceLevelAppropriateSkinID		INT,
	@ServiceLevelAppropriateValvesID	INT,
	@ServiceLevelAppropriateEyesID		INT,
	@CurrentReferralTypeIdOriginal		INT,
	@CurrentReferralTypeIdNew			INT = 4, --Ruleout
	@ReferralTypeEyeOnly				INT = 3,
	@ReferralTypeOrgan					INT = 7,
	@ReferralTypeTissue					INT = 8;

--Look up referral data
SELECT TOP (1)
	@ReferralOrganAppropriateID = ReferralOrganAppropriateID,
	@ReferralOrganApproachID = ReferralOrganApproachID,
	@ReferralOrganConsentID = ReferralOrganConsentID,
	@ReferralOrganRecoveryID = ReferralOrganConversionID,
	@ReferralBoneAppropriateID = ReferralBoneAppropriateID,
	@ReferralBoneApproachID = ReferralBoneApproachID,
	@ReferralBoneConsentID = ReferralBoneConsentID,
	@ReferralBoneRecoveryID = ReferralBoneConversionID,
	@ReferralTissueAppropriateID = ReferralTissueAppropriateID,
	@ReferralTissueApproachID = ReferralTissueApproachID,
	@ReferralTissueConsentID = ReferralTissueConsentID,
	@ReferralTissueRecoveryID = ReferralTissueConversionID,
	@ReferralSkinAppropriateID = ReferralSkinAppropriateID,
	@ReferralSkinApproachID = ReferralSkinApproachID,
	@ReferralSkinConsentID = ReferralSkinConsentID,
	@ReferralSkinRecoveryID = ReferralSkinConversionID,
	@ReferralValvesAppropriateID = ReferralValvesAppropriateID,
	@ReferralValvesApproachID = ReferralValvesApproachID,
	@ReferralValvesConsentID = ReferralValvesConsentID,
	@ReferralValvesRecoveryID = ReferralValvesConversionID,
	@ReferralEyesAppropriateID = ReferralEyesTransAppropriateID,
	@ReferralEyesApproachID = ReferralEyesTransApproachID,
	@ReferralEyesConsentID = ReferralEyesTransConsentID,
	@ReferralEyesRecoveryID = ReferralEyesTransConversionID,
	@ReferralResearchAppropriateID = ReferralEyesRschAppropriateID,
	@ReferralResearchApproachID = ReferralEyesRschApproachID,
	@ReferralResearchConsentID = ReferralEyesRschConsentID,
	@ReferralResearchRecoveryID = ReferralEyesRschConversionID,
	@CurrentReferralTypeIdOriginal = CurrentReferralTypeId
FROM Referral
WHERE CallID = @CallID;

--Look up service level data
SELECT TOP (1)
	@ServiceLevelAppropriateOrganID = ServiceLevelAppropriateOrgan,
	@ServiceLevelAppropriateBoneID = ServiceLevelAppropriateBone,
	@ServiceLevelAppropriateTissueID = ServiceLevelAppropriateTissue,
	@ServiceLevelAppropriateSkinID = ServiceLevelAppropriateSkin,
	@ServiceLevelAppropriateValvesID = ServiceLevelAppropriateValves,
	@ServiceLevelAppropriateEyesID = ServiceLevelAppropriateEyes
FROM ServiceLevel
WHERE ServiceLevelID = @ServiceLevelID;

--Make sure we have an appropriate service level value
IF (@ServiceLevelAppropriateOrganID = -1 OR @ServiceLevelAppropriateBoneID = -1 OR @ServiceLevelAppropriateTissueID = -1 OR @ServiceLevelAppropriateSkinID = -1 OR @ServiceLevelAppropriateValvesID = -1 OR @ServiceLevelAppropriateEyesID = -1)
BEGIN
	DECLARE @returnValue BIT;

	--Check Organ
	EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralOrganRecoveryID, @ConsentID = @ReferralOrganConsentID, @AppropriateId = @ReferralOrganAppropriateID, @ApproachId = @ReferralOrganApproachID;
	IF @returnValue = 1
	BEGIN
		SET @CurrentReferralTypeIdNew = @ReferralTypeOrgan;
	END

	--Check Tissue
	EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralTissueRecoveryID, @ConsentID = @ReferralTissueConsentID, @AppropriateId = @ReferralTissueAppropriateID, @ApproachId = @ReferralTissueApproachID;
	IF @returnValue = 1
	BEGIN
		SET @CurrentReferralTypeIdNew = @ReferralTypeTissue;
	END

	--Check Bone
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralBoneRecoveryID, @ConsentID = @ReferralBoneConsentID, @AppropriateId = @ReferralBoneAppropriateID, @ApproachId = @ReferralBoneApproachID;
		IF @returnValue = 1
		BEGIN
			SET @CurrentReferralTypeIdNew = @ReferralTypeTissue;
		END
	END

	--Check Skin
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralSkinRecoveryID, @ConsentID = @ReferralSkinConsentID, @AppropriateId = @ReferralSkinAppropriateID, @ApproachId = @ReferralSkinApproachID;
		IF @returnValue = 1
		BEGIN
			SET @CurrentReferralTypeIdNew = @ReferralTypeTissue;
		END
	END	
	
	--Check Valves
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralValvesRecoveryID, @ConsentID = @ReferralValvesConsentID, @AppropriateId = @ReferralValvesAppropriateID, @ApproachId = @ReferralValvesApproachID;
		IF @returnValue = 1
		BEGIN
			SET @CurrentReferralTypeIdNew = @ReferralTypeTissue;
		END
	END
	
	--Check Research
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralResearchRecoveryID, @ConsentID = @ReferralResearchConsentID, @AppropriateId = @ReferralResearchAppropriateID, @ApproachId = @ReferralResearchApproachID;
		IF @returnValue = 1
		BEGIN
			SET @CurrentReferralTypeIdNew = @ReferralTypeTissue;
		END
	END
	
	--Check Eyes
	EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralEyesRecoveryID, @ConsentID = @ReferralEyesConsentID, @AppropriateId = @ReferralEyesAppropriateID, @ApproachId = @ReferralEyesApproachID;
	IF @returnValue = 1
	BEGIN
		SET @CurrentReferralTypeIdNew = @ReferralTypeEyeOnly;
	END	

END

--Save New CurrentReferralTypeID If There Was A Change
IF @CurrentReferralTypeIdNew <> @CurrentReferralTypeIdOriginal
BEGIN

	UPDATE Referral 
	SET CurrentReferralTypeID = @CurrentReferralTypeIdNew,
		LastModified = GETDATE(),
		LastStatEmployeeID = @LastStatEmployeeID		
	WHERE CallID = @callID;

	RETURN @@ERROR;
END
ELSE
BEGIN
	RETURN 1;
END

GO

GRANT EXEC ON UpdateCurrentReferralType TO PUBLIC;
GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST290PerformanceEnhancements\App\Database\Create Scripts\Transactional\Sprocs\GetStatFileReferralSelect.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetStatFileReferralSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetStatFileReferralSelect]
	PRINT 'Dropping Procedure: GetStatFileReferralSelect'
END
	PRINT 'Creating Procedure: GetStatFileReferralSelect'
GO

CREATE PROCEDURE [dbo].[GetStatFileReferralSelect]
(
	@ExportFileID int = NULL,
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: GetStatFileReferralSelect.sql
**		Name: GetStatFileReferralSelect
**		Desc:  Used on StatFile
**
**		Called by:  
**              
**
**		Auth: Bret Knoll
**		Date: 03/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/01/2009	Bret Knoll	initial
**      09/2011     jth			added lsa d/t fields
**		10/11/2011	ccarroll	moved LSA to end.
**		10/12/2011	ccarroll	Changed TBINotNeeded value to match file specs
**		12/15/2016	mberenson	Added logic for DLA Registry
**		12/7/2018	bret		striped carriage return from SecondarySubstanceAbuseDetail, ReferralDonorFirstName, ReferralDonorLastName
*******************************************************************************/
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

 SELECT DISTINCT 
	Referral.ReferralID, 
	Convert(varchar(25),dbo.fn_StatFile_ConvertDateTime(@OrganizationID, Call.LastModified), 120) as LastModified, 
	CallNumber,
	Convert(varchar(25), dbo.fn_StatFile_ConvertDateTime(@OrganizationID, CallDateTime), 120) as CallDateTime, 
 	StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', 
 	Referral.ReferralTypeID, 
	ReferralTypeName, 
	1 AS 'ReferralStatusID', 
	'Complete' AS 'ReferralStatus', 
	'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', 
	ReferralCallerExtension, 
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', 
	PersonTypeName, 
	Organization.ProviderNumber 'OrganizationUserCode', 
	Organization.OrganizationName, 
		Case 
			When SubLocationName is null Then '' 
			Else SubLocationName End + ' ' + 
		Case 
			When ReferralCallerSubLocationLevel is null Then '' 
			Else ReferralCallerSubLocationLevel End 
		AS 'CallerOrganizationUnit', 
	REPLACE(REPLACE(ReferralDonorFirstName , CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralDonorFirstName, 
	REPLACE(REPLACE(ReferralDonorLastName  , CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralDonorLastName, 
	ReferralDonorRecNumber, 
	ReferralDonorAge, 
	ReferralDonorAgeUnit, 
	ReferralDonorRaceID, 
	RaceName, 
	ReferralDonorGender, 
	ReferralDonorWeight, 
	ReferralDonorCauseOfDeathID, 
	CauseOfDeathName, 
	REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', 
	ReferralDonorAdmitDate, 
	ReferralDonorAdmitTime,
	ReferralDonorOnVentilator, 
	ReferralDonorDeathDate, 
	ReferralDonorDeathTime, 
	ReferralApproachTypeID, 
	ApproachTypeName, 
	ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', 
	Case 
		When ReferralNOKID is not null THEN LEFT(REPLACE(REPLACE(NOK.NOKFirstName + ' ' + NOK.NOKLastName, CHAR(10), CHAR(32)), CHAR(13), ''), 50)
		ELSE ReferralApproachNOK END 
		AS ReferralApproachNOK,
 	Case 
 		When ReferralNOKID is not null THEN nok.nokApproachRelation 
 		else referralapproachrelation END 
 		AS ReferralApproachRelation, 
 	---- Appropriate
 	ReferralOrganAppropriateID, 
 	ReferralBoneAppropriateID, 
 	ReferralTissueAppropriateID, 
 	ReferralSkinAppropriateID, 
 	ReferralValvesAppropriateID, 
	ReferralEyesTransAppropriateID, 
	---- Approach
	case when RegistryStatus.RegistryStatus = 6 then 23 when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralOrganApproachID end as ReferralOrganApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralBoneApproachID end as ReferralBoneApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralTissueApproachID end as ReferralTissueApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralSkinApproachID end as ReferralSkinApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralValvesApproachID end as ReferralValvesApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralEyesTransApproachID end as ReferralEyesTransApproachID,
	---- Consent
	case when RegistryStatus.RegistryStatus = 6 then 12 when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralOrganConsentID end as ReferralOrganConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralBoneConsentID end as ReferralBoneConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralTissueConsentID end as ReferralTissueConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralSkinConsentID end as ReferralSkinConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralValvesConsentID end as ReferralValvesConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralEyesTransConsentID end as ReferralEyesTransConsentID,
	---- Conversion or Recovery
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralOrganConversionID end as ReferralOrganConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralBoneConversionID end as ReferralBoneConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralTissueConversionID end as ReferralTissueConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralSkinConversionID end as ReferralSkinConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralValvesConversionID end as ReferralValvesConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralEyesTransConversionID end as ReferralEyesTransConversionID,
	ReferralOrganDispositionID, 
	ReferralAllTissueDispositionID, 
	ReferralEyesDispositionID, 
	ReferralBoneDispositionID, 
	ReferralTissueDispositionID, 
	ReferralSkinDispositionID, 
	ReferralValvesDispositionID, 
	ReferralGeneralConsent, 
	ReferralExtubated, 
	cast(convert(char(10),ReferralDOB,101) as varchar(10)) as 'ReferralDOB', 
	ReferralDonorSSN, 
	CASE ReferralCoronersCase WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS 'ReferralCoronersCase', 
	CTY.CountyName, 
	ReferralEyesRschAppropriateID, 
	ReferralEyesRschApproachID,
 	ReferralEyesRschConsentID, 
 	ReferralEyesRschConversionID, 
 	ReferralRschDispositionID, 
 	CallCustomField.CallCustomField1 as customField_1, 
 	CallCustomField.CallCustomField2 as customField_2, 
	CallCustomField.CallCustomField3 as customField_3, 
	CallCustomField.CallCustomField4 as customField_4, 
	CallCustomField.CallCustomField5 as customField_5, 
	CallCustomField.CallCustomField6 as customField_6, 
	REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') as customField_7, 
	CallCustomField.CallCustomField8 as customField_8, 
	CallCustomField.CallCustomField9 as customField_9, 
	CallCustomField.CallCustomField10 as customField_10, 
	CallCustomField.CallCustomField11 as customField_11, 
	CallCustomField.CallCustomField12 as customField_12, 
	CallCustomField.CallCustomField13 as customField_13, 
	CallCustomField.CallCustomField14 as customField_14, 
	CallCustomField.CallCustomField15 as customField_15, 
	CallCustomField.CallCustomField16 as customField_16, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, 
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, 
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS ServiceLevelCustomFieldLabel_16,
 	CASE 
 		WHEN Len(Referral.ReferralCoronerOrganization) > 0 THEN CoronerST.StateAbbrv 
 		ELSE NULL END 
 		as CoronerState,  
 	Referral.ReferralCoronerOrganization AS CoronerOrganization, 
	Referral.ReferralCoronerName AS CoronerName, 
	Referral.ReferralCoronerPhone AS CoronerPhone, 
	REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS CoronerNote, 
	Case 
		When ReferralNOKID is not null then nok.nokphone 
		else Referral.ReferralNOKPhone end 
		AS NOKPhone,
	Case 
		When ReferralNOKID is not null THEN LEFT(REPLACE(REPLACE(Referral.ReferralNOKAddress+ ' ' + NOK.NOKCity + ' ' + st.StateAbbrv + ' ' + NOK.NOKZip, CHAR(10), CHAR(32)), CHAR(13), '') + ' ' + NOK.NOKCity + ' ' + st.StateAbbrv + ' ' + NOK.NOKZip, 255)
		ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END 
		AS ReferralNOKAddress, 	
	RegistryStatus.RegistryStatus RegistryStatusID, 
	RegistryStatusType.RegistryType RegistryStatusType,
	case 
		when isnull(Referral.ReferralDonorHeartBeat, 0)  = 0 then 'N' 
		when isnull(Referral.ReferralDonorHeartBeat, 0)  = -1 then 'N' 
		Else 'Y' End 
		AS PatientHasHeartbeat, 
	Case 
		When Referral.ReferralDOA = 1 then 'Y' 
		Else 'N' End 
		AS DOA, 
	AttendingMD.PersonFirst + ' ' + AttendingMD.PersonLast AS AttendingPhysician,
 	PronouncingMD.PersonFirst + ' ' + PronouncingMD.PersonLast AS PronouncingPhysician  ,
 	FSCaseId,
	FSCaseCreateUserId,
	FSCaseCreateDateTime,
	FSCaseOpenUserId,
	FSCaseOpenDateTime,
	FSCaseSysEventsUserId,
	FSCaseSysEventsDateTime,
	FSCaseSecCompUserId,
	FSCaseSecCompDateTime,
	FSCaseApproachUserId,
	FSCaseApproachDateTime,
	FSCaseFinalUserId,
	FSCaseFinalDateTime,
	FSCaseUpdate,
	FSCaseUserId,
	FSCaseBillSecondaryUserID,
	FSCaseBillDateTime,
	FSCaseBillApproachUserID,
	FSCaseBillApproachDateTime,
	FSCaseBillMedSocUserID,
	FSCaseBillMedSocDateTime,
	SecondaryManualBillPersonId,
	SecondaryUpdatedFlag,
	FSCaseTotalTime,
	FSCaseSeconds,
	FSCaseBillFamUnavailUserId,
	FSCaseBillFamUnavailDateTime,
	FSCaseBillCryoFormUserId,
	FSCaseBillCryoFormDateTime,
	FSCaseBillApproachCount,
	FSCaseBillMedSocCount,
	FSCaseBillCryoFormCount,
	SecondaryWhoAreWe,
	SecondaryNOKaware,
	SecondaryFamilyConsent,
	SecondaryFamilyInterested,
	SecondaryNOKatHospital,
	SecondaryEstTimeSinceLeft,
	SecondaryTimeLeftInMT,
	SecondaryNOKNextDest,
	SecondaryNOKETA,
	SecondaryPatientMiddleName,
	SecondaryPatientHeightFeet,
	SecondaryPatientHeightInches,
	SecondaryPatientBMICalc,
	SecondaryPatientTOD1,
	SecondaryPatientTOD2,
	SecondaryPatientDeathType1,
	SecondaryPatientDeathType2,
	SecondaryTriageHX,
	REPLACE(REPLACE(SecondaryCircumstanceOfDeath, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCircumstanceOfDeath,
	REPLACE(REPLACE(SecondaryMedicalHistory, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryMedicalHistory,
	SecondaryAdmissionDiagnosis,
	SecondaryCOD,
	SecondaryCODSignatory,
	SecondaryCODTime,
	SecondaryCODSignedBy,
	SecondaryPatientVent,
	SecondaryIntubationDate,
	SecondaryIntubationTime,
	SecondaryBrainDeathDate,
	SecondaryBrainDeathTime,
	SecondaryDNRDate,
	SecondaryERORDeath,
	SecondaryEMSArrivalToPatientDate,
	SecondaryEMSArrivalToPatientTime,
	SecondaryEMSArrivalToHospitalDate,
	SecondaryEMSArrivalToHospitalTime,
	SecondaryPatientTerminal,
	SecondaryDeathWitnessed,
	SecondaryDeathWitnessedBy,
	SecondaryLSADate,
	SecondaryLSATime,
	SecondaryLSABy,
	SecondaryACLSProvided,
	SecondaryACLSProvidedTime,
	SecondaryGestationalAge,
	SecondaryParentName1,
	SecondaryParentName2,
	SecondaryBirthCBO,
	SecondaryActiveInfection,
	SecondaryActiveInfectionType,
	SecondaryFluidsGiven,
	SecondaryBloodLoss,
	SecondarySignOfInfection,
	SecondaryMedication,
	SecondaryAntibiotic,
	SecondaryPCPName,
	SecondaryPCPPhone,
	SecondaryMDAttending,
	SecondaryMDAttendingPhone,
	REPLACE(REPLACE(SecondaryPhysicalAppearance,  CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryPhysicalAppearance,
	SecondaryInternalBloodLossCC,
	SecondaryExternalBloodLossCC,
	SecondaryBloodProducts,
	SecondaryColloidsInfused,
	SecondaryCrystalloids,
	SecondaryPreTransfusionSampleRequired,
	SecondaryPreTransfusionSampleAvailable,
	SecondaryPreTransfusionSampleDrawnDate,
	SecondaryPreTransfusionSampleDrawnTime,
	SecondaryPreTransfusionSampleQuantity,
	SecondaryPreTransfusionSampleHeldAt,
	SecondaryPreTransfusionSampleHeldDate,
	SecondaryPreTransfusionSampleHeldTime,
	SecondaryPreTransfusionSampleHeldTechnician,
	SecondaryPostMordemSampleTestSuitable,
	SecondaryPostMordemSampleLocation,
	SecondaryPostMordemSampleContact,
	SecondaryPostMordemSampleCollectionDate,
	SecondaryPostMordemSampleCollectionTime,
	REPLACE(REPLACE(SecondarySputumCharacteristics, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondarySputumCharacteristics,
	SecondaryNOKAltPhone,
	SecondaryNOKLegal,
	SecondaryNOKAltContact,
	SecondaryNOKAltContactPhone,
	SecondaryNOKPostMortemAuthorization,
	SecondaryNOKPostMortemAuthorizationReminder,
	SecondaryCoronerCaseNumber,
	SecondaryCoronerCounty,
	SecondaryCoronerReleased,
	REPLACE(REPLACE(SecondaryCoronerReleasedStipulations, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCoronerReleasedStipulations,
	SecondaryAutopsy,
	SecondaryAutopsyDate,
	SecondaryAutopsyTime,
	SecondaryAutopsyLocation,
	SecondaryAutopsyBloodRequested,
	SecondaryAutopsyCopyRequested,
	SecondaryFuneralHomeSelected,
	SecondaryFuneralHomeName,
	SecondaryFuneralHomePhone,
	SecondaryFuneralHomeAddress,
	SecondaryFuneralHomeContact,
	SecondaryFuneralHomeNotified,
	SecondaryFuneralHomeMorgueCooled,
	SecondaryHoldOnBody,
	SecondaryHoldOnBodyTag,
	SecondaryBodyRefrigerationDate,
	SecondaryBodyRefrigerationTime,
	SecondaryBodyLocation,
	SecondaryBodyMedicalChartLocation,
	SecondaryBodyIDTagLocation,
	SecondaryBodyCoolingMethod,
	SecondaryUNOSNumber,
	SecondaryClientNumber,
	SecondaryCryolifeNumber,
	SecondaryMTFNumber,
	SecondaryLifeNetNumber,
	REPLACE(REPLACE(SecondaryFreeText, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryFreeText,
	SecondaryHistorySubstanceAbuse,
	REPLACE(REPLACE(SecondarySubstanceAbuseDetail, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondarySubstanceAbuseDetail,
	SecondaryExtubationDate,
	SecondaryExtubationTime,
	SecondaryAutopsyReminderYN,
	SecondaryFHReminderYN,
	SecondaryBodyCareReminderYN,
	SecondaryWrapUpReminderYN,
	SecondaryNOKNotifiedBy,
	SecondaryNOKNotifiedDate,
	SecondaryNOKNotifiedTime,
	SecondaryNOKGender,
	SecondaryCODOther,
	SecondaryAutopsyLocationOther,
	SecondaryPatientHospitalPhone,
	SecondaryCoronerCase,
	SecondaryPatientABO,
	SecondaryPatientSuffix,
	SecondaryMDAttendingId,
	REPLACE(REPLACE(SecondaryAdditionalComments,  CHAR(10),  CHAR(32)),  CHAR(13),  '') AS SecondaryAdditionalComments,
	SecondaryRhythm,
	REPLACE(REPLACE(SecondaryAdditionalMedications,  CHAR(10),  CHAR(32)),  CHAR(13),  '') AS SecondaryAdditionalMedications,
	SecondaryBodyHoldPlaced,
	SecondaryBodyHoldPlacedWith,
	SecondaryBodyFutureContact,
	SecondaryBodyHoldPhone,
	SecondaryBodyHoldInstructionsGiven,
	SecondarySteroid,
	SecondaryBodyHoldPlacedTime,
	SecondaryAntibiotic1Name,
	SecondaryAntibiotic1Dose,
	SecondaryAntibiotic1StartDate,
	SecondaryAntibiotic1EndDate,
	SecondaryAntibiotic2Name,
	SecondaryAntibiotic2Dose,
	SecondaryAntibiotic2StartDate,
	SecondaryAntibiotic2EndDate,
	SecondaryAntibiotic3Name,
	SecondaryAntibiotic3Dose,
	SecondaryAntibiotic3StartDate,
	SecondaryAntibiotic3EndDate,
	SecondaryAntibiotic4Name,
	SecondaryAntibiotic4Dose,
	SecondaryAntibiotic4StartDate,
	SecondaryAntibiotic4EndDate,
	SecondaryAntibiotic5Name,
	SecondaryAntibiotic5Dose,
	SecondaryAntibiotic5StartDate,
	SecondaryAntibiotic5EndDate,
	SecondaryBloodProductsReceived1Type,
	SecondaryBloodProductsReceived1Units,
	SecondaryBloodProductsReceived1TypeCC,
	SecondaryBloodProductsReceived1TypeUnitGiven,
	SecondaryBloodProductsReceived2Type,
	SecondaryBloodProductsReceived2Units,
	SecondaryBloodProductsReceived2TypeCC,
	SecondaryBloodProductsReceived2TypeUnitGiven,
	SecondaryBloodProductsReceived3Type,
	SecondaryBloodProductsReceived3Units,
	SecondaryBloodProductsReceived3TypeCC,
	SecondaryBloodProductsReceived3TypeUnitGiven,
	SecondaryColloidsInfused1Type,
	SecondaryColloidsInfused1Units,
	SecondaryColloidsInfused1CC,
	SecondaryColloidsInfused1UnitGiven,
	SecondaryColloidsInfused2Type,
	SecondaryColloidsInfused2Units,
	SecondaryColloidsInfused2CC,
	SecondaryColloidsInfused2UnitGiven,
	SecondaryColloidsInfused3Type,
	SecondaryColloidsInfused3Units,
	SecondaryColloidsInfused3CC,
	SecondaryColloidsInfused3UnitGiven,
	SecondaryCrystalloids1Type,
	SecondaryCrystalloids1Units,
	SecondaryCrystalloids1CC,
	SecondaryCrystalloids1UnitGiven,
	SecondaryCrystalloids2Type,
	SecondaryCrystalloids2Units,
	SecondaryCrystalloids2CC,
	SecondaryCrystalloids2UnitGiven,
	SecondaryCrystalloids3Type,
	SecondaryCrystalloids3Units,
	SecondaryCrystalloids3CC,
	SecondaryCrystalloids3UnitGiven,
	SecondaryWBC1Date,
	SecondaryWBC1,
	SecondaryWBC1Bands,
	SecondaryWBC2Date,
	SecondaryWBC2,
	SecondaryWBC2Bands,
	SecondaryWBC3Date,
	SecondaryWBC3,
	SecondaryWBC3Bands,
	SecondaryLabTemp1,
	SecondaryLabTemp1Date,
	SecondaryLabTemp1Time,
	SecondaryLabTemp2,
	SecondaryLabTemp2Date,
	SecondaryLabTemp2Time,
	SecondaryLabTemp3,
	SecondaryLabTemp3Date,
	SecondaryLabTemp3Time,
	SecondaryCulture1Type,
	SecondaryCulture1Other,
	SecondaryCulture1DrawnDate,
	SecondaryCulture1Growth,
	SecondaryCulture2Type,
	SecondaryCulture2Other,
	SecondaryCulture2DrawnDate,
	SecondaryCulture2Growth,
	SecondaryCulture3Type,
	SecondaryCulture3Other,
	SecondaryCulture3DrawnDate,
	SecondaryCulture3Growth,
	SecondaryCXRAvailable,
	SecondaryCXR1Date,
	REPLACE(REPLACE(SecondaryCXR1Finding, CHAR(10),  CHAR(32)), CHAR(13), '') AS SecondaryCXR1Finding,  
	SecondaryCXR2Date,
	REPLACE(REPLACE(SecondaryCXR2Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR2Finding,
	SecondaryCXR3Date,
	REPLACE(REPLACE(SecondaryCXR3Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR3Finding,
	SecondaryAntibiotic1NameOther,
	SecondaryAntibiotic2NameOther,
	SecondaryAntibiotic3NameOther,
	SecondaryAntibiotic4NameOther,
	SecondaryAntibiotic5NameOther,
	SecondaryBloodProductsReceived1TypeOther,
	SecondaryBloodProductsReceived2TypeOther,
	SecondaryBloodProductsReceived3TypeOther,
	SecondaryColloidsInfused1TypeOther,
	SecondaryColloidsInfused2TypeOther,
	SecondaryColloidsInfused3TypeOther,
	SecondaryCrystalloids1TypeOther,
	SecondaryCrystalloids2TypeOther,
	SecondaryCrystalloids3TypeOther,
	SecondaryApproached,
	SecondaryApproachedBy,
	SecondaryApproachType,
	SecondaryApproachOutcome,
	SecondaryApproachReason,
	SecondaryConsented,
	SecondaryConsentBy,
	SecondaryConsentOutcome,
	SecondaryConsentResearch,
	SecondaryRecoveryLocation,
	SecondaryHospitalApproach,
	SecondaryHospitalApproachedBy,
	SecondaryHospitalOutcome,
	SecondaryConsentMedSocPaperwork,
	SecondaryConsentMedSocObtainedBy,
	SecondaryConsentFuneralPlans,
	SecondaryConsentFuneralPlansOther,
	SecondaryConsentLongSleeves ,
	Referral.LastModified ,
 	CASE Referral.ReferralDOB_ILB WHEN -1 Then  1 ELSE 0 END AS ReferralDonor_ILB,
	REPLACE(REPLACE(ReferralDonorSpecificCOD, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralDonorSpecificCOD,
	ReferralDonorBrainDeathDate,
	ReferralDonorBrainDeathTime,
	ReferralAttendingMDPhone,
	ReferralPronouncingMDPhone,
	CurrentReferralTypeID,
	REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS MedicalHistory, 
	NOK.NOKFirstName, 
	NOK.NOKLastName, 
	NOK.NOKCity, 
	ST.StateAbbrv AS NOKState, 
	NOK.NOKZip, 
	Referral.ReferralDonorNameMI , 
	'' AS CoronorsCase,
	Case When ReferralNOKID is not null THEN LEFT( REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '')  , 255) ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END AS ReferralNOKAddress, 
	CAST(ReferralDonorWeight as varchar(6)) AS PatientWeight_Decimal,
	STBI.SecondaryTBINumber TBINumber,
	CASE STBI.SecondaryTBIAssignmentNotNeeded WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS TBINotNeeded,
	STBI.SecondaryTBIComment TBIComment,
	ReferralDonorLSADate,
	ReferralDonorLSATime
	
	FROM 
		Referral 
	JOIN 
		Call ON Call.CallID = Referral.CallID 
	LEFT JOIN 
		CallCriteria ON Call.CallID = CallCriteria.CallID 
	LEFT JOIN
		ServiceLevel On CallCriteria.ServiceLevelID = ServiceLevel.ServiceLevelID 		
	LEFT JOIN 
		ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT JOIN 
		StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN 
		Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
	LEFT JOIN 
		PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID 
	LEFT JOIN 
		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT JOIN 
		Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID 
	LEFT JOIN 
		SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID 
	LEFT JOIN 
		SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID 
	LEFT JOIN 
		Race ON Race.RaceID = ReferralDonorRaceID 
	LEFT JOIN 
		CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID 
	LEFT JOIN 
		ApproachType ON ApproachTypeID=ReferralApproachTypeID 
	LEFT JOIN 
		Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID 
	LEFT JOIN 
		Organization ME ON ME.OrganizationName = Referral.ReferralCoronerOrganization 
	LEFT JOIN 
		COUNTY CTY ON CTY.CountyID = ME.CountyID 
	LEFT JOIN 
		CallCustomField on CallCustomField.CallID = Referral.CallID 
	LEFT JOIN 
		ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT JOIN 
		ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID 
		AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN 
		ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
	LEFT JOIN 
		RegistryStatus ON RegistryStatus.CallID = Referral.CallID 
	LEFT JOIN
		RegistryStatusType ON RegistryStatusType.ID = RegistryStatus.RegistryStatus 
	LEFT JOIN 
		Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD 
	LEFT JOIN 
		Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD
 	LEFT JOIN 
 		Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT JOIN 
		State AS CoronerST ON CoronerST.StateID = CoronerOrg.StateID 
	LEFT JOIN 
		NOK on Referral.ReferralNOKID = NOK.NOKID 
	LEFT JOIN 
		State AS ST on NOK.NOKStateID = ST.StateID	
	LEFT JOIN 
		Secondary on Secondary.CallID = Call.CallID 
	LEFT JOIN 
		Secondary2 on Secondary2.CallID = Call.CallID 
	LEFT JOIN 
		SecondaryApproach on SecondaryApproach.CallID = Call.CallID 
	LEFT JOIN 
		FSCase on FSCase.CallID = Call.CallID 
		
	LEFT JOIN
		SecondaryTBI STBI ON STBI.CallID = Call.CallID			
	WHERE 
		Call.CallID IN (
						SELECT CallID FROM ExportFileQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0)
						UNION
						SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 0				
						)		
	AND 
		Call.CallID NOT IN (SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 1)				
	ORDER BY ReferralID		

GO

GO
PRINT 'C:\Statline\StatTrac\Development\CCRST290PerformanceEnhancements\App\Database\Create Scripts\Transactional\Sprocs\sps_FSCaseWithSecondaryBilling.sql'
GO
if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSCaseWithSecondaryBilling]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
begin
	print 'drop procedure [dbo].[sps_FSCaseWithSecondaryBilling]';
	drop procedure [dbo].[sps_FSCaseWithSecondaryBilling];
end
GO
	print 'create procedure [dbo].[sps_FSCaseWithSecondaryBilling]';
GO




-- exec sps_FSCaseWithSecondaryBilling 1953974 , MT
CREATE PROCEDURE sps_FSCaseWithSecondaryBilling
		@CallId INT = 0,
		@vTZ	VARCHAR(2)

AS

/******************************************************************************
**		File: sps_FSCaseWithSecondaryBilling.sql
**		Name: sps_FSCaseWithSecondaryBilling
**		Desc: Loads FSCase and SecondaryBilling data
**
**              
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List
**
**		Auth: Mike Berenson
**		Date: 11/27/2018
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/

DECLARE @TZ int;      

EXEC spf_TZDif @vTZ, @TZ OUTPUT;

SELECT	FSCaseId, 
	CallId, 
	FSCaseCreateUserId, 
	DATEADD(hh,@TZ,FSCaseCreateDateTime) as 'FSCaseCreateDateTime', 
	FSCaseOpenUserId, 
	DATEADD(hh,@TZ,FSCaseOpenDateTime) as 'FSCaseOpenDateTime',
	FSCaseSysEventsUserId, 
	DATEADD(hh,@TZ,FSCaseSysEventsDateTime) as 'FSCaseSysEventsDateTime', 
	FSCaseSecCompUserId, 
	DATEADD(hh,@TZ,FSCaseSecCompDateTime) as 'FSCaseSecCompDateTime', 
	FSCaseApproachUserId, 
	DATEADD(hh,@TZ,FSCaseApproachDateTime) as 'FSCaseApproachDateTime', 
	FSCaseFinalUserId, 
	DATEADD(hh,@TZ,FSCaseFinalDateTime) as 'FSCaseFinalDateTime', 
	FSCaseUpdate, 
	FSCaseUserId, 
	seo.StatEmployeeFirstName + ' ' + SUBSTRING(seo.StatEmployeeLastName,1,1) AS FSCaseOpenPerson,
	see.StatEmployeeFirstName + ' ' + SUBSTRING(see.StatEmployeeLastName,1,1) AS FSCaseSysEventsPerson,
	sec.StatEmployeeFirstName + ' ' + SUBSTRING(sec.StatEmployeeLastName,1,1) AS FSCaseSecCompPerson,
	sea.StatEmployeeFirstName + ' ' + SUBSTRING(sea.StatEmployeeLastName,1,1) AS FSCaseApproachedPerson,
	sef.StatEmployeeFirstName + ' ' + SUBSTRING(sef.StatEmployeeLastName,1,1) AS FSCaseFinalPerson,
	
	--Billing Fields
	FSCaseBillSecondaryUserId,	
	DATEADD(hh,@TZ,FSCaseBillDateTime) as 'FSCaseBillDateTime', 	
	FSCaseBillFamUnavailUserId, 								
	DATEADD(hh,@TZ,FSCaseBillFamUnavailDateTime) as 'FSCaseBillFamUnavailDateTime',
	FSCaseBillApproachUserId, 
	DATEADD(hh,@TZ,FSCaseBillApproachDateTime) as 'FSCaseBillApproachDateTime',
	FSCaseBillApproachCount,								
	FSCaseBillMedSocUserId, 
	DATEADD(hh,@TZ,FSCaseBillMedSocDateTime) as 'FSCaseBillMedSocDateTime',
	FSCaseBillMedSocCount,								
	FSCaseBillCryoFormUserId, 							
	DATEADD(hh,@TZ,FSCaseBillCryoFormDateTime) as 'FSCaseBillCryoFormDateTime',	
	FSCaseBillCryoFormCount,	
	sebs.StatEmployeeFirstName + ' ' + SUBSTRING(sebs.StatEmployeeLastName,1,1) AS FSCaseBillSecondaryPerson,
	sebf.StatEmployeeFirstName + ' ' + SUBSTRING(sebf.StatEmployeeLastName,1,1) AS FSCaseBillFamUnavailPerson,
	seba.StatEmployeeFirstName + ' ' + SUBSTRING(seba.StatEmployeeLastName,1,1) AS FSCaseBillApproachPerson,
	sebm.StatEmployeeFirstName + ' ' + SUBSTRING(sebm.StatEmployeeLastName,1,1) AS FSCaseBillMedSocPerson,
	sebc.StatEmployeeFirstName + ' ' + SUBSTRING(sebc.StatEmployeeLastName,1,1) AS FSCaseBillCryoFormPerson,
	sebo.StatEmployeeFirstName + ' ' + SUBSTRING(sebo.StatEmployeeLastName,1,1) AS FSCaseBillOTEPerson, 
	FSCaseBillOTEUserID,
	DATEADD(hh,@TZ,FSCaseBillOTEDateTime) as 'FSCaseBillOTEDateTime',
	FSCaseBillOTECount		

FROM 	FSCase
	LEFT JOIN statemployee seo ON seo.statemployeeid = fscase.FSCaseOpenUserId
	LEFT JOIN statemployee see ON see.statemployeeid = fscase.FSCaseSysEventsUserId
	LEFT JOIN statemployee sec ON sec.statemployeeid = fscase.FSCaseSecCompUserId
	LEFT JOIN statemployee sea ON sea.statemployeeid = fscase.FSCaseApproachUserId
	LEFT JOIN statemployee sef ON sef.statemployeeid = fscase.FSCaseFinalUserId
	LEFT JOIN statemployee sebs ON sebs.statemployeeid = fscase.FSCaseBillSecondaryUserId
	LEFT JOIN statemployee sebf ON sebf.statemployeeid = fscase.FSCaseBillFamUnavailUserId
	LEFT JOIN statemployee seba ON seba.statemployeeid = fscase.FSCaseBillApproachUserId
	LEFT JOIN statemployee sebm ON sebm.statemployeeid = fscase.FSCaseBillMedSocUserId
	LEFT JOIN statemployee sebc ON sebc.statemployeeid = fscase.FSCaseBillCryoFormUserId
	LEFT JOIN statemployee sebo ON sebo.statemployeeid = fscase.FSCaseBillOTEUserId
WHERE 	callid = @CallId;




GO

GO
