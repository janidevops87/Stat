SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_QueryOpenReferral1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_QueryOpenReferral1]
GO




--DROP PROCEDURE SPS_QueryOpenReferral1
CREATE PROCEDURE SPS_QueryOpenReferral1
	@pvStartDate	AS	smalldatetime = NULL,
	@pvEndDate	AS	smalldatetime = NULL,
	@vTZ	VARCHAR(2)

AS

/**		12/08/2009	ccarroll	Removed table alias in ORDER BY for SQL Server 2008 update. **/
/**		03/16/2010	ccarroll	Added this note for inclusion in release **/

	SELECT DISTINCT 
		Call.CallID, 
		Call.CallNumber, 
		CallDateTime AS 'CallDateTime', 
		Referral.ReferralDonorName, 
		Organization.OrganizationName, 
		ReferralType.ReferralTypeName, 
		SourceCodeName, 
		'' As Spacer, 
		'' As Spacer, 
		Person.OrganizationID 
	FROM 	Referral 
	LEFT 
	JOIN 	Call ON Call.CallID = Referral.CallID 
	LEFT 
	JOIN 	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT 
	JOIN 	State ON State.StateID = Organization.StateID 
	LEFT 
	JOIN 	ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT 
	JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT 
	JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT 
	JOIN 	Person ON Person.PersonID = StatEmployee.PersonID 
	WHERE	CallDateTime >= @pvStartDate
	AND 	CallDateTime <= @pvEndDate
	ORDER 
	BY 	CallDateTime DESC;





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

