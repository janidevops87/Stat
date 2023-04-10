IF EXISTS (SELECT * FROM sysobjects WHERE type = 'IF' AND name = 'GetSourceCodeByOrganizationId')
	BEGIN
		PRINT 'Dropping Function GetSourceCodeByOrganizationId'
		DROP Function GetSourceCodeByOrganizationId
	END
GO

PRINT 'Creating Function GetSourceCodeByOrganizationId' 
GO 

CREATE FUNCTION dbo.GetSourceCodeByOrganizationId 
(
	@OrganizationId int
)  
RETURNS TABLE
AS

/******************************************************************************
**	File: GetSourceCodeByOrganizationId.sql
**	Name: GetSourceCodeByOrganizationId
**	Desc: Get all the source code that this organization has access to
**	Auth: Tanvir Ather
**	Date: 03/02/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	03/02/2009	Tanvir Ather	Initial Function Creation
*******************************************************************************/

RETURN

Select distinct wrgsc.SourceCodeId
from Organization org
	inner join WebReportGroup wrg ON org.OrganizationID = wrg.OrgHierarchyParentId
	inner join WebReportGroupSourceCode wrgsc ON wrg.WebReportGroupId = wrgsc.WebReportGroupId
WHERE
	-- If this is a Statline than get all the source code that is not a lease organization
	(@OrganizationId = 194 AND 
		wrgsc.SourceCodeId NOT IN -- exclude all the source code where Lease organization is not enabled
		(
			SELECT distinct wrgsc.SourceCodeId
			FROM Organization org
				inner join WebReportGroup wrg ON org.OrganizationID = wrg.OrgHierarchyParentId
				inner join WebReportGroupSourceCode wrgsc ON wrg.WebReportGroupId = wrgsc.WebReportGroupId
			WHERE org.OrganizationLO = -1
				AND org.OrganizationLOEnabled = -1
		)
	)
		 
	-- If the organizatin is not Statline than get only the source code for that organization
	OR  (@OrganizationId != 194 AND org.OrganizationId = @OrganizationId)

GO


