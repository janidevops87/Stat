 DECLARE  @RecordCount int
 SET @RecordCount = 1
 WHILE @RecordCount > 0
 BEGIN
	DELETE 
		ScheduleGroupOrganization
	FROM         
		(SELECT     
			TOP 1500 *
         FROM          
			ScheduleGroupOrganization
		WHERE
				(
				ScheduleGroupOrganization.OrganizationID = 0
				) 
		) AS T1
	WHERE     
		ScheduleGroupOrganization.ScheduleGroupOrganizationID = T1.ScheduleGroupOrganizationID
		
	
	SET @RecordCount = @@RowCount
	WAITFOR 
		DELAY '00:00:03'
	
 END 
 
 DECLARE @loopCount int,
		 @loopMax	int
		 
DECLARE @dupTable TABLE
	(
		ID int identity(1,1),
		ScheduleGroupID int,
		OrganizationID int,
		RCount	int
	)
 
 INSERT @dupTable (ScheduleGroupID, OrganizationID, RCount)
 SELECT     ScheduleGroupID, OrganizationID, COUNT(*) AS [Count]
 FROM         ScheduleGroupOrganization
 WHERE     (OrganizationID <> 0)
 GROUP BY ScheduleGroupID, OrganizationID
 HAVING      (COUNT(*) > 1)
 
 
 SELECT co.* FROM ScheduleGroupOrganization co
 join 
	@dupTable dt on 
	dt.ScheduleGroupID = co.ScheduleGroupID 
and 
	dt.OrganizationID = co.OrganizationID
order by lastmodified,  co.organizationID	
select @loopCount = 1,
	@loopMax = Count(*) from @dupTable
	
-- only delete one record
SET RowCount 1
WHILE @loopCount <= @loopMax
BEGIN
	
	delete ScheduleGroupOrganization 
	FROM (SELECT 
				TOP 1 * 
			FROM
				ScheduleGroupOrganization
			where 
				ScheduleGroupID = (select ScheduleGroupID from @dupTable where ID = @loopCount)
			and 
				OrganizationID = (select OrganizationID from @dupTable where ID = @loopCount)
		 )AS T1
	WHERE
		ScheduleGroupOrganization.ScheduleGroupOrganizationID = T1.ScheduleGroupOrganizationID  		
	
	SET @loopCount = @loopCount + 1
END
 
 
 
 SELECT     ScheduleGroupID, OrganizationID, COUNT(*) AS [count]
 FROM         ScheduleGroupOrganization
 GROUP BY ScheduleGroupID, OrganizationID
 HAVING      (COUNT(*) > 1)