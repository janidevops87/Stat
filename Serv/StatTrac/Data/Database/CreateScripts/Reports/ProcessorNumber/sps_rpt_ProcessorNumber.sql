IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ProcessorNumber')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ProcessorNumber'
		DROP  Procedure  sps_rpt_ProcessorNumber
	END

GO

PRINT 'Creating Procedure sps_rpt_ProcessorNumber'
GO
CREATE Procedure sps_rpt_ProcessorNumber
	@ProcessorType				varchar(10) = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@UserOrgID					int = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ProcessorNumber.sql
**		Name: sps_rpt_ProcessorNumber
**		Desc: Shows procesor numbers and detail for given time period.
**		Testsql: exec sps_rpt_ProcessorNumber 'MTF', '03/01/2007 00:00', '03/10/2007 23:59', 37, Null, Null, 1100, 0
**              
**		Return values:
** 
**		Called by: Reporting Services   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: christopher carroll  
**		Date: 06/15/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**		06/15/2007		ccarroll			initial
**		11/19/2007		ccarroll			added time zone search parameter per requirements
**		12/03/2012		James Gerberich		Archive database is being turned off, so
**											this sproc is modified to eliminate
**											the database selection
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

/* Create temp table to collect data */
CREATE TABLE #sps_rpt_ProcessorNumberResults(
			ProcessorNumber varchar(150) Null,
			PatientName varchar(150) Null,
			CallID int Null,
			IssuedBy varchar(150) Null,
			AssignmentNotNeeded varchar(10) Null,
			Comment varchar(250) Null
			)

/* determine if date range is in Archive db */
	--DECLARE @maxTableDate DATETIME
	--DECLARE @OriginalEndDateTime DATETIME
	--SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS
	
	--IF (ISNULL(@ReferralStartDateTime, GETDATE()) < @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
	--	/* Selection resides in archive db */
	--		IF (ISNULL(@ReferralEndDateTime, GETDATE()) > @maxTableDate)
					
	--			BEGIN /* Need to run in both archive and production databases */

	--				  /* run in Archive database */	
	--				INSERT #sps_rpt_ProcessorNumberResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ProcessorNumber_Select @ProcessorType, @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @UserOrgID, @DisplayMT

	--				/* run in production database */
	--				INSERT #sps_rpt_ProcessorNumberResults 
	--					EXEC sps_rpt_ProcessorNumber_Select @ProcessorType, @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @UserOrgID, @DisplayMT
	--			END
	--		ELSE
	--			BEGIN
	--				/* run in Archive database only */	
	--				INSERT #sps_rpt_ProcessorNumberResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ProcessorNumber_Select @ProcessorType, @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName,  @UserOrgID, @DisplayMT
	--			END
	--ELSE
	--		BEGIN	/* run in production database only */
			INSERT #sps_rpt_ProcessorNumberResults 
				EXEC sps_rpt_ProcessorNumber_Select @ProcessorType, @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName,  @UserOrgID, @DisplayMT
			--END



SELECT * FROM #sps_rpt_ProcessorNumberResults


DROP TABLE #sps_rpt_ProcessorNumberResults
GO
