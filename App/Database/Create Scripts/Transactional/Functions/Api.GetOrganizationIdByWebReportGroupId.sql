IF OBJECT_ID('Api.GetOrganizationIdByWebReportGroupId') IS NOT NULL 
DROP FUNCTION Api.GetOrganizationIdByWebReportGroupId;
GO

CREATE FUNCTION Api.GetOrganizationIdByWebReportGroupId
(
	@webReportGroupId int
)
RETURNS INT
AS
BEGIN
	RETURN(SELECT TOP(1) OrganizationId FROM api.Configuration WHERE WebReportGroupId = @webReportGroupId);
END;
GO