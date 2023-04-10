 
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'WebReportGroupOrgDelete')
			BEGIN
				PRINT 'Dropping Procedure WebReportGroupOrgDelete'
				DROP Procedure WebReportGroupOrgDelete
			END
		GO

		PRINT 'Creating Procedure WebReportGroupOrgDelete'
		GO

		CREATE PROCEDURE dbo.WebReportGroupOrgDelete
		(	
			@WebReportGroupOrgID int = null,
			@OrganizationID int = null,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: WebReportGroupOrgDelete.sql 
		**	Name: WebReportGroupOrgDelete
		**	Desc: Updates and Deletes a row of WebReportGroupOrg, updating AuditTrail
		**	Auth: ccarroll	
		**	Date: 05/13/2011
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	05/13/2011		ccarroll			Initial Sproc Creation
		**  08/11/2011		ccarroll			Updated to handle cascade delete from Organization
		*******************************************************************************/
IF (COALESCE(@WebReportGroupOrgID, @OrganizationID, 0) > 0)
BEGIN
		UPDATE WebReportGroupOrg
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			WebReportGroupOrgID = COALESCE(@WebReportGroupOrgID, WebReportGroupOrgID) AND
			OrganizationID = COALESCE(@OrganizationID, OrganizationID)
		DELETE 
			WebReportGroupOrg
		WHERE
			WebReportGroupOrgID = COALESCE(@WebReportGroupOrgID, WebReportGroupOrgID) AND
			OrganizationID = COALESCE(@OrganizationID, OrganizationID)
END
GO
GRANT EXEC ON WebReportGroupOrgDelete TO PUBLIC
GO
		