IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ReferralByPhoneIdSelect')
	BEGIN
		PRINT 'Dropping Procedure ReferralByPhoneIdSelect'
		DROP Procedure ReferralByPhoneIdSelect
	END
GO

PRINT 'Creating Procedure ReferralByPhoneIdSelect'
GO
CREATE Procedure ReferralByPhoneIdSelect
(
		@PhoneID int = null
)
AS
/******************************************************************************
**	File: ReferralByPhoneIdSelect.sql
**	Name: ReferralByPhoneIdSelect
**	Desc: Selects multiple rows of Referral Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/21/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/21/2009		Bret Knoll			Initial Sproc Creation
**	10/12/2009		ccarroll			Added SourceCodeID
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL) 
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT				
		Referral.ReferralCallerPhoneID,
		Call.SourceCodeID,
		Phone,
		Referral.CallID,		
		Call.CallDateTime,
		Call.StatEmployeeID,
		StatEmployee.StatEmployeeFirstName + ' ' + SubString(StatEmployee.StatEmployeeLastName, 1, 1) AS StatEmployee
	FROM 
		Referral 
	JOIN
		Call ON Call.CallID = Referral.CallID
	JOIN
		 fn_PhoneByPhoneID(null) AS ReferralCallerPhone ON ReferralCallerPhone.PhoneID = Referral.ReferralCallerPhoneID
	LEFT JOIN
		StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
	WHERE 
		Referral.ReferralCallerPhoneID = ISNULL(@PhoneID, Referral.ReferralCallerPhoneID)
	ORDER BY Referral.CallID
GO

GRANT EXEC ON ReferralByPhoneIdSelect TO PUBLIC
GO
