IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'WebReportGroupOrgInsert')
	BEGIN
		PRINT 'Dropping Procedure WebReportGroupOrgInsert'
		DROP Procedure WebReportGroupOrgInsert
	END
GO

PRINT 'Creating Procedure WebReportGroupOrgInsert'
GO
CREATE Procedure WebReportGroupOrgInsert
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
**	File: WebReportGroupOrgInsert.sql
**	Name: WebReportGroupOrgInsert
**	Desc: Inserts WebReportGroupOrg Based on Id field 
**	Auth: ccarroll	
**	Date: 05/13/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/13/2011		ccarroll				Initial Sproc Creation
**  06/13/2012		ccarroll				Added check for duplicates
*******************************************************************************/

DECLARE @ExistingWebReportGroupOrgID int 

SET  @ExistingWebReportGroupOrgID = (SELECT TOP 1 WebReportGroupOrgID FROM WebReportGroupOrg WHERE OrganizationID = @OrganizationID AND WebReportGroupID = @WebReportGroupID)
IF (IsNull(@ExistingWebReportGroupOrgID, 0)) = 0

BEGIN
INSERT	WebReportGroupOrg
	(
		ReportID,
		WebReportGroupID,
		OrganizationID,
		PersonID,
		LastModified,
		UpdatedFlag
	)
VALUES
	(
		@ReportID,
		@WebReportGroupID,
		@OrganizationID,
		@PersonID,
		IsNull(@LastModified, GetDate()),
		@UpdatedFlag
	)

SET @WebReportGroupOrgID = SCOPE_IDENTITY()
END
ELSE
BEGIN
SET @WebReportGroupOrgID = @ExistingWebReportGroupOrgID
END



EXEC WebReportGroupOrgSelect @WebReportGroupOrgID

GO

GRANT EXEC ON WebReportGroupOrgInsert TO PUBLIC
GO
