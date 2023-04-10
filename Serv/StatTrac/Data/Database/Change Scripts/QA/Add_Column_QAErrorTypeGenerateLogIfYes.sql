/*
	08/17/2009 ccarroll - Add Column QAErrorTypeGenerateLogIfYes (used in reports) 
*/

    IF NOT EXISTS (select * from syscolumns where id=object_id('QAErrorType') and name like 'QAErrorTypeGenerateLogIfYes')
BEGIN
	PRINT 'Adding Column: QAErrorTypeGenerateLogIfYes'
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
	ALTER TABLE dbo.QAErrorType ADD
		QAErrorTypeGenerateLogIfYes smallint NOT NULL Default(0)
	
	COMMIT
END
