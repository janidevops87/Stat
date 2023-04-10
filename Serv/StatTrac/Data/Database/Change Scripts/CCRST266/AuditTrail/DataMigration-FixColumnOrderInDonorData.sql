--Data Migration Script
--TFS Bug: 54790
--Created By: Mike B
--Reviewed By: Mike M on 2/20/2018
--Description: Get the column order of our audit trail DonorData table to match the column order of our transactional DonorData table
--Problem Columns (with correct order): MultipleDonorsFound, LastStatEmployeeID, AuditLogTypeID
--Steps: Disable replication, run script, enable replication
--Target Server/Database: Tested on st-testsqloltp._ReferralAuditTrail, planned for st-prodsql-2._ReferralAuditTrail

--Record counts
--select count(*) from st-testsqloltp._ReferralAuditTrail.dbo.DonorData --699,791
--select count(*) from st-prodsql-2._ReferralAuditTrail.dbo.DonorData --699,798 (data chunking is needed)

--Capture data for rollback purposes
--SELECT * FROM dbo.DonorData;

--Check to make sure problem still exists and this script hasn't already been run in this environment
--In this case, I'm looking for an invalid AuditLogTypeID
IF NOT EXISTS (SELECT 1
				FROM dbo.DonorData dd
				WHERE AuditLogTypeId NOT IN (1,2,3,4,5)) 
				--hard coded to avoid the need to target ReferralTest (which would fail on st-prodsql-2)
BEGIN
	RETURN;
END

--Rename existing DonorData table
IF NOT EXISTS (SELECT 1
				FROM sys.tables
				WHERE name = 'DonorData-old')
BEGIN
	EXEC sp_rename 'dbo.DonorData', 'DonorData-old';
END

--Prepare records that were inserted correctly on 11/2/2011
IF EXISTS (SELECT 1
			FROM dbo.[DonorData-old]
			WHERE LastStatEmployeeID > 1)
BEGIN

	--Make sure temp table doesn't already exist
	IF object_id('tempdb..#DonorDataToPrepare') IS NOT NULL
	BEGIN	
		DROP TABLE #DonorDataToPrepare;
	END

	--Look up records to prepare and store in temp table
	SELECT DonorDataId, LastModified, LastStatEmployeeID, AuditLogTypeID, MultipleDonorsFound
	INTO #DonorDataToPrepare
	FROM dbo.[DonorData-old]
	WHERE LastStatEmployeeID > 1;

	--Update records in DonorData-old
	UPDATE ddo
	SET ddo.AuditLogTypeID = ddtp.LastStatEmployeeID,
		ddo.LastStatEmployeeID = ddtp.MultipleDonorsFound,
		ddo.MultipleDonorsFound = ddtp.AuditLogTypeID
	FROM dbo.[DonorData-old] AS ddo
		INNER JOIN #DonorDataToPrepare AS ddtp ON ddo.DonorDataId = ddtp.DonorDataId AND ddo.LastModified = ddtp.LastModified;

	--Drop temp table
	IF EXISTS(SELECT 1
				FROM sys.tables
				WHERE name = '#DonorDataToPrepare')
	BEGIN
		DROP TABLE #DonorDataToPrepare;
	END

END
GO

--Prepare records that were inserted correctly on 11/2/2011
IF EXISTS (SELECT 1
			FROM dbo.[DonorData-old]
			WHERE LastStatEmployeeID > 1)
BEGIN

	--Make sure temp table doesn't already exist
	IF object_id('tempdb..#DonorDataToPrepare') IS NOT NULL
	BEGIN	
		DROP TABLE #DonorDataToPrepare;
	END

	--Look up records to prepare and store in temp table
	SELECT DonorDataId, LastModified, LastStatEmployeeID, AuditLogTypeID, MultipleDonorsFound
	INTO #DonorDataToPrepare
	FROM dbo.[DonorData-old]
	WHERE LastStatEmployeeID > 1;

	--Update records in DonorData-old
	UPDATE ddo
	SET ddo.AuditLogTypeID = ddtp.LastStatEmployeeID,
		ddo.LastStatEmployeeID = ddtp.MultipleDonorsFound,
		ddo.MultipleDonorsFound = ddtp.AuditLogTypeID
	FROM dbo.[DonorData-old] AS ddo
		INNER JOIN #DonorDataToPrepare AS ddtp ON ddo.DonorDataId = ddtp.DonorDataId AND ddo.LastModified = ddtp.LastModified;

	--Drop temp table
	IF EXISTS(SELECT 1
				FROM sys.tables
				WHERE name = '#DonorDataToPrepare')
	BEGIN
		DROP TABLE #DonorDataToPrepare;
	END

