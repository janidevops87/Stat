IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeOrganizationUpdate')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeOrganizationUpdate'
		DROP Procedure SourceCodeOrganizationUpdate
	END
GO

PRINT 'Creating Procedure SourceCodeOrganizationUpdate'
GO
CREATE Procedure SourceCodeOrganizationUpdate
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
**	File: SourceCodeOrganizationUpdate.sql
**	Name: SourceCodeOrganizationUpdate
**	Desc: Updates SourceCodeOrganization Based on Id field 
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

UPDATE
	dbo.SourceCodeOrganization 	
SET 
		SourceCodeID = @SourceCodeID,
		OrganizationID = @OrganizationID,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	SourceCodeOrganizationID = @SourceCodeOrganizationID 				

GO

GRANT EXEC ON SourceCodeOrganizationUpdate TO PUBLIC
GO
