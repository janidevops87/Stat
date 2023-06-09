SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_QueryOpenReferral2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_QueryOpenReferral2]
GO



CREATE PROCEDURE SPS_QueryOpenReferral2
	@pvStartDate	AS	smalldatetime = NULL,
	@pvEndDate	AS	smalldatetime = NULL,
	@vTZ	VARCHAR(2),
	@vReturnLimit 		Int = 0

AS
/**	12/08/2009	ccarroll	Removed table alias in ORDER BY for SQL Server 2008 update. **/
/**	03/16/2010	ccarroll	Added this note for inclusion in release **/

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
		CallDateTime AS 'CallDateTime', 
		Referral.ReferralDonorName, 
		Organization.OrganizationName, 
		PrevReferralType.ReferralTypeName AS PrevReferralTypeName,  -- Added 5/23/05 - SAP
		ReferralType.ReferralTypeName, 
		SourceCodeName, 
		StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName AS StatEmployeeName,  -- Added 5/23/05 - SAP
	
		Person.OrganizationID, 
		Person.OrganizationID, 
		Person.OrganizationID 
	FROM 	Referral (NOLOCK) 
	LEFT 
	JOIN 	Call (NOLOCK) ON Call.CallID = Referral.CallID 
	LEFT 
	JOIN 	Organization (NOLOCK) ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT 
	JOIN 	State (NOLOCK) ON State.StateID = Organization.StateID 
	LEFT 
	JOIN 	ReferralType (NOLOCK) ON ReferralType.ReferralTypeID = Referral.CurrentReferralTypeID 
	LEFT
	JOIN	ReferralType PrevReferralType (NOLOCK) ON PrevReferralType.ReferralTypeId = Referral.ReferralTypeID
	LEFT 
	JOIN 	SourceCode (NOLOCK) ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT 
	JOIN 	StatEmployee (NOLOCK) ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT 
	JOIN 	Person (NOLOCK) ON Person.PersonID = StatEmployee.PersonID 
	WHERE	CallDateTime >= @pvStartDate
	AND 	CallDateTime <= @pvEndDate
	AND	CallActive <> 0
	ORDER 
	BY 	CallDateTime DESC;

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