END
	
--We want to chunk our data inserts but our source table doesn't have a unique 
--primary key.  So we'll add a RowNumber column (after we make sure it doesn't 
--already exist).
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[DonorData-old]')
	AND syscolumns.name = 'RowNumber'
	)
BEGIN
	--Add the RowNumber column to DonorData-old
	PRINT 'ALTERING TABLE DonorData-old Adding Column RowNumber'
	ALTER TABLE [dbo].[DonorData-old]
		ADD RowNumber [int] NULL;
END
GO

--Populate DonorData-old.RowNumber with row number data
IF EXISTS (SELECT 1 FROM [dbo].[DonorData-old] WHERE RowNumber IS NULL)
BEGIN
	DECLARE @id INT = 0;
	UPDATE [dbo].[DonorData-old]
	SET RowNumber = @id,
		@id = @id + 1;
END

--Prepare local variables
DECLARE @MessageToShow VARCHAR(100);

--Create new DonorData table
IF NOT EXISTS (SELECT 1
				FROM sys.tables
				WHERE name = 'DonorData')
BEGIN
	CREATE TABLE [dbo].[DonorData](
		[DonorDataId]			[int] NOT NULL,
		[CallID]				[int] NULL,
		[DonorDataMiddleName]	[varchar](20) NULL,
		[DonorDataLicense]		[varchar](9) NULL,
		[DonorDataAddress]		[varchar](40) NULL,
		[DonorDataCity]			[varchar](25) NULL,
		[DonorDataState]		[varchar](2) NULL,
		[DonorDataZip]			[varchar](10) NULL,
		[DonorDataNotAvailable] [bit] NULL,
		[LastModified]			[smalldatetime] NULL,
		[MultipleDonorsFound]	[smallint] NULL,
		[LastStatEmployeeID]	[int] NULL,
		[AuditLogTypeID]		[int] NULL
	) ON [PRIMARY];
END

--Copy data from the old table to the new table (mapping data to the correct columns)	
INSERT INTO [dbo].[DonorData]
			([DonorDataId]
			,[CallID]
			,[DonorDataMiddleName]
			,[DonorDataLicense]
			,[DonorDataAddress]
			,[DonorDataCity]
			,[DonorDataState]
			,[DonorDataZip]
			,[DonorDataNotAvailable]
			,[LastModified]
			,[MultipleDonorsFound]
			,[LastStatEmployeeID]
			,[AuditLogTypeID])
SELECT [DonorDataId]
		,[CallID]
		,[DonorDataMiddleName]
		,[DonorDataLicense]
		,[DonorDataAddress]
		,[DonorDataCity]
		,[DonorDataState]
		,[DonorDataZip]
		,[DonorDataNotAvailable]
		,[LastModified]
		,[LastStatEmployeeID]
		,[AuditLogTypeID]
		,[MultipleDonorsFound]
	FROM [dbo].[DonorData-old] ddo
	ORDER BY [RowNumber] DESC;

--Drop old DonorData table (after we're sure we don't need it)
--IF EXISTS (SELECT 1
--			FROM sys.tables
--			WHERE name = 'DonorData-old')
--BEGIN
--	DROP TABLE [DonorData-old];
--END

--Post-script check
--SELECT MAX(MultipleDonorsFound) MultipleDonorsFound, MAX(LastStatEmployeeID) LastStatEmployeeID, MAX(AuditLogTypeID) AuditLogTypeID FROM dbo.DonorData;
--SELECT MAX(MultipleDonorsFound) MultipleDonorsFound, MAX(LastStatEmployeeID) LastStatEmployeeID, MAX(AuditLogTypeID) AuditLogTypeID FROM dbo.[DonorData-old];

/*

Data in Test
	Saved Into A Separate File

Data in Production



*/