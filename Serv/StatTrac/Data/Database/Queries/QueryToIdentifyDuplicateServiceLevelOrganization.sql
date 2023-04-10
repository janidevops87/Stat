 -- SET ROWCOUNT 1500
 DECLARE  @RecordCount int
 SET @RecordCount = 1
 WHILE @RecordCount > 0
 BEGIN
	DELETE 
		ServiceLevel30Organization
	FROM         
		(SELECT     
			TOP 1500 *
         FROM          
			ServiceLevel30Organization) AS T1
	WHERE     
		ServiceLevel30Organization.ServiceLevelOrganizationID = T1.ServiceLevelOrganizationID	AND 
		(ServiceLevel30Organization.OrganizationID = 0) 

	WAITFOR 
		DELAY '00:00:03'
	SET @RecordCount = @@RowCount
 END 
  
DECLARE @loopCount int,
		 @loopMax	int
		 
DECLARE @dupTable TABLE
	(
		ID int identity(1,1),
		ServiceLevelID int,
		OrganizationID int,
		RCount	int
	)
 
 INSERT @dupTable (ServiceLevelID, OrganizationID, RCount) 
 SELECT     ServiceLevelID, OrganizationID, COUNT(*) AS [count]
 FROM         ServiceLevel30Organization
 GROUP BY ServiceLevelID, OrganizationID
 HAVING      (COUNT(*) > 1)
 
SELECT co.* FROM ServiceLevel30Organization co
 join 
	@dupTable dt on 
	dt.ServiceLevelID = co.ServiceLevelID 
and 
	dt.OrganizationID = co.OrganizationID
order by lastmodified,  co.organizationID	
select @loopCount = 1,
	@loopMax = Count(*) from @dupTable
	
-- only delete one record
-- SET RowCount 1
WHILE @loopCount <= @loopMax
BEGIN
	
	delete ServiceLevel30Organization 
	FROM (SELECT TOP 1 * FROM ServiceLevel30Organization )T1
	where 
		ServiceLevel30Organization.ServiceLevelOrganizationID = 
		T1.ServiceLevelOrganizationID		
	and	
		ServiceLevel30Organization.ServiceLevelID = (select ServiceLevelID from @dupTable where ID = @loopCount)
	and 
		ServiceLevel30Organization.OrganizationID = (select OrganizationID from @dupTable where ID = @loopCount)
	SET @loopCount = @loopCount + 1
END 