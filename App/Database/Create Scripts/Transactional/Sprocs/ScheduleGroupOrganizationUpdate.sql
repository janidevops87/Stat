  

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ScheduleGroupOrganizationUpdate')
	BEGIN
		PRINT 'Dropping Procedure ScheduleGroupOrganizationUpdate'
		DROP Procedure ScheduleGroupOrganizationUpdate
	END
GO

PRINT 'Creating Procedure ScheduleGroupOrganizationUpdate'
GO
CREATE Procedure ScheduleGroupOrganizationUpdate
(
		@ScheduleGroupOrganizationID int = null output,
		@ScheduleGroupID int = null,
		@OrganizationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null
)
AS
/******************************************************************************
**	File: ScheduleGroupOrganizationUpdate.sql
**	Name: ScheduleGroupOrganizationUpdate
**	Desc: Updates ScheduleGroupOrganization Based on Id field 
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
	dbo.ScheduleGroupOrganization 	
SET 
		ScheduleGroupID = @ScheduleGroupID,
		OrganizationID = @OrganizationID,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag
WHERE 
	ScheduleGroupOrganizationID = @ScheduleGroupOrganizationID 				

GO

GRANT EXEC ON ScheduleGroupOrganizationUpdate TO PUBLIC
GO
 