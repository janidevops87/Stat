
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'WebReportGroupOrgSelect')
	BEGIN
		PRINT 'Dropping Procedure WebReportGroupOrgSelect'
		DROP Procedure WebReportGroupOrgSelect
	END
GO

PRINT 'Creating Procedure WebReportGroupOrgSelect'
GO
CREATE Procedure WebReportGroupOrgSelect
(
		@WebReportGroupOrgID int = null,
		@WebReportGroupID int = null,
		@OrganizationID int = null
		 				
)
AS
/******************************************************************************
**	File: WebReportGroupOrgSelect.sql
**	Name: WebReportGroupOrgSelect
**	Desc: Selects multiple rows of WebReportGroupOrg Based on Id  fields 
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
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		WebReportGroupOrg.WebReportGroupOrgID,
		IsNull(WebReportGroupOrg.ReportID, 0) AS ReportID,
		IsNull(WebReportGroupOrg.WebReportGroupID, 0) AS WebReportGroupID,
		IsNull(WebReportGroupOrg.OrganizationID, 0) AS OrganizationID,
		IsNull(WebReportGroupOrg.PersonID, 0) AS PersonID,
		WebReportGroupOrg.LastModified,
		IsNull(WebReportGroupOrg.UpdatedFlag, 0) AS UpdatedFlag
	FROM 
		dbo.WebReportGroupOrg 
	WHERE 
		WebReportGroupOrg.WebReportGroupOrgID = ISNULL(@WebReportGroupOrgID, WebReportGroupOrg.WebReportGroupOrgID) AND
		WebReportGroupOrg.WebReportGroupID = ISNULL(@WebReportGroupID, WebReportGroupOrg.WebReportGroupID) AND
		WebReportGroupOrg.OrganizationID = ISNULL(@OrganizationID, WebReportGroupOrg.OrganizationID)
	ORDER BY 1
GO

GRANT EXEC ON WebReportGroupOrgSelect TO PUBLIC
GO
