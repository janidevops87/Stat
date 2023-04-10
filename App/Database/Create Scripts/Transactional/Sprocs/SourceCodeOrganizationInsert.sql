IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeOrganizationInsert')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeOrganizationInsert'
		DROP Procedure SourceCodeOrganizationInsert
	END
GO

PRINT 'Creating Procedure SourceCodeOrganizationInsert'
GO
CREATE Procedure SourceCodeOrganizationInsert
(
		@SourceCodeOrganizationID int = null output,
		@SourceCodeID int = null,
		@OrganizationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: SourceCodeOrganizationInsert.sql
**	Name: SourceCodeOrganizationInsert
**	Desc: Inserts SourceCodeOrganization Based on Id field 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	SourceCodeOrganization
	(
		SourceCodeID,
		OrganizationID,
		LastModified,
		UpdatedFlag,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@SourceCodeID,
		@OrganizationID,
		@LastModified,
		@UpdatedFlag,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @SourceCodeOrganizationID = SCOPE_IDENTITY()

EXEC SourceCodeOrganizationSelect @SourceCodeOrganizationID

GO

GRANT EXEC ON SourceCodeOrganizationInsert TO PUBLIC
GO
