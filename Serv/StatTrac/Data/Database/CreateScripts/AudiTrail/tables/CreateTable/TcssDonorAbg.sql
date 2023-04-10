/***************************************************************************************************
**	Name: TcssDonorAbg
**	Desc: Creates new table TcssDonorAbg
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorAbg')
BEGIN
	-- DROP TABLE dbo.TcssDonorAbg
	PRINT 'Creating table TcssDonorAbg'
	CREATE TABLE dbo.TcssDonorAbg
	(
		TcssDonorAbgId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		SampleDateTime smalldatetime NULL,
		Ph decimal(18,2) NULL,
		Pco2 decimal(18,2) NULL,
		Po2 decimal(18,2) NULL,
		Hco3 decimal(18,2) NULL,
		O2sat decimal(18,2) NULL,
		TcssListVentSettingModeId int NULL,
		ModeOther varchar(50) NULL,
		Fio2 decimal(18,2) NULL,
		Rate decimal(18,2) NULL,
		Vt decimal(18,2) NULL,
		Peep decimal(18,2) NULL
	)
END
GO

-- Add a new column Pip
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorAbg') AND name = 'Pip')
BEGIN
	ALTER TABLE dbo.TcssDonorAbg ADD Pip decimal(18,2) NULL
END
GO

GRANT SELECT ON TcssDonorAbg TO PUBLIC
GO
