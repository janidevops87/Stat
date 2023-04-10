 /******************************************************************************
**		File: SourceCodeType.sql
**		Name: SourceCodeType
**		Desc: Creates the table SourceCodeType
**		Auth: Bret Knoll
**		Date: 6/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		----------	----------------	-------------------------------------------
**		6/19/2009	Bret Knoll		Initial Table Creation
**	Revisions:
**  ccarroll 07/09/2010 added this note for development build (GenerateSQL)
*******************************************************************************/

-- DROP TABLE dbo.SourceCodeType
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'SourceCodeType')
BEGIN
	PRINT 'Creating Table SourceCodeType'
	CREATE TABLE dbo.SourceCodeType
	(
		SourceCodeTypeId int NOT NULL,
		SourceCodeTypeName nvarchar(25) NULL,
		LastStatEmployeeID int NULL,
		LastModified datetime NULL,
		AuditLogTypeID int NULL
		
	)
END
GO

GRANT SELECT ON SourceCodeType TO PUBLIC
GO
