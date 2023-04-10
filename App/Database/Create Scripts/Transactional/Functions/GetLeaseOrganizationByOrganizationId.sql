IF EXISTS (SELECT * FROM sysobjects WHERE type = 'IF' AND name = 'GetLeaseSourceCodeByOrganizationId')
	BEGIN
		PRINT 'Dropping Function GetLeaseSourceCodeByOrganizationId'
		DROP Function GetLeaseSourceCodeByOrganizationId
	END
GO

PRINT 'Creating Function GetLeaseSourceCodeByOrganizationId' 
GO 

CREATE FUNCTION dbo.GetLeaseSourceCodeByOrganizationId 
(
	@OrganizationId  int
)  
RETURNS TABLE
AS

/******************************************************************************
**	File: GetLeaseSourceCodeByOrganizationId.sql
**	Name: GetLeaseSourceCodeByOrganizationId
**	Desc: Get all the calls that this employee has access to 
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

SELECT distinct wrgsc.SourceCodeId
FROM Organization org
	inner join WebReportGroup wrg ON org.OrganizationID = wrg.OrgHierarchyParentId
	inner join WebReportGroupSourceCode wrgsc ON wrg.WebReportGroupId = wrgsc.WebReportGroupId
WHERE @OrganizationId = 194 -- 194 is the Statline Organization
	AND org.OrganizationLO = -1
	AND org.OrganizationLOEnabled = 0 
GO




