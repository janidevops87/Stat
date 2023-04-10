IF OBJECT_ID('Api.GetWebReportGroupSourceCodes') IS NOT NULL 
DROP FUNCTION Api.GetWebReportGroupSourceCodes;
GO

CREATE FUNCTION Api.GetWebReportGroupSourceCodes
(
	@webReportGroupId int
)
RETURNS TABLE AS RETURN
(
	SELECT SourceCodeID FROM dbo.fn_SourceCodeList(@webReportGroupID, NULL)
);

GO
