SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_QueryOpenRecycleLO]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_QueryOpenRecycleLO]
GO

CREATE  PROCEDURE SPS_QueryOpenRecycleLO
	@pvStartDate	smalldatetime = NULL,
	@pvEndDate		smalldatetime = NULL,
	@pvLeaseOrgID	int,
	@vTZ			varchar(2),
	@vReturnLimit 	int = 0
AS
/******************************************************************************
**		File: SPS_QueryOpenRecycleLO.sql
**		Name: SPS_QueryOpenRecycleLO
**		Desc: 
**		retrieves list of referrals in the "recycle bin"
**		(having their CallId stored in the CallRecycle table instead of in Call)
**		for given params.
**
**              
**		Return values: retrieves list of referrals in the "recycle bin"
**		
** 
**		Called by:   
**
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@pvStartDate	smalldatetime = NULL,
**		@pvEndDate		smalldatetime = NULL,
**		@pvLeaseOrgID	int,
**		@vTZ			varchar(2),
**		@vReturnLimit 	int = 0
**
**		Auth: Scott Plummer
**		Date: 05/25/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		05/25/2005	Scott Plummer		StatTrac v. 7.7.4
**		5/25/2007	Bret Knoll			StatTrac v. 8.4 requirement 8.4.3.3.2
**										Added comment block
**										Replaced (nolock) with set transaction level
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE @TZ int   

	EXEC spf_TZDif @vTZ, @TZ OUTPUT, @pvStartDate

	IF @vReturnLimit > 0
    BEGIN
		SET ROWCOUNT @vReturnLimit 

		-- Limit the date range to 10 days, since only 200 are coming back anyway
		IF DateDiff(d, @pvStartDate, @pvEndDate) > 10
	    BEGIN
			SET @pvStartDate = DateAdd(d, -10, @pvEndDate)
	    END
	END

	SELECT DISTINCT 
		Call.CallID, 
		Call.CallNumber, 
		DATEADD(hh,@TZ,Call.RecycleDateTime) AS 'CallDateTime', 
		Referral.ReferralDonorName, 
		Organization.OrganizationName, 
		PrevReferralType.ReferralTypeName AS PrevReferralTypeName,  -- Added 5/23/05 - SAP
		ReferralType.ReferralTypeName, 
		SourceCodeName, 
		StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName AS StatEmployeeName,  -- Added 5/23/05 - SAP
		--'' As Spacer, 
		--'' As Spacer, 
		Person.OrganizationID,
		Call.RecycleDateTime  -- Added to make Order by clause work.  5/25/05 - SAP
	FROM 	Referral 
	LEFT 
	JOIN 	CallRecycle Call  ON Call.CallID = Referral.CallID 
	LEFT 
	JOIN 	Organization  ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT 
	JOIN 	ReferralType  ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT 
	JOIN	ReferralType PrevReferralType  ON PrevReferralType.ReferralTypeId = Referral.ReferralTypeID
	LEFT
	JOIN 	SourceCode  ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT 
	JOIN 	StatEmployee  ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT 
	JOIN 	Person  ON Person.PersonID = StatEmployee.PersonID 
	
	LEFT 
	JOIN 	WebReportGroupOrg  ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
	LEFT 
	JOIN 	WebReportGroupSourceCode  ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID
	LEFT 
	JOIN 	WebReportGroup  ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID
	AND 	WebReportGroupOrg.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	
	WHERE	Call.RecycleDateTime >= @pvStartDate
	AND 	Call.RecycleDateTime <= @pvEndDate
	AND 	WebReportGroup.OrgHierarchyParentID = @pvLeaseOrgID
	ORDER 
	BY 	Call.RecycleDateTime DESC;

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

