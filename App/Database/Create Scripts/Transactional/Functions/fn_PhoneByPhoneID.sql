 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'IF' AND name = 'fn_PhoneByPhoneID')
	BEGIN
		PRINT 'Dropping Function fn_PhoneByPhoneID'
		DROP Function fn_PhoneByPhoneID
	END
GO

PRINT 'Creating Function fn_PhoneByPhoneID' 
GO 

CREATE FUNCTION dbo.fn_PhoneByPhoneID
(
	@PhoneId int = null
)  
RETURNS TABLE
AS

/******************************************************************************
**	File: fn_PhoneByPhoneID.sql
**	Name: fn_PhoneByPhoneID
**	Desc: Get all the calls that this employee has access to 
**	Auth: Tanvir Ather
**	Date: 03/02/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	03/02/2009	Tanvir Ather	Initial Function Creation
**  07/14/10	Bret Knoll		Adding to release 
*******************************************************************************/

RETURN  
SELECT
		Phone.PhoneID,
		Phone.PhoneAreaCode,
		Phone.PhonePrefix,
		Phone.PhoneNumber,
		Phone.PhonePin,
		Phone.PhoneTypeID,
		Phone.Verified,
		Phone.Inactive,
		Phone.LastModified,
		Phone.Unused,
		Phone.UpdatedFlag,
		'(' + Phone.PhoneAreaCode + ') ' + Phone.PhonePrefix + '-' + Phone.PhoneNumber AS Phone
	FROM 
		dbo.Phone 
	WHERE 
		Phone.PhoneID = ISNULL(@PhoneID, Phone.PhoneID)
GO




