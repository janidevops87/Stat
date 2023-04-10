if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ReferralDetail_count_select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_ReferralDetail_count_select'
		DROP  Procedure  sps_rpt_ReferralDetail_count_select
	END

GO

PRINT 'Creating Procedure: sps_rpt_ReferralDetail_count_select'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE sps_rpt_ReferralDetail_count_select
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,
	@UserOrgID					int = Null,
	@DisplaySecondary			smallint = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralDetail_count_select.sql
**		Name: sps_rpt_ReferralDetail_count_select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by: ReferralDetail.rdl   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Bret Knoll  
**		Date: 04/08/2008
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      4/8/2008		bret				Initail release
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
DECLARE @CustomCode AS Int,
		@Results AS Int,
		@LimitRows AS Int

/* Set CustomCode */
EXEC @CustomCode = sps_rpt_CheckCustomReportUserOrg @UserOrgID, @Results OUTPUT

	
SELECT  
	COUNT(DISTINCT Call.CallID) 'RecordCount'

FROM Call 
JOIN 
	(
		SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		@CallID						 ,
		@ReferralStartDateTime		 ,
		@ReferralEndDateTime		 ,
		@CardiacStartDateTime		 ,
		@CardiacEndDateTime			 , 
		@DisplayMT		 )
	) LT ON LT.CallID = Call.CallID
JOIN Referral ON Referral.CallID = Call.CallID 
LEFT JOIN LogEvent ON Call.CallID = LogEvent.CallID
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 

WHERE 
Call.SourceCodeID IN 
	  (SELECT DISTINCT * 
	    FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName))
AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID, Referral.ReferralCallerOrganizationID)

AND (  --- either use the fn_rpt_DonorAgeYear or ignore
		(dbo.fn_rpt_DonorAgeYear(ReferralDOB,ReferralDonorDeathDate,ReferralDonorAge,ReferralDonorAgeUnit)
		BETWEEN @LowerAgeLimit AND @UpperAgeLimit)
	OR
		(ISNULL(@LowerAgeLimit, 0) = 0 AND ISNULL(@UpperAgeLimit, 0) = 0)
	)
	
AND IsNull(LogEvent.StatEmployeeID, 0) = ISNULL(@CoordinatorID, IsNull(LogEvent.StatEmployeeID, 0))
AND IsNull(Referral.ReferralDonorGender, 0) = ISNULL(@Gender, IsNull(Referral.ReferralDonorGender,0))
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

