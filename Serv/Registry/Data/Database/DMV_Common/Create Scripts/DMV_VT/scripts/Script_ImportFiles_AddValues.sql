 IF NOT EXISTS (SELECT * FROM ImportFiles WHERE TableName = 'IMPORT_A')
BEGIN
	INSERT ImportFiles (TableName, WorkOrder) VALUES ('IMPORT_A', 1)
END
