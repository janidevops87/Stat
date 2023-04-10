IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_rpt_TotalCallTime]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure: sps_rpt_TotalCallTime';
	DROP PROCEDURE [dbo].[sps_rpt_TotalCallTime];
END

PRINT 'Creating procedure: sps_rpt_TotalCallTime';
GO

SET QUOTED_IDENTIFIER OFF; 
GO
SET ANSI_NULLS ON;
GO

CREATE PROCEDURE [dbo].[sps_rpt_TotalCallTime]
	/* Report selection criteria */
	@CallID					INT			 = NULL,
	@ReferralStartDateTime	DATETIME	 = NULL,
	@ReferralEndDateTime	DATETIME  	 = NULL,
	@ReportGroupID			INT			 = NULL, 
	@OrganizationID			INT			 = NULL,
	@SourceCodeName			VARCHAR (10) = NULL,
	@CoordinatorID			INT			 = NULL,
	@LowerAgeLimit			INT			 = NULL,
	@UpperAgeLimit			INT			 = NULL,
	@Gender					VARCHAR (1)	 = NULL,
	@DisplayMT				INT			 = NULL 
AS


/******************************************************************************
**		File: sps_rpt_TotalCallTime.sql
**		Name: sps_rpt_TotalCallTime
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Called By:
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**    	04/20/2007	ccarroll			Initial Release
**		09/11/2007  ccarroll			Added Call.CallDateTime for RS sort option
**		11/20/2007	ccarroll			Added TimeZone search parameter: DisplayMT
**										Added ReferralTypeID for OTE RS filter 
**										in report. Changes per requirement revision 4,5
**		09/24/2008	ccarroll			Added selection for Archive data	
**		12/03/2012	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection									
****************************************************************************/
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DECLARE
		@AdjustedReferralStartDateTime	DATETIME = DATEADD(HH, -4, @ReferralStartDateTime),
		@AdjustedReferralEndDateTime	DATETIME = DATEADD(HH, 4, @ReferralEndDateTime);
	
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;
	DROP TABLE IF EXISTS #CallDetails;
	DROP TABLE IF EXISTS #FirstEventDateTimes;

	-- Load #SourceCodes
	SELECT SourceCodeId 
	INTO #SourceCodes
	FROM dbo.fn_SourceCodeList (@ReportGroupID, @SourceCodeName);
	
	-- Load #ConvertedCalls with Converted DateTimes
	SELECT 
		Referral.CallID,
		dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT) 'CallDateTime'
	INTO #ConvertedCalls
	FROM
		Referral
		INNER JOIN [Call] ON Referral.CallID = [Call].CallID
		INNER JOIN #SourceCodes SC ON Call.SourceCodeID = SC.SourceCodeId
	WHERE
		(
			@CallID IS NULL	
			AND Call.CallDateTime >= @AdjustedReferralStartDateTime
			AND Call.CallDateTime <= @AdjustedReferralEndDateTime
		) 
		OR Call.CallID = @CallID;
			
	-- Filter Converted Calls
	SELECT 
		CallID, 
		CallDateTime		
	INTO #FilteredCalls
	FROM #ConvertedCalls
	WHERE
		(
			@CallID IS NULL
			AND	CallDateTime >= @ReferralStartDateTime
			AND CallDateTime <= @ReferralEndDateTime
		)
		OR CallID = @CallID;

	-- Load temp table with filtered call details
	SELECT DISTINCT		
		fc.CallID,
		fc.CallDateTime,
		SourceCode.SourceCodeName,
		Referral.ReferralTypeID,
		Referral.ReferralOrganConversionID,
		Referral.ReferralBoneConversionID,
		Referral.ReferralTissueConversionID,
		Referral.ReferralSkinConversionID,
		Referral.ReferralEyesTransConversionID,
		Referral.ReferralEyesRschConversionID,
		Referral.ReferralValvesConversionID,
		Organization.OrganizationName AS ReferralCallerOrg,
		LogEvent.LogEventID,
		LogEvent.LogEventTypeID,
		dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, LogEvent.LogEventDateTime, @DisplayMT) AS 'LogEventDateTime',
		LogEvent.LogEventDesc,
		LogEvent.LogEventOrg,
		LogEvent.LogEventDateTime AS LogEventDateTimeForOrderBy
	INTO #CallDetails
	FROM LogEvent
		JOIN Call ON Call.CallID = LogEvent.CallID
		JOIN #FilteredCalls fc ON fc.CallID = Call.CallID
		JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
		JOIN Referral ON Referral.CallID = LogEvent.CallID
		JOIN FSCase ON FSCase.CallID = Call.CallID
		JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
		LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	WHERE 
		(@CallID IS NULL OR Call.CallID = @CallID)
		AND (@OrganizationID IS NULL OR Referral.ReferralCallerOrganizationID = @OrganizationID)
		AND (@ReportGroupID IS NULL OR WebReportGroupOrg.WebReportGroupID = @ReportGroupID)
		AND (@Gender IS NULL OR Referral.ReferralDonorGender = @Gender)
		AND (@LowerAgeLimit IS NULL OR Referral.ReferralDonorAge >= @LowerAgeLimit)
		AND (@UpperAgeLimit IS NULL OR Referral.ReferralDonorAge <= @UpperAgeLimit)
		AND (@CoordinatorID IS NULL OR LogEvent.StatEmployeeID = @CoordinatorID)
		AND (LogEvent.LogEventTypeID = 2	   -- Incoming Call
			OR (LogEvent.LogEventTypeID = 1 AND LogEvent.LogEventDesc LIKE '%Donor Registry%') -- Donor Registry Note
			OR LogEvent.LogEventTypeID = 3	   -- Outgoing Call
			OR LogEvent.LogEventTypeID = 15	   -- Secondary Pending
			OR LogEvent.LogEventTypeID = 26	   -- Manual Registry Checked
			OR LogEvent.LogEventTypeID = 27	   -- Consent Obtained
			OR LogEvent.LogEventTypeID = 28	   -- Paperwork Completed
			OR LogEvent.LogEventTypeID = 29	   -- Paperwork Faxed
			OR LogEvent.LogEventTypeID = 30	   -- Family Approached
			)
	ORDER BY
		fc.CallID,
		LogEvent.LogEventDateTime;

	-- Load temp table with first event datetimes
	SELECT 
		CallID,
		LogEventTypeID,
		MIN(LogEventDateTime) AS LogEventDateTime
	INTO #FirstEventDateTimes
	FROM 
		#CallDetails
	WHERE 
		LogEventTypeID <> 3	-- Outgoing Call
		OR ReferralCallerOrg = LogEventOrg
	GROUP BY
		CallID,
		LogEventTypeID;

	-- Run final select
	SELECT  DISTINCT
		r.CallID,
		r.CallDateTime,
		r.SourceCodeName,
		r.ReferralTypeID AS 'ReferralTypeID',
		IncomingCall.LogEventDateTime AS 'IncomingCall',
		ManualRegistryChecked.LogEventDateTime AS 'RegistryChecked',
		Note.LogEventDateTime AS 'RegistryChecked1',
		SecondaryPending.LogEventDateTime AS 'SecondaryPending',

		/* Calculate time difference in seconds: IncomingCall to SecondaryPending */
		CAST(DATEDIFF(ss,IncomingCall.LogEventDateTime,SecondaryPending.LogEventDateTime) AS Int) AS 'Diff_IncomingToSecondary',

		OutgoingCall.LogEventDateTime AS 'SecondaryScreening',

		/* Calculate time difference in seconds: SecondaryPending to SecondaryScreening */
		CAST(DATEDIFF(ss,SecondaryPending.LogEventDateTime,OutgoingCall.LogEventDateTime) AS Int) AS 'Diff_SecondaryPendingToScreening',

		FamilyApproached.LogEventDateTime AS 'FamilyApproached',
		ConsentObtained.LogEventDateTime AS 'ConsentObtained',
		PaperworkFaxed.LogEventDateTime AS 'PaperworkFaxed',
		PaperworkCompleted.LogEventDateTime AS 'PaperworkCompleted',

		/* Calculate time difference in seconds: IncomingCall to PaperworkCompleted */
		CAST(DATEDIFF(ss,IncomingCall.LogEventDateTime,PaperworkCompleted.LogEventDateTime)AS Int) AS 'Diff_IncomingToPaperwork',

		CASE WHEN r.ReferralOrganConversionID = 1 THEN 'Yes'
				WHEN r.ReferralOrganConversionID > 1  THEN 'No' ELSE 'N/A' END AS 'RecoveredOrgan',

		CASE WHEN (r.ReferralBoneConversionID = 1
				OR r.ReferralTissueConversionID = 1
				OR r.ReferralSkinConversionID = 1
				OR r.ReferralEyesRschConversionID = 1
				OR r.ReferralValvesConversionID = 1) THEN 'Yes'
				WHEN (r.ReferralBoneConversionID > 1
				OR r.ReferralTissueConversionID > 1
				OR r.ReferralSkinConversionID > 1
				OR r.ReferralEyesRschConversionID > 1
				OR r.ReferralValvesConversionID > 1) THEN 'No' ELSE 'N/A' END AS 'RecoveredTissue',

		CASE WHEN r.ReferralEyesTransConversionID = 1 THEN 'Yes'
				WHEN r.ReferralEyesTransConversionID > 1 THEN 'No' ELSE 'N/A' END AS 'RecoveredEyes'

	FROM #CallDetails AS r --Referral data
		JOIN #FirstEventDateTimes AS IncomingCall ON IncomingCall.CallID = r.CallID AND (IncomingCall.LogEventTypeID = 2)									-- Incoming Call
		LEFT JOIN #FirstEventDateTimes AS ManualRegistryChecked ON ManualRegistryChecked.CallID = r.CallID AND (ManualRegistryChecked.LogEventTypeID = 26)	-- Manual Registry Checked
		LEFT JOIN #FirstEventDateTimes AS Note ON Note.CallID = r.CallID AND (Note.LogEventTypeID = 1)														-- Note
		LEFT JOIN #FirstEventDateTimes AS SecondaryPending ON SecondaryPending.CallID = r.CallID AND (SecondaryPending.LogEventTypeID = 15)					-- Secondary Pending
		LEFT JOIN #FirstEventDateTimes AS OutgoingCall ON OutgoingCall.CallID = r.CallID AND (OutgoingCall.LogEventTypeID = 3)								-- Outgoing Call
		LEFT JOIN #FirstEventDateTimes AS FamilyApproached ON FamilyApproached.CallID = r.CallID AND (FamilyApproached.LogEventTypeID = 30)					-- Family Approached
		LEFT JOIN #FirstEventDateTimes AS ConsentObtained ON ConsentObtained.CallID = r.CallID AND (ConsentObtained.LogEventTypeID = 27)					-- Consent Obtained
		LEFT JOIN #FirstEventDateTimes AS PaperworkFaxed ON PaperworkFaxed.CallID = r.CallID AND (PaperworkFaxed.LogEventTypeID = 29)						-- Paperwork Faxed
		LEFT JOIN #FirstEventDateTimes AS PaperworkCompleted ON PaperworkCompleted.CallID = r.CallID AND (PaperworkCompleted.LogEventTypeID = 28);			-- Paperwork Completed
	
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #ConvertedCalls;
	DROP TABLE IF EXISTS #FilteredCalls;
	DROP TABLE IF EXISTS #CallDetails;
	DROP TABLE IF EXISTS #FirstEventDateTimes;

END
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

