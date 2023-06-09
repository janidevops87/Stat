SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_QueryOpenReferral]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_QueryOpenReferral]
GO



CREATE PROCEDURE SPS_QueryOpenReferral
	@pvStartDate	AS	smalldatetime = NULL,
	@pvEndDate	AS	smalldatetime = NULL,
	@vTZ	VARCHAR(2),
	@vReturnLimit 		Int = 0

AS
/******************************************************************************
**		File: SPS_QueryOpenReferral.sql
**		Name: SPS_QueryOpenReferral
**		Desc: Obtains list of Referrals
**
**              
**		Return values: 
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@pvStartDate	smalldatetime = NULL,
**		@pvEndDate		smalldatetime = NULL,
**		@vTZ			VARCHAR(2),
**		@vReturnLimit 	Int = 0
**
**		Auth: Tim Klug
**		Date: 09/01/1996
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		01/06/2003	Bret Knoll			
**		05/23/2005	Scott Plummer		
**		5/25/2007	Bret Knoll			StatTrac v. 8.4 requirement 8.4.3.3.2
**										Added comment block
**										Replaced (nolock) with set transaction level
**		12/08/2009	ccarroll			Removed table alias in ORDER BY for SQL Server 2008 update.
**		03/16/2010	ccarroll			Added this note for inclusion in release
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
	FROM 	Referral  
	LEFT 
	JOIN 	Call  ON Call.CallID = Referral.CallID 
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

