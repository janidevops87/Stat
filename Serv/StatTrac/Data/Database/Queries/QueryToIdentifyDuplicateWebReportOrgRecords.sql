SET ROWCOUNT 1500
 DECLARE  @RecordCount int
 SET @RecordCount = 1
 WHILE @RecordCount > 0
 BEGIN
	DELETE FROM WebReportGroupOrg
	WHERE     (OrganizationID = 0)
	
	WAITFOR DELAY '00:00:03'
	SET @RecordCount = @@RowCount
 END


SELECT     COUNT(*) AS [Count], WebReportGroupID, OrganizationID
FROM         WebReportGroupOrg
GROUP BY WebReportGroupID, OrganizationID
HAVING      (COUNT(*) > 1) 