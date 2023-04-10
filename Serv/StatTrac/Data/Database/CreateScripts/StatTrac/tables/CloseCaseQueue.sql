PRINT 'Table CloseCaseQueue'
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'CloseCaseQueue')
	BEGIN
		CREATE TABLE CloseCaseQueue
		(
		   CloseCaseQueueID INT IDENTITY(1,1),
		   CallID INT,
		   LastModified DateTime


		)

		GRANT SELECT ON CloseCaseQueue TO PUBLIC

		

	END

IF NOT EXISTS (SELECT     sysobjects.name, sysobjects.id, sysobjects.xtype, sysobjects.uid, sysobjects.info, sysobjects.status, sysobjects.base_schema_ver, 
                                     sysobjects.replinfo, sysobjects.parent_obj, sysobjects.crdate, sysobjects.ftcatid, sysobjects.schema_ver, sysobjects.stats_schema_ver, 
                                     sysobjects.type, sysobjects.userstat, sysobjects.sysstat, sysobjects.indexdel, sysobjects.refdate, sysobjects.version, sysobjects.deltrig, 
                                     sysobjects.instrig, sysobjects.updtrig, sysobjects.seltrig, sysobjects.category, sysobjects.cache, syscolumns.name AS columName
               FROM         sysobjects INNER JOIN
                                     syscolumns ON syscolumns.id = sysobjects.id
               WHERE     (sysobjects.id = OBJECT_ID(N'[dbo].[CloseCaseQueue]')) AND (OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1) AND 
                                     (syscolumns.name IN (N'ExportFileID', N'Enabled')))
BEGIN
	
	/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT
	BEGIN TRANSACTION

	ALTER TABLE dbo.CloseCaseQueue ADD
			ExportFileID INT,
			Enabled BIT


	COMMIT
END	
