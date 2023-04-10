   /* delete CriteriaOrganization where Organization ID = 0

 
 */
SET ROWCOUNT 1500
 DECLARE  @RecordCount int
 SET @RecordCount = 1
 WHILE @RecordCount > 0
 BEGIN
	DELETE FROM CriteriaOrganization
	WHERE     (OrganizationID = 0)
	
	WAITFOR DELAY '00:00:08'
	SET @RecordCount = @@RowCount
 END 

  
DECLARE @loopCount int,
		 @loopMax	int
		 
DECLARE @dupTable TABLE
	(
		ID int identity(1,1),
		CriteriaID int,
		OrganizationID int,
		RCount	int
	)
 
 INSERT @dupTable (CriteriaID, OrganizationID, RCount)
 SELECT     CriteriaID, OrganizationID, COUNT(*) AS [Count]
 FROM         CriteriaOrganization
 WHERE     (OrganizationID <> 0)
 GROUP BY CriteriaID, OrganizationID
 HAVING      (COUNT(*) > 1)
 
 
 SELECT co.* FROM CriteriaOrganization co
 join 
	@dupTable dt on 
	dt.CriteriaID = co.CriteriaID 
and 
	dt.OrganizationID = co.OrganizationID
order by lastmodified,  co.organizationID	
select @loopCount = 1,
	@loopMax = Count(*) from @dupTable
	
-- only delete one record
SET RowCount 1
WHILE @loopCount <= @loopMax
BEGIN
	
	delete CriteriaOrganization 
	where 
		CriteriaID = (select CriteriaID from @dupTable where ID = @loopCount)
	and 
		OrganizationID = (select OrganizationID from @dupTable where ID = @loopCount)
	SET @loopCount = @loopCount + 1
END

 /* do ANY organization exist with an ID of 0
 SELECT     *, OrganizationID AS Expr1
 FROM         Organization
 WHERE     (OrganizationID = 0)
 */
 
 
 
 

 