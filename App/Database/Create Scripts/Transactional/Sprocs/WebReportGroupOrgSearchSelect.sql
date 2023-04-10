 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'WebReportGroupOrgSearchSelect')
	BEGIN
		PRINT 'Dropping Procedure WebReportGroupOrgSearchSelect'
		DROP Procedure WebReportGroupOrgSearchSelect
	END
GO

PRINT 'Creating Procedure WebReportGroupOrgSearchSelect'
GO 
CREATE Procedure WebReportGroupOrgSearchSelect
(
		@OrganizationID int
)
AS
/******************************************************************************
**	File: WebReportGroupOrgSearchSelect.sql
**	Name: WebReportGroupOrgSearchSelect
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
	SET NOCOUNT ON 
	
	
	SELECT DISTINCT WebReportGroupID
	FROM WebReportGroupOrg 
	WHERE OrganizationID = @OrganizationID;

	
GO

GRANT EXEC ON WebReportGroupOrgSearchSelect TO PUBLIC
GO
