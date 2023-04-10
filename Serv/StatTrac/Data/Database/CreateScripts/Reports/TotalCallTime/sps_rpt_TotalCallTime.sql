if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_TotalCallTime]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	   PRINT 'Dropping procedure: sps_rpt_TotalCallTime'
		DROP procedure [dbo].[sps_rpt_TotalCallTime]
End

	   PRINT 'Creating procedure: sps_rpt_TotalCallTime'
go

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sps_rpt_TotalCallTime
	/* Report selection criteria */
	@CallID					int			 = NULL,
	@ReferralStartDateTime	datetime	 = NULL,
	@ReferralEndDateTime	datetime  	 = NULL,
	@ReportGroupID			int			 = NULL, 
	@OrganizationID			int			 = NULL,
	@SourceCodeName			varchar (10) = NULL,
	@CoordinatorID			int			 = NULL,
	@LowerAgeLimit			int			 = NULL,
	@UpperAgeLimit			int			 = NULL,
	@Gender					varchar (1)	 = NULL,
	@DisplayMT				int			 = NULL 
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
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

--DECLARE @IncomingCall AS datetime
--DECLARE @Source_DB int
  
--SET @Source_DB = 1 /* SET database to production (default) */

--IF  IsNull(@CallID, 0) <> 0 
--BEGIN

--	IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
--		BEGIN /* production database */
--			SET @Source_DB = 1
--		END
--	ELSE
--		BEGIN /* Archive database */
--			SET @Source_DB = 2
--		END
--END
--ELSE
--	BEGIN
--	/* determine if date range is in Archive db */
--	DECLARE @maxTableDate DATETIME
--	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

