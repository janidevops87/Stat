 DECLARE  @RecordCount int
 SET @RecordCount = 1
 WHILE @RecordCount > 0
 BEGIN
	DELETE 
		SourceCodeOrganization
	FROM         
		(SELECT     
			TOP 1500 *
         FROM          
			SourceCodeOrganization
		WHERE
				(
				SourceCodeOrganization.OrganizationID = 0
				OR	
				SourceCodeOrganization.SourceCodeID = 0	
				) 
		) AS T1
	WHERE     
		SourceCodeOrganization.SourceCodeOrganizationID = T1.SourceCodeOrganizationID
		
	
	SET @RecordCount = @@RowCount
	WAITFOR 
		DELAY '00:00:03'
	
 END 
 
 
 
 SELECT     OrganizationID, SourceCodeID, COUNT(*) AS Expr1
 FROM         SourceCodeOrganization
 GROUP BY OrganizationID, SourceCodeID
 HAVING      (COUNT(*) > 1)
 
 
 