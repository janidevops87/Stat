/***************************************************************************************************
**	Name: TcssDonorVitalSignSummary
**	Desc: Creates new table TcssDonorVitalSignSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorVitalSignSummary')
BEGIN
	-- DROP TABLE dbo.TcssDonorVitalSignSummary
	PRINT 'Creating table TcssDonorVitalSignSummary'
	CREATE TABLE dbo.TcssDonorVitalSignSummary
	(
		TcssDonorVitalSignSummaryId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		Sao2Initial varchar(50) NULL,
		Sao2Peak varchar(50) NULL,
		Sao2Current varchar(50) NULL
	)
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorVitalSignSummary') AND name = 'Sao2InitialFromDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorVitalSignSummary Add Column Sao2InitialFromDate'
	ALTER TABLE dbo.TcssDonorVitalSignSummary ADD Sao2InitialFromDate DateTime NULL
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorVitalSignSummary') AND name = 'Sao2InitialToDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorVitalSignSummary Add Column Sao2InitialToDate'
	ALTER TABLE dbo.TcssDonorVitalSignSummary ADD Sao2InitialToDate DateTime NULL
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorVitalSignSummary') AND name = 'Sao2PeakFromDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorVitalSignSummary Add Column Sao2PeakFromDate'
	ALTER TABLE dbo.TcssDonorVitalSignSummary ADD Sao2PeakFromDate DateTime NULL
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorVitalSignSummary') AND name = 'Sao2PeakToDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorVitalSignSummary Add Column Sao2PeakToDate'
	ALTER TABLE dbo.TcssDonorVitalSignSummary ADD Sao2PeakToDate DateTime NULL
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorVitalSignSummary') AND name = 'Sao2CurrentFromDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorVitalSignSummary Add Column Sao2CurrentFromDate'
	ALTER TABLE dbo.TcssDonorVitalSignSummary ADD Sao2CurrentFromDate DateTime NULL
END

IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssDonorVitalSignSummary') AND name = 'Sao2CurrentToDate')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssDonorVitalSignSummary Add Column Sao2CurrentToDate'
	ALTER TABLE dbo.TcssDonorVitalSignSummary ADD Sao2CurrentToDate DateTime NULL
END
GO

GRANT SELECT ON TcssDonorVitalSignSummary TO PUBLIC
GO
