		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaOrganizationDelete')
			BEGIN
				PRINT 'Dropping Procedure CriteriaOrganizationDelete'
				DROP Procedure CriteriaOrganizationDelete
			END
		GO

		PRINT 'Creating Procedure CriteriaOrganizationDelete'
		GO

		CREATE PROCEDURE dbo.CriteriaOrganizationDelete
		(	
			@CriteriaOrganizationID int = null,
			@OrganizationID int = null,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: CriteriaOrganizationDelete.sql 
		**	Name: CriteriaOrganizationDelete
		**	Desc: Updates and Deletes a row of CriteriaOrganization, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 12/16/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/16/2009		ccarroll			Initial Sproc Creation
		**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
		**  08/11/2011		ccarroll			Updated to handle cascade delete from Organization
		*******************************************************************************/
SET NOCOUNT ON

IF (COALESCE(@CriteriaOrganizationID, @OrganizationID, 0) > 0)
BEGIN
		UPDATE CriteriaOrganization
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			CriteriaOrganizationID = COALESCE(@CriteriaOrganizationID, CriteriaOrganizationID) AND
			OrganizationID = COALESCE(@OrganizationID, OrganizationID)
		DELETE 
			CriteriaOrganization
		WHERE
			CriteriaOrganizationID = COALESCE(@CriteriaOrganizationID, CriteriaOrganizationID) AND
			OrganizationID = COALESCE(@OrganizationID, OrganizationID)

END
GO
GRANT EXEC ON CriteriaOrganizationDelete TO PUBLIC
GO
		