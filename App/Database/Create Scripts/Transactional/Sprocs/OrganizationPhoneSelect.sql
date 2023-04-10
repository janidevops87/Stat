

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationPhoneSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationPhoneSelect'
		DROP Procedure OrganizationPhoneSelect
	END
GO

PRINT 'Creating Procedure OrganizationPhoneSelect'
GO
CREATE Procedure OrganizationPhoneSelect
(
		@OrganizationPhoneID int = null,
		@OrganizationID int = null,
		@PhoneID int = null,
		@SubLocationID int = null,
		@SubLocationLevel varchar(5) = null,
		@PhoneTypeID int = null,	
		@Phone nvarchar(45) = null,
		@ExcludeOrganizationId int = null								
)
AS
/******************************************************************************
**	File: OrganizationPhoneSelect.sql
**	Name: OrganizationPhoneSelect
**	Desc: Selects multiple rows of OrganizationPhone Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	7/13/2009		Bret Knoll			Initial Sproc Creation
**	12/02/2010		Bret Knoll			Add Functionality to search by Phone
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE
		@PhoneAreaCode varchar(3) = null,
		@PhonePrefix varchar(3) = null,
		@PhoneNumber varchar(4) = null

	IF (@Phone IS NOT NULL)
	BEGIN
		SELECT 
		@PhoneAreaCode = PhoneAreaCode, 
		@PhonePrefix = PhonePrefix, 
		@PhoneNumber = PhoneNumber 
		FROM
			fn_PhoneParse(@Phone)	
	END
	
	SELECT
		OrganizationPhone.OrganizationPhoneID,
		OrganizationPhone.OrganizationID,		
		OrganizationPhone.PhoneID,
		Phone.Phone,
		PhoneType.PhoneTypeID,
		PhoneType.PhoneTypeName AS PhoneType,
		OrganizationPhone.LastModified,
		OrganizationPhone.LastStatEmployeeId,
		OrganizationPhone.AuditLogTypeId,
		OrganizationPhone.SubLocationID,
		SubLocationName AS SubLocation,
		OrganizationPhone.SubLocationLevelID AS SubLocationLevelID, 
		IsNull(SubLocationLevel, SubLocationLevel.SubLocationLevelName) AS SubLocationLevel,
		OrganizationPhone.Inactive
		
	FROM 
		dbo.OrganizationPhone 
	LEFT JOIN
		fn_PhoneByPhoneID(null) AS Phone ON Phone.PhoneID = OrganizationPhone.PhoneID	
	LEFT JOIN
		SubLocation ON SubLocation.SubLocationID = OrganizationPhone.SubLocationID
	LEFT JOIN 
		PhoneType ON PhoneType.PhoneTypeID = Phone.PhoneTypeID	
	--keeping for now for older cases and if there are spots that is using the sublocationLevelId
	LEFT JOIN SubLocationLevel ON SubLocationLevel.SubLocationLevelID = OrganizationPhone.SubLocationLevelID
	WHERE 
		OrganizationPhone.OrganizationPhoneID = COALESCE(@OrganizationPhoneID, OrganizationPhoneID)
	AND
		OrganizationPhone.OrganizationID = COALESCE(@OrganizationID, OrganizationID)
	AND
		OrganizationPhone.PhoneID = COALESCE(@PhoneID, OrganizationPhone.PhoneID)				
	AND
		Phone.PhoneTypeID = COALESCE(@PhoneTypeID, Phone.PhoneTypeID)	
	AND
		Phone.PhoneAreaCode = COALESCE(@PhoneAreaCode, Phone.PhoneAreaCode)	
	AND 
		Phone.PhonePrefix = COALESCE(@PhonePrefix, Phone.PhonePrefix)	
	AND
		Phone.PhoneNumber = COALESCE(@PhoneNumber, Phone.PhoneNumber)	
	AND
		(
			@ExcludeOrganizationId IS NULL
			OR
			OrganizationPhone.OrganizationID <> @ExcludeOrganizationId

		)						

	ORDER BY 1
	
GO

GRANT EXEC ON OrganizationPhoneSelect TO PUBLIC
GO
