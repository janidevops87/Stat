IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeTransplantCenterInsert')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeTransplantCenterInsert'
		DROP Procedure SourceCodeTransplantCenterInsert
	END
GO

PRINT 'Creating Procedure SourceCodeTransplantCenterInsert'
GO
CREATE Procedure SourceCodeTransplantCenterInsert
(
		@SourceCodeTransplantCenterID int = null output,
		@SourceCodeID int = null,
		@OrganizationID int = null,
		@TransplantCode varchar(50) = null,
		@OrganizationName nvarchar(80) = null,
		@OrganType nvarchar(50) = null,
		@MessageOrganizationID int = null,
		@MessageOrganizationName nvarchar(80) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: SourceCodeTransplantCenterInsert.sql
**	Name: SourceCodeTransplantCenterInsert
**	Desc: Inserts SourceCodeTransplantCenter Based on Id field 
**	Auth: ccarroll
**	Date: 11/12/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/12/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	SourceCodeTransplantCenter
	(
		SourceCodeID,
		OrganizationID,
		TransplantCode,
		OrganizationName,
		OrganType,
		MessageOrganizationID,
		MessageOrganizationName,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@SourceCodeID,
		@OrganizationID,
		@TransplantCode,
		@OrganizationName,
		@OrganType,
		@MessageOrganizationID,
		@MessageOrganizationName,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @SourceCodeTransplantCenterID = SCOPE_IDENTITY()

EXEC SourceCodeTransplantCenterSelect @SourceCodeTransplantCenterID

GO

GRANT EXEC ON SourceCodeTransplantCenterInsert TO PUBLIC
GO
