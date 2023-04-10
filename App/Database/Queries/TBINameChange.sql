 /*** TBI > CTDN Number Manifest release Date: 1/12/2010 ***/
 -- InsertTBI.sql
 -- sps_rpt_ProcessorNumber_Select.sql

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[InsertTBI]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure InsertTBI'
	drop procedure [dbo].[InsertTBI]
End
go


CREATE    PROCEDURE InsertTBI
		@CallID		int		,
		@TBIPrefix	varchar (4)	,
		@TBIDate	varchar (6)	,
		@TBIStatEmployeeID	int		
		
AS

/******************************************************************************
**		File: InsertTBI.sql
**		Name: InsertTBI
**		Desc: This procedure 
**		
**              
**		Return values: 
**		
**		Called by:
**              
**		Parameters:
**		Input							Output
**		----------						-----------
**		@CallID		int		Null,
**		@TBIPrefix	varchar (4) NOT Null,
**		@TBIDate	varchar (6) 	Null,
**		@TBIStatEmployeeID	int		Null
**
**		Auth: Christopher Carroll
**		Date: 05/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------
**		01/06/2010	ccarroll		Change to new format for CA
**									Old format: CL-200801-1
**									New format: CTDN-2010-0001
*******************************************************************************/

/* Rename CA to CTDN 
	Note: ServiceLevel setting TBIPrefix 'CA' will become 'CTDN'
*/

IF @TBIPrefix = 'CA'
BEGIN
	SET @TBIPrefix = 'CTDN'
END

/* TBI Unique Identifier */
DECLARE @TBIUID int
SET @TBIUID =  (SELECT Count (SecondaryTBI.CallID)
		 FROM  SecondaryTBI
		 WHERE SecondaryTBI.SecondaryTBIPrefixDate = (@TBIPrefix + '-' + LEFT(@TBIDate, 4))
		)


If @TBIUID < 1 
BEGIN
	SET @TBIUID = 0
END

	SET @TBIUID = @TBIUID + 1

	INSERT INTO SecondaryTBI
	  (
		CallID,
		SecondaryTBINumber,
		SecondaryTBIIssuedStatEmployeeID,
		SecondaryTBIPrefixDate,
		LastStatEmployeeID,
		CreateDate,
		LastModified,
		AuditLogTypeID
	  )
	VALUES
	  (
		@CallId,
		@TBIPrefix + '-' + LEFT(@TBIDate, 4) + '-' + REPLACE(STR(@TBIUID, 4), ' ', '0'),
		@TBIStatEmployeeID,
		@TBIPrefix + '-' + LEFT(@TBIDate, 4),
		@TBIStatEmployeeID,
		GetDate(),
		GetDate(),
		1
	  )

		SELECT 
				@CallID,
				@TBIPrefix + '-' + LEFT(@TBIDate, 4) + '-' + REPLACE(STR(@TBIUID, 4), ' ', '0'),
				@TBIPrefix
		 
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - InsertTBI create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - InsertTBI procedure created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/





 
 
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ProcessorNumber_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ProcessorNumber_Select'
		DROP  Procedure  sps_rpt_ProcessorNumber_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_ProcessorNumber_Select'
GO
CREATE Procedure sps_rpt_ProcessorNumber_Select
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
**		File: sps_rpt_ProcessorNumber_Select.sql
**		Name: sps_rpt_ProcessorNumber_Select
**		Desc: Shows procesor number detail for given time period.
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
**		Date: 09/25/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		09/25/2008		ccarroll				initial
**		01/07/2009		ccarroll				Processor Type CTDN was TBI. Parameter sent
**												from CustomParamsProcessor listitem 
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

/* Set UserOrg Time Zone */
DECLARE @UserOrgTZ varchar(2)


IF @ProcessorType = 'CTDN'
	BEGIN
		--TBI Processor Number
		SELECT
					SecondaryTBI.SecondaryTBINumber AS 'ProcessorNumber',
					Referral.ReferralDonorLastName + ', ' + Referral.ReferralDonorFirstName + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
					Call.CallID,
					StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName AS 'IssuedBy',
					CASE WHEN IsNull(SecondaryTBI.SecondaryTBIAssignmentNotNeeded, 0) = -1 THEN 'Yes' ELSE '' END AS 'AssignmentNotNeeded',
					IsNull(SecondaryTBI.SecondaryTBIComment, '') AS 'Comment'
					 			
		FROM	Call
 				JOIN	/* NOTE: dbo.fn_rpt_ReferralDateTimeConversion queries the specified datarange
						   Converting the date as appropriate
						   The function limits the data returned by date range and/or CallID
						*/
				(
					SELECT 		
						CallID, 
						CallDateTime 
					FROM dbo.fn_rpt_ReferralDateTimeConversion 
					(
					Null						,
					@ReferralStartDateTime		,
					@ReferralEndDateTime		,
					Null						,
					Null						, 
					@DisplayMT		 )
			  	) LT ON LT.CallID = Call.CallID

		JOIN		Referral ON Call.CallID = Referral.CallID
		JOIN		SecondaryTBI ON Call.CallID = SecondaryTBI.CallID
		LEFT JOIN	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
		LEFT JOIN	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
		LEFT JOIN	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
		LEFT JOIN	StatEmployee ON StatEmployee.StatEmployeeID = SecondaryTBI.SecondaryTBIIssuedStatEmployeeID 

		WHERE		dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT)
						BETWEEN IsNull(@ReferralStartDateTime, dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT))
						AND IsNull(@ReferralEndDateTime, dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT)) 

				AND Call.SourceCodeID IN 
				(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName))
				AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID, Referral.ReferralCallerOrganizationID)
				AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
	END
