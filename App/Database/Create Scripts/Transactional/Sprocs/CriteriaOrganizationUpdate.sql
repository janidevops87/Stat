 IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaOrganizationUpdate')
	BEGIN
		PRINT 'Dropping Procedure CriteriaOrganizationUpdate'
		DROP Procedure CriteriaOrganizationUpdate
	END
GO

PRINT 'Creating Procedure CriteriaOrganizationUpdate'
GO
CREATE Procedure CriteriaOrganizationUpdate
(
		@CriteriaOrganizationID int = null output,
		@CriteriaID int = null,
		@OrganizationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: CriteriaOrganizationUpdate.sql
**	Name: CriteriaOrganizationUpdate
**	Desc: Updates CriteriaOrganization Based on Id field 
**	Auth: ccarroll
**	Date: 12/16/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/16/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.CriteriaOrganization 	
SET 
		CriteriaID = @CriteriaID,
		OrganizationID = @OrganizationID,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	CriteriaOrganizationID = @CriteriaOrganizationID 				

GO

GRANT EXEC ON CriteriaOrganizationUpdate TO PUBLIC
GO
