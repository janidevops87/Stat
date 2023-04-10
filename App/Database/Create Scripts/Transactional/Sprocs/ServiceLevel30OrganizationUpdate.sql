 

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevel30OrganizationUpdate')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevel30OrganizationUpdate'
		DROP Procedure ServiceLevel30OrganizationUpdate
	END
GO

PRINT 'Creating Procedure ServiceLevel30OrganizationUpdate'
GO
CREATE Procedure ServiceLevel30OrganizationUpdate
(
		@ServiceLevelOrganizationID int = null output,
		@ServiceLevelID int = null,
		@OrganizationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null
)
AS
/******************************************************************************
**	File: ServiceLevel30OrganizationUpdate.sql
**	Name: ServiceLevel30OrganizationUpdate
**	Desc: Updates ServiceLevel30Organization Based on Id field 
**	Auth: ccarroll	
**	Date: 05/16/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/16/2011		ccarroll				Initial Sproc Creation 
*******************************************************************************/

UPDATE
	dbo.ServiceLevel30Organization 	
SET 
		ServiceLevelID = @ServiceLevelID,
		OrganizationID = @OrganizationID,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag
WHERE 
	ServiceLevelOrganizationID = @ServiceLevelOrganizationID 				

GO

GRANT EXEC ON ServiceLevel30OrganizationUpdate TO PUBLIC
GO
 