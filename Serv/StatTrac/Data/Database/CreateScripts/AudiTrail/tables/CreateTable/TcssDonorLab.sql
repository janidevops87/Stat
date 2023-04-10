/***************************************************************************************************
**	Name: TcssDonorLab
**	Desc: Creates new table TcssDonorLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
**  11/2010     jth             added HbA1c fields per req 8250
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorLab')
BEGIN
	-- DROP TABLE dbo.TcssDonorLab
	PRINT 'Creating table TcssDonorLab'
	CREATE TABLE dbo.TcssDonorLab
	(
		TcssDonorLabId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListToxicologyScreenId int NULL,
		Results varchar(500) NULL,
		OtherLabs varchar(500) NULL
	)
END
GO

-- Add a new column HbA1c
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorLab') AND name = 'HbA1c')
BEGIN
	ALTER TABLE dbo.TcssDonorLab ADD HbA1c decimal(18,1) NULL
END
GO

-- Add a new column HbA1c date
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorLab') AND name = 'HbA1cDateTime')
BEGIN
	ALTER TABLE dbo.TcssDonorLab ADD HbA1cDateTime smalldatetime NULL
END
GO

GRANT SELECT ON TcssDonorLab TO PUBLIC

GO
