

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AlertOrganizationUpdate')
	BEGIN
		PRINT 'Dropping Procedure AlertOrganizationUpdate'
		DROP Procedure AlertOrganizationUpdate
	END
GO

PRINT 'Creating Procedure AlertOrganizationUpdate'
GO
CREATE Procedure AlertOrganizationUpdate
(
		@AlertOrganizationID int = null output,
		@AlertID int = null,		
		@OrganizationID int = null,		
		@LastModified datetime = null,
		@UpdatedFlag smallint = null					
)
AS
/******************************************************************************
**	File: AlertOrganizationUpdate.sql
**	Name: AlertOrganizationUpdate
**	Desc: Updates AlertOrganization Based on Id field 
**	Auth: Bret Knoll
**	Date: 1/26/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/26/2011		Bret Knoll			Initial Sproc Creation (9376)
*******************************************************************************/

UPDATE
	dbo.AlertOrganization 	
SET 
		AlertID = @AlertID,
		OrganizationID = @OrganizationID,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag
WHERE 
	AlertOrganizationID = @AlertOrganizationID 				

GO

GRANT EXEC ON AlertOrganizationUpdate TO PUBLIC
GO
