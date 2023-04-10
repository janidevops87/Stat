

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IddSelect')
	BEGIN
		PRINT 'Dropping Procedure IddSelect'
		DROP Procedure IddSelect
	END
GO

PRINT 'Creating Procedure IddSelect'
GO
CREATE Procedure IddSelect
(
		@IddId int = null,
		@CountryId int = null
)
AS
/******************************************************************************
**	File: IddSelect.sql
**	Name: IddSelect
**	Desc: Selects multiple rows of Idd Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/13/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Idd.IddId,
		Idd.CountryId,		
		Idd.Idd,
		Idd.LastModified,
		Idd.LastStatEmployeeId,
		Idd.AuditLogTypeId
	FROM 
		dbo.Idd 
	WHERE 
		Idd.IddId = ISNULL(@IddId, IddId)
	AND
		Idd.CountryId = ISNULL(@CountryId, Idd.CountryId)
	ORDER BY 1
GO

GRANT EXEC ON IddSelect TO PUBLIC
GO
