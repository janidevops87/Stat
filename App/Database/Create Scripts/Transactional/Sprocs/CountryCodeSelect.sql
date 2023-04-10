

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CountryCodeSelect')
	BEGIN
		PRINT 'Dropping Procedure CountryCodeSelect'
		DROP Procedure CountryCodeSelect
	END
GO

PRINT 'Creating Procedure CountryCodeSelect'
GO
CREATE Procedure CountryCodeSelect
(
		@CountryCodeId int = null,					
		@CountryId int = null
)
AS
/******************************************************************************
**	File: CountryCodeSelect.sql
**	Name: CountryCodeSelect
**	Desc: Selects multiple rows of CountryCode Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/13/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		CountryCode.CountryCodeId,
		CountryCode.CountryCode,
		CountryCode.CountryId,
		CountryCode.LastModified,
		CountryCode.LastStatEmployeeId,
		CountryCode.AuditLogTypeId
	FROM 
		dbo.CountryCode 
	WHERE 
		CountryCode.CountryCodeId = ISNULL(@CountryCodeId, CountryCodeId)				
	AND
		CountryCode.CountryId = ISNULL(@CountryId, CountryId)	
	ORDER BY 1
GO

GRANT EXEC ON CountryCodeSelect TO PUBLIC
GO
