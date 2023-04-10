 /***************************************************************************************************
**	Name: PhoneType
**	Desc: Add Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/09/2009	Bret Knoll		Initial Script Creation
**	5/26/2011	Bret Knoll		add Fax(Home) and (work)
***************************************************************************************************/
DECLARE @phoneTypeName NVARCHAR(100)
DECLARE @PhoneTypeList table
(
	phoneTypeName NVARCHAR(100)
)
INSERT @PhoneTypeList
VALUES
	('Call Back'),
	('Fax (Home)'),
	('Fax (Office)')
	
WHILE EXISTS (SELECT * FROM @PhoneTypeList)
BEGIN
	SELECT TOP 1 @phoneTypeName = phoneTypeName FROM @PhoneTypeList

	IF NOT EXISTS(SELECT PhoneTypeID FROM PhoneType Where PHoneTypeName = @phoneTypeName)
	BEGIN	
		PRINT 'Add new PhoneType'

		INSERT PhoneType 
			(PhoneTypeName, Verified, Inactive, LastModified, UpdatedFlag)
		VALUES(@phoneTypeName, 0, 0, GetDate(), NULL)
	END

	DELETE @PhoneTypeList WHERE phoneTypeName = @phoneTypeName 
END

update PhoneType 
set Inactive = 1
where PhoneTypeName = 'Call Back'