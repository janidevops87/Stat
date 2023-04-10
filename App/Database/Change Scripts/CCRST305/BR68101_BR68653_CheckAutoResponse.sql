/******************************************************************************
**		File: BR68101_BR68653_CheckAutoResponse.sql
**		Name: Check AutoResponse when type = Email, pager alpha, and pager autoresponse
**		Desc: Check AutoResponse when type = Email, pager, alpha and pager autoresponse
**
**		Auth: Pam Scheichenost
**		Date: 02/13/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/13/2020	Pam Scheichenost	initial
*******************************************************************************/

--DECLARE
--@LastModified DateTime = GETUTCDATE();

--UPDATE dbo.PersonPhone
--	SET AutoResponse = 1,
--	LastModified = @LastModified
--FROM dbo.PersonPhone p
--JOIN
--	fn_PhoneByPhoneID(null) AS Phone ON Phone.PhoneID = p.PhoneID
--INNER JOIN PhoneType pt on phone.PhoneTypeID = pt.PhoneTypeID
--WHERE pt.PhoneTypeName IN ('Email', 'Pager (Alpha)', 'Pager (AutoResponse)');
