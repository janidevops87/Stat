SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_rpt_ReferralFacilityCompliance_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sps_rpt_ReferralFacilityCompliance_Select]
GO

CREATE Procedure [dbo].[sps_rpt_ReferralFacilityCompliance_Select]
--	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@UserOrgId					int = Null,
	@DisplayMT					int = Null
	


AS
/******************************************************************************
**		File: sps_rpt_ReferralFacilityCompliance_Select.sql
**		Name: sps_rpt_ReferralFacilityCompliance_Select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 10/20/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      10/20/2008		ccarroll			Initial release
**      12/29/2008      jth                 added ,0 in select to handle change from parent
**		7/13/2010		sd					Correct the Where Statement for @Organization Search
**      07/2010         jth                 fixes to get images to work
**      12/12/2016      mberenson			Added DLA Registry
*******************************************************************************/

--Declare @CallID						int 
--Declare	@ReferralStartDateTime		DateTime 
--Declare	@ReferralEndDateTime		DateTime 
	
--Declare	@ReportGroupID				int 
--Declare	@OrganizationID				int 
--Declare	@SourceCodeName				varchar(10) 

--Declare	@DisplayMT					int 
--Declare	@UserOrgId					int

--Set @ReferralStartDateTime = '1/1/10'
--set @ReferralEndDateTime = '1/31/10'
--set @ReportGroupID = 37
----set @OrganizationID = 5811


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @CustomCode AS Int
		

/* Set CustomCode */
EXEC @CustomCode = fn_GetOrganizationCustomReport @UserOrgID

SELECT DISTINCT
	Referral.ReferralCallerOrganizationID AS 'OrganizationID',
	Organization.OrganizationName,
	@CustomCode AS 'ReportCustomCode',
	Count(Call.CallID) AS 'TotalReferrals',

	SUM(CASE WHEN RegistryStatus.RegistryStatus IN (1, 2, 4, 6) /* (1)StateRegistry, (2)WebRegistry, (4)ManuallyFound, (6)DlaRegistry */
				THEN 1
				ELSE 0 END
		)				 AS 'TotalRegistered',
	
	SUM(CASE WHEN  Referral.ReferralDonorDeathDate Is Not Null   /* (1)StateRegistry, (2)WebRegistry, (4)ManuallyFound */
				THEN 1
				ELSE 0 END
		)				 AS 'TotalCTOD',0

FROM Call 
JOIN (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		Null						 ,
		@ReferralStartDateTime		 ,
		@ReferralEndDateTime		 ,
		Null						 ,
		Null						 ,
		@DisplayMT		 )
	) LT ON LT.CallID = Call.CallID
	JOIN Referral ON Referral.CallID = Call.CallID 
--	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN RegistryStatus ON Referral.CallID = RegistryStatus.CallID

WHERE
	/* Search - ReportGroup */
	WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
	
	/* Search - Organization */
		AND IsNull(Referral.ReferralCallerOrganizationID, 0) = IsNull(ISNull(@OrganizationID, Referral.ReferralCallerOrganizationID), 0)
	

	AND
		Call.SourceCodeID IN 
			(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName))

	--/* Search - Organization */
	--	AND IsNull(Referral.ReferralCallerOrganizationID, 0) = IsNull(ISNull(@OrganizationID, Referral.ReferralCallerOrganizationID), 0)

GROUP BY
--	Call.CallID,  
	Referral.ReferralCallerOrganizationID,
	Organization.OrganizationName

