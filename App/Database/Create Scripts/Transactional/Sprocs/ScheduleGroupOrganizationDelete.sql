   
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ScheduleGroupOrganizationDelete')
			BEGIN
				PRINT 'Dropping Procedure ScheduleGroupOrganizationDelete'
				DROP Procedure ScheduleGroupOrganizationDelete
			END
		GO

		PRINT 'Creating Procedure ScheduleGroupOrganizationDelete'
		GO

		CREATE PROCEDURE dbo.ScheduleGroupOrganizationDelete
		(	
			@ScheduleGroupOrganizationID int = null,
			@OrganizationID int = null,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: ScheduleGroupOrganizationDelete.sql 
		**	Name: ScheduleGroupOrganizationDelete
		**	Desc: Updates and Deletes a row of ScheduleGroupOrganization, updating AuditTrail
		**	Auth: ccarroll	
		**	Date: 05/16/2011
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	05/16/2011		ccarroll			Initial Sproc Creation
		**  08/11/2011		ccarroll			Updated to handle cascade delete from Organization
		*******************************************************************************/
SET NOCOUNT ON

IF (COALESCE(@ScheduleGroupOrganizationID, @OrganizationID, 0) > 0)
BEGIN
		UPDATE ScheduleGroupOrganization
		SET		
			LastModified = GetDate()

		WHERE
			ScheduleGroupOrganizationID = COALESCE(@ScheduleGroupOrganizationID, ScheduleGroupOrganizationID) AND
			OrganizationID = COALESCE(@OrganizationID, OrganizationID)
			
		DELETE 
			ScheduleGroupOrganization
		WHERE
			ScheduleGroupOrganizationID = COALESCE(@ScheduleGroupOrganizationID, ScheduleGroupOrganizationID) AND
			OrganizationID = COALESCE(@OrganizationID, OrganizationID)

END

GO
GRANT EXEC ON ScheduleGroupOrganizationDelete TO PUBLIC
GO
		