--		IF (ISNULL(@ReferralStartDateTime, GetDate()) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 1
--			END 

--		IF (    ISNULL(@ReferralStartDateTime, GetDate()) < @maxTableDate 
--			AND ISNULL(@ReferralEndDateTime, GetDate()) < @maxTableDate
--			AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 2
--			END 

--		IF (    ISNULL(@ReferralStartDateTime, GetDate()) < @maxTableDate 
--			AND ISNULL(@ReferralEndDateTime, GetDate()) > @maxTableDate
--			AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 3
--			END 
--	END
	
	



/* Create temp table for initial select */
CREATE TABLE #sps_rpt_TotalCallTimeResults
	(
		CallID int,
		CallDateTime datetime,
		SourceCode varchar(10),
		ReferralTypeID int,
		ReferralOrganConversionID int,
		ReferralBoneConversionID int,
		ReferralTissueConversionID int,
		ReferralSkinConversionID int,
		ReferralEyesTransConversionID int,
		ReferralEyesRschConversionID int,
		ReferralValvesConversionID int,
		ReferralCallerOrg varchar(80),
		LogEventID int,
		LogEventTypeID int,
		LogEventDateTime datetime Null,
		LogEventDesc varchar(1000) Null,
		LogEventOrg varchar(80) Null
	)

/* Create temp ref table for (Minimum) event times */
DECLARE @Temp_LogEventRef TABLE
	(
		[CallID] [int],
		[LogEventTypeID] [int],--[varchar](80),
		[LogEventDateTime] [smalldatetime]
	)


	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */	
	--				INSERT #sps_rpt_TotalCallTimeResults 
	--					EXEC _ReferralProdArchive..sps_rpt_TotalCallTime_Select @CallID, @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT

	--				/* run in production database */
	--				INSERT #sps_rpt_TotalCallTimeResults 
	--					EXEC sps_rpt_TotalCallTime_Select @CallID, @ReferralStartDateTime, @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT
	--			END

	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */	
	--				INSERT #sps_rpt_TotalCallTimeResults 
	--					EXEC _ReferralProdArchive..sps_rpt_TotalCallTime_Select @CallID, @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT
	--			END

	--IF @Source_DB = 1
	--			BEGIN	/* run in production database only */
				INSERT #sps_rpt_TotalCallTimeResults 
					EXEC sps_rpt_TotalCallTime_Select @CallID, @ReferralStartDateTime,  @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT
	--			END




INSERT INTO @Temp_LogEventRef	

	SELECT  CallID,
		LogEventTypeID,
		min(LogEventDateTime)
  	FROM #sps_rpt_TotalCallTimeResults
  	WHERE LogEventTypeID <> 3	-- Outgoing Call

  	GROUP BY
		CallID,
		LogEventTypeID

UNION ALL

	SELECT  CallID,
		LogEventTypeID,
		min(LogEventDateTime)
	FROM #sps_rpt_TotalCallTimeResults
	WHERE LogEventTypeID = 3	-- Outgoing Call
	AND (ReferralCallerOrg = LogEventOrg)
	GROUP BY
		CallID,
		LogEventTypeID

	ORDER BY
		CallID,
		LogEventTypeID



/* Select finial table */
SELECT  distinct
		r.CallID,
		r.CallDateTime,
		r.SourceCode AS 'SourceCodeName',
		r.ReferralTypeID AS 'ReferralTypeID',
		convert(char(10),IncomingCall.LogEventDateTime,1) + substring(convert(char(10),IncomingCall.LogEventDateTime,8),1,5) AS 'IncomingCall',
		convert(char(10),RegistryChecked.LogEventDateTime,1) + 	substring(convert(char(10),RegistryChecked.LogEventDateTime,8),1,5) AS 'RegistryChecked',
		convert(char(10),RegistryChecked1.LogEventDateTime,1) + 	substring(convert(char(10),RegistryChecked1.LogEventDateTime,8),1,5) AS 'RegistryChecked1',
		convert(char(10),SecondaryPending.LogEventDateTime,1) + 	substring(convert(char(10),SecondaryPending.LogEventDateTime,8),1,5) AS 'SecondaryPending',

		/* Calculate time difference in seconds: IncomingCall to SecondaryPending */
		Cast(DateDiff(ss,IncomingCall.LogEventDateTime,SecondaryPending.LogEventDateTime) AS Int) AS 'Diff_IncomingToSecondary',

		convert(char(10),OutgoingCall.LogEventDateTime,1) + substring(convert(char(10),OutgoingCall.LogEventDateTime,8),1,5) AS 'SeondaryScreening',

		/* Calculate time difference in seconds: SecondaryPending to SecondaryScreening */
		Cast(DateDiff(ss,SecondaryPending.LogEventDateTime,OutgoingCall.LogEventDateTime) AS Int) AS 'Diff_SecondaryPendingToScreening',

		convert(char(10),FamilyApproached.LogEventDateTime,1) + substring(convert(char(10),FamilyApproached.LogEventDateTime,8),1,5) AS 'FamilyApproached',
		convert(char(10),ConsentObtained.LogEventDateTime,1) + 	substring(convert(char(10),ConsentObtained.LogEventDateTime,8),1,5) AS 'ConsentObtained',
		convert(char(10),PaperworkFaxed.LogEventDateTime,1) + 	substring(convert(char(10),PaperworkFaxed.LogEventDateTime,8),1,5) AS 'PaperworkFaxed',
		convert(char(10),PaperworkCompleted.LogEventDateTime,1) + 	substring(convert(char(10),PaperworkCompleted.LogEventDateTime,8),1,5) AS 'PaperworkCompleted',

		/* Calculate time difference in seconds: IncomingCall to PaperworkCompleted */
		Cast(DateDiff(ss,IncomingCall.LogEventDateTime,PaperworkCompleted.LogEventDateTime)AS Int) AS 'Diff_IncomingToPaperwork',


		CASE WHEN r.ReferralOrganConversionID = 1 THEN 'Yes'
		     WHEN r.ReferralOrganConversionID > 1  THEN 'No' ELSE 'N/A' END AS 'RecoveredOrgan',

		CASE WHEN (r.ReferralBoneConversionID = 1
				OR r.ReferralTissueConversionID = 1
				OR r.ReferralSkinConversionID = 1
				OR r.ReferralEyesRschConversionID = 1
				OR r.ReferralValvesConversionID = 1)THEN 'Yes'
		     WHEN (r.ReferralBoneConversionID > 1
				or r.ReferralTissueConversionID > 1
				or r.ReferralSkinConversionID > 1
				or r.ReferralEyesRschConversionID > 1
				or r.ReferralValvesConversionID > 1) THEN 'No' ELSE 'N/A' END AS 'RecoveredTissue',

		CASE WHEN r.ReferralEyesTransConversionID = 1 THEN 'Yes'
		     WHEN r.ReferralEyesTransConversionID > 1 THEN 'No' ELSE 'N/A' END AS 'RecoveredEyes'

FROM #sps_rpt_TotalCallTimeResults AS r --Referral data
JOIN @Temp_LogEventRef AS IncomingCall ON IncomingCall.CallID = r.CallID AND (IncomingCall.LogEventTypeID = 2)							-- Incoming Call
LEFT JOIN (select  * from @Temp_LogEventRef where (LogEventTypeID = 26 ))AS RegistryChecked on RegistryChecked.callid = r.CallID
LEFT JOIN (select  * from @Temp_LogEventRef where (LogEventTypeID = 1) )AS RegistryChecked1 on RegistryChecked1.callid = r.CallID
LEFT JOIN @Temp_LogEventRef AS SecondaryPending ON SecondaryPending.CallID = r.CallID AND (SecondaryPending.LogEventTypeID = 15)		-- Secondary Pending
LEFT JOIN @Temp_LogEventRef AS OutgoingCall ON OutgoingCall.CallID = r.CallID AND (OutgoingCall.LogEventTypeID = 3)						-- Outgoing Call
LEFT JOIN @Temp_LogEventRef AS FamilyApproached ON FamilyApproached.CallID = r.CallID AND (FamilyApproached.LogEventTypeID = 30)		-- Family Approached
LEFT JOIN @Temp_LogEventRef AS ConsentObtained ON ConsentObtained.CallID = r.CallID AND (ConsentObtained.LogEventTypeID = 27)			-- Consent Obtained
LEFT JOIN @Temp_LogEventRef AS PaperworkFaxed ON PaperworkFaxed.CallID = r.CallID AND (PaperworkFaxed.LogEventTypeID = 29)				-- Paperwork Faxed
LEFT JOIN @Temp_LogEventRef AS PaperworkCompleted ON PaperworkCompleted.CallID = r.CallID AND (PaperworkCompleted.LogEventTypeID = 28)	-- Paperwork Completed




DROP TABLE #sps_rpt_TotalCallTimeResults

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

