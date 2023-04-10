IF OBJECT_ID('Api.GetWebReportGroupOrganizationIds') IS NOT NULL 
DROP FUNCTION Api.GetWebReportGroupOrganizationIds;
GO


CREATE FUNCTION Api.GetWebReportGroupOrganizationIds
(
	@webReportGroupId int
)
RETURNS TABLE AS RETURN
(
SELECT OrganizationID 
FROM dbo.WebReportGroupOrg 
WHERE WebReportGroupID = @webReportGroupId
);

GO
