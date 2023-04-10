

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationPhoneListSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationPhoneListSelect'
		DROP Procedure OrganizationPhoneListSelect
	END
GO

PRINT 'Creating Procedure OrganizationPhoneListSelect'
GO
CREATE Procedure OrganizationPhoneListSelect
(
		@OrganizationID int = null
)
AS
/******************************************************************************
**	File: OrganizationPhoneListSelect.sql
**	Name: OrganizationPhoneListSelect
**	Desc: Selects multiple rows of OrganizationPhone Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/13/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/13/2011		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		OrganizationPhone.PhoneID AS ListId,
		CONVERT(NVARCHAR, Phone.Phone) as FieldValue
	FROM 
		dbo.OrganizationPhone
	LEFT JOIN
		fn_PhoneByPhoneID(null) AS Phone ON Phone.PhoneID = OrganizationPhone.PhoneID			 
	WHERE 
		OrganizationPhone.OrganizationID = ISNULL(@OrganizationID, OrganizationPhone.OrganizationID)
	ORDER BY 2
GO

GRANT EXEC ON OrganizationPhoneListSelect TO PUBLIC
GO
