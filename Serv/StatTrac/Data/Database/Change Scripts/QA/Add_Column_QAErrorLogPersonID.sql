/*
	03/3/2010 jth - Add Column QAErrorLogPersonID (needed for forms) 
*/

    IF NOT EXISTS (select * from syscolumns where id=object_id('QAErrorLog') and name like 'QAErrorLogPersonID')
BEGIN
	PRINT 'Adding Column: QAErrorLogPersonID'
	--Add column  
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT
	BEGIN TRANSACTION
	ALTER TABLE dbo.QAErrorLog ADD
		QAErrorLogPersonID int NULL 
	
	COMMIT
END
 