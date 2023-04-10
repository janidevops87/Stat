IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeTransplantCenterUpdate')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeTransplantCenterUpdate'
		DROP Procedure SourceCodeTransplantCenterUpdate
	END
GO

PRINT 'Creating Procedure SourceCodeTransplantCenterUpdate'
GO
CREATE Procedure SourceCodeTransplantCenterUpdate
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
**	File: SourceCodeTransplantCenterUpdate.sql
**	Name: SourceCodeTransplantCenterUpdate
**	Desc: Updates SourceCodeTransplantCenter Based on Id field 
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

UPDATE
	dbo.SourceCodeTransplantCenter 	
SET 
		SourceCodeID = @SourceCodeID,
		OrganizationID = @OrganizationID,
		TransplantCode = @TransplantCode,
		OrganizationName = @OrganizationName,
		OrganType = @OrganType,
		MessageOrganizationID = @MessageOrganizationID,
		MessageOrganizationName = @MessageOrganizationName,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	SourceCodeTransplantCenterID = @SourceCodeTransplantCenterID 				

GO

GRANT EXEC ON SourceCodeTransplantCenterUpdate TO PUBLIC
GO
