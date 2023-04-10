/***************************************************************************************************
**	Name: TcssDonorLabProfileSummary
**	Desc: Creates new table TcssDonorLabProfileSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorLabProfileSummary')
BEGIN
	-- DROP TABLE dbo.TcssDonorLabProfileSummary
	PRINT 'Creating table TcssDonorLabProfileSummary'
	CREATE TABLE dbo.TcssDonorLabProfileSummary
	(
		TcssDonorLabProfileSummaryId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		AlcHbalcInitial varchar(50) NULL,
		AlcHbalcPeak varchar(50) NULL,
		AlcHbalcCurrent varchar(50) NULL
	)
END
GO

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorLabProfileSummary') AND name = 'AlcHbalcInitialFromDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorLabProfileSummary Add Column AlcHbalcInitialFromDate'
	ALTER TABLE dbo.TcssDonorLabProfileSummary ADD AlcHbalcInitialFromDate DateTime NULL
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorLabProfileSummary') AND name = 'AlcHbalcInitialToDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorLabProfileSummary Add Column AlcHbalcInitialToDate'
	ALTER TABLE dbo.TcssDonorLabProfileSummary ADD AlcHbalcInitialToDate DateTime NULL
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorLabProfileSummary') AND name = 'AlcHbalcPeakFromDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorLabProfileSummary Add Column AlcHbalcPeakFromDate'
	ALTER TABLE dbo.TcssDonorLabProfileSummary ADD AlcHbalcPeakFromDate DateTime NULL
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorLabProfileSummary') AND name = 'AlcHbalcPeakToDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorLabProfileSummary Add Column AlcHbalcPeakToDate'
	ALTER TABLE dbo.TcssDonorLabProfileSummary ADD AlcHbalcPeakToDate DateTime NULL
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorLabProfileSummary') AND name = 'AlcHbalcCurrentFromDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorLabProfileSummary Add Column AlcHbalcCurrentFromDate'
	ALTER TABLE dbo.TcssDonorLabProfileSummary ADD AlcHbalcCurrentFromDate DateTime NULL
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorLabProfileSummary') AND name = 'AlcHbalcCurrentToDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorLabProfileSummary Add Column AlcHbalcCurrentToDate'
	ALTER TABLE dbo.TcssDonorLabProfileSummary ADD AlcHbalcCurrentToDate DateTime NULL
END

GRANT SELECT ON TcssDonorLabProfileSummary TO PUBLIC
GO
 