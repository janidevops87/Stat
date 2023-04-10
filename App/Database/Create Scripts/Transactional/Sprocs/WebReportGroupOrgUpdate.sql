 

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'WebReportGroupOrgUpdate')
	BEGIN
		PRINT 'Dropping Procedure WebReportGroupOrgUpdate'
		DROP Procedure WebReportGroupOrgUpdate
	END
GO

PRINT 'Creating Procedure WebReportGroupOrgUpdate'
GO
CREATE Procedure WebReportGroupOrgUpdate
(
		@WebReportGroupOrgID int = null output,
		@ReportID int = null,
		@WebReportGroupID int = null,
		@OrganizationID int = null,
		@PersonID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null
)
AS
/******************************************************************************
**	File: WebReportGroupOrgUpdate.sql
**	Name: WebReportGroupOrgUpdate
**	Desc: Updates WebReportGroupOrg Based on Id field 
**	Auth: ccarroll	
**	Date: 05/13/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/13/2011		ccarroll				Initial Sproc Creation 
*******************************************************************************/

UPDATE
	dbo.WebReportGroupOrg 	
SET 
		ReportID = @ReportID,
		WebReportGroupID = @WebReportGroupID,
		OrganizationID = @OrganizationID,
		PersonID = @PersonID,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag
WHERE 
	WebReportGroupOrgID = @WebReportGroupOrgID 				

GO

GRANT EXEC ON WebReportGroupOrgUpdate TO PUBLIC
GO