IF @ProcessorType = 'CryoLife' 
	BEGIN
		--Cryolife Processor Number
		SELECT 		Secondary.SecondaryCryolifeNumber AS 'ProcessorNumber', 
				Referral.ReferralDonorLastName + ', ' + Referral.ReferralDonorFirstName + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
				Call.CallID,
				'' AS 'IssuedBy',
				'' AS 'AssignmentNotNeeded',
				'' AS 'Comment'
					 			
		FROM	Call
 				JOIN	/* NOTE: dbo.fn_rpt_ReferralDateTimeConversion queries the specified datarange
						   Converting the date as appropriate
						   The function limits the data returned by date range and/or CallID
						*/
				(
					SELECT 		
						CallID, 
						CallDateTime 
					FROM dbo.fn_rpt_ReferralDateTimeConversion 
					(
					Null						,
					@ReferralStartDateTime		,
					@ReferralEndDateTime		,
					Null						,
					Null						, 
					@DisplayMT		 )
			  	) LT ON LT.CallID = Call.CallID
		JOIN		Referral ON Call.CallID = Referral.CallID
		JOIN		Secondary ON Call.CallID = Secondary.CallID
		LEFT JOIN	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
		LEFT JOIN	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
		LEFT JOIN	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 

		WHERE		dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT)
						BETWEEN IsNull(@ReferralStartDateTime, dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT))
						AND IsNull(@ReferralEndDateTime, dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT)) 

				AND IsNull(Secondary.SecondaryCryoLifeNumber,'') <> ''
				AND Call.SourceCodeID IN 
				(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName))
				AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID, Referral.ReferralCallerOrganizationID)
				AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)


	END

IF @ProcessorType = 'MTF' 
	BEGIN
		-- MTF Processor Number
		SELECT 		Secondary.SecondaryMTFNumber AS 'ProcessorNumber', 
				Referral.ReferralDonorLastName + ', ' + Referral.ReferralDonorFirstName + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
				Call.CallID,
				'' AS 'IssuedBy',
				'' AS 'AssignmentNotNeeded',
				'' AS 'Comment'
					 			
		FROM	Call
 				JOIN	/* NOTE: dbo.fn_rpt_ReferralDateTimeConversion queries the specified datarange
						   Converting the date as appropriate
						   The function limits the data returned by date range and/or CallID
						*/
				(
					SELECT 		
						CallID, 
						CallDateTime 
					FROM dbo.fn_rpt_ReferralDateTimeConversion 
					(
					Null						,
					@ReferralStartDateTime		,
					@ReferralEndDateTime		,
					Null						,
					Null						, 
					@DisplayMT		 )
			  	) LT ON LT.CallID = Call.CallID
		JOIN		Referral ON Call.CallID = Referral.CallID
		JOIN		Secondary ON Call.CallID = Secondary.CallID
		LEFT JOIN	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
		LEFT JOIN	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
		LEFT JOIN	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 

		WHERE		dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT)
						BETWEEN IsNull(@ReferralStartDateTime, dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT))
						AND IsNull(@ReferralEndDateTime, dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT)) 

				AND IsNull(Secondary.SecondaryMTFNumber,'') <> ''
				AND Call.SourceCodeID IN 
				(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName))
				AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID, Referral.ReferralCallerOrganizationID)
				AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)


	END


IF @ProcessorType = 'LifeNet' 
	BEGIN
		--LifeNet Processor Number
		SELECT 		Secondary.SecondaryLifeNetNumber AS 'ProcessorNumber', 
				Referral.ReferralDonorLastName + ', ' + Referral.ReferralDonorFirstName + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
				Call.CallID,
				'' AS 'IssuedBy',
				'' AS 'AssignmentNotNeeded',
				'' AS 'Comment'
					 			
		FROM	Call
 				JOIN	/* NOTE: dbo.fn_rpt_ReferralDateTimeConversion queries the specified datarange
						   Converting the date as appropriate
						   The function limits the data returned by date range and/or CallID
						*/
				(
					SELECT 		
						CallID, 
						CallDateTime 
					FROM dbo.fn_rpt_ReferralDateTimeConversion 
					(
					Null						,
					@ReferralStartDateTime		,
					@ReferralEndDateTime		,
					Null						,
					Null						, 
					@DisplayMT		 )
			  	) LT ON LT.CallID = Call.CallID
		JOIN		Referral ON Call.CallID = Referral.CallID
		JOIN		Secondary ON Call.CallID = Secondary.CallID
		LEFT JOIN	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
		LEFT JOIN	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
		LEFT JOIN	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 

		WHERE		dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT)
						BETWEEN IsNull(@ReferralStartDateTime, dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT))
						AND IsNull(@ReferralEndDateTime, dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT)) 

				AND IsNull(Secondary.SecondaryLifeNetNumber,'') <> ''
				AND Call.SourceCodeID IN 
				(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName))
				AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID, Referral.ReferralCallerOrganizationID)
				AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)


	END


GO
