 DECLARE  @RecordCount int
 SET @RecordCount = 1
 WHILE @RecordCount > 0
 BEGIN
	DELETE 
		AlertOrganization
	FROM         
		(SELECT     
			TOP 1500 *
         FROM          
			AlertOrganization
		WHERE
				(
				AlertOrganization.OrganizationID = 0
				) 
		) AS T1
	WHERE     
		AlertOrganization.AlertOrganizationID = T1.AlertOrganizationID
		
	
	SET @RecordCount = @@RowCount
	WAITFOR 
		DELAY '00:00:03'
	
 END 
 
 DECLARE @loopCount int,
		 @loopMax	int
		 
DECLARE @dupTable TABLE
	(
		ID int identity(1,1),
		AlertID int,
		OrganizationID int,
		RCount	int
	)
 
 INSERT @dupTable (AlertID, OrganizationID, RCount)
 SELECT     AlertID, OrganizationID, COUNT(*) AS [Count]
 FROM         AlertOrganization
 WHERE     (OrganizationID <> 0)
 GROUP BY AlertID, OrganizationID
 HAVING      (COUNT(*) > 1)
 
 
 SELECT co.* FROM AlertOrganization co
 join 
	@dupTable dt on 
	dt.AlertID = co.AlertID 
and 
	dt.OrganizationID = co.OrganizationID
order by lastmodified,  co.organizationID	
select @loopCount = 1,
	@loopMax = Count(*) from @dupTable
	
-- only delete one record
SET RowCount 1
WHILE @loopCount <= @loopMax
BEGIN
	
	delete AlertOrganization 
	FROM (SELECT 
				TOP 1 * 
			FROM
				AlertOrganization
			where 
				AlertID = (select AlertID from @dupTable where ID = @loopCount)
			and 
				OrganizationID = (select OrganizationID from @dupTable where ID = @loopCount)
		 )AS T1
	WHERE
		AlertOrganization.AlertOrganizationID = T1.AlertOrganizationID  		
	
	SET @loopCount = @loopCount + 1
END
 
 
 SELECT     AlertID, OrganizationID, COUNT(*) AS [Count]
 FROM         AlertOrganization
 GROUP BY AlertID, OrganizationID
 HAVING      (COUNT(*) > 1)
 
 SELECT     ScheduleGroupOrganization.*
 FROM         ScheduleGroupOrganization
 WHERE     (ScheduleGroupID = 249) AND (OrganizationID = 5972)
 
 
 
