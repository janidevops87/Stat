SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_QueryOpenRecycle]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_QueryOpenRecycle]
GO


CREATE PROCEDURE SPS_QueryOpenRecycle
	@pvStartDate	smalldatetime = NULL,
	@pvEndDate		smalldatetime = NULL,
	@vTZ			varchar(2),
	@vReturnLimit 	int = 0
AS
/******************************************************************************
**		File: SPS_QueryOpenRecycle.sql
**		Name: SPS_QueryOpenRecycle
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


	IF @vReturnLimit > 0
    BEGIN
		SET ROWCOUNT @vReturnLimit 

		-- Limit the date range to 10 days, since only 200 are coming back anyway
		IF DateDiff(d, @pvStartDate, @pvEndDate) > 10
	    BEGIN
			SET @pvStartDate = DateAdd(d, -10, @pvEndDate)
	    END

		SET ROWCOUNT @vReturnLimit
    END

	SELECT DISTINCT 
		Call.CallID, 
		Call.CallNumber, 
		Call.RecycleDateTime AS 'CallDateTime', 
		Referral.ReferralDonorName, 
		Organization.OrganizationName, 
		PrevReferralType.ReferralTypeName AS PrevReferralTypeName,  -- Added 5/23/05 - SAP
		ReferralType.ReferralTypeName, 
		SourceCodeName, 
		StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName AS StatEmployeeName,
		--'' As Spacer, 
		--'' As Spacer, 
		Person.OrganizationID
	FROM 	Referral  
	LEFT 
	JOIN 	CallRecycle Call  ON Call.CallID = Referral.CallID 
	LEFT 
	JOIN 	Organization  ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT 
	JOIN 	State  ON State.StateID = Organization.StateID 
	LEFT 
	JOIN 	ReferralType  ON ReferralType.ReferralTypeID = Referral.CurrentReferralTypeID 
	LEFT
	JOIN	ReferralType PrevReferralType  ON PrevReferralType.ReferralTypeId = Referral.ReferralTypeID
	LEFT 
	JOIN 	SourceCode  ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT 
	JOIN 	StatEmployee  ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT 
	JOIN 	Person  ON Person.PersonID = StatEmployee.PersonID 
	WHERE	Call.RecycleDateTime >= @pvStartDate
	AND 	Call.RecycleDateTime <= @pvEndDate
	ORDER 
	BY 	Call.RecycleDateTime DESC;


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

