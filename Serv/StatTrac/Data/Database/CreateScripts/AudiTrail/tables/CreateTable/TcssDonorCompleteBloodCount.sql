/***************************************************************************************************
**	Name: TcssDonorCompleteBloodCount
**	Desc: Creates new table TcssDonorCompleteBloodCount
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorCompleteBloodCount')
BEGIN
	-- DROP TABLE dbo.TcssDonorCompleteBloodCount
	PRINT 'Creating table TcssDonorCompleteBloodCount'
	CREATE TABLE dbo.TcssDonorCompleteBloodCount
	(
		TcssDonorCompleteBloodCountId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		SampleDateTime smalldatetime NULL,
		Wbc varchar(50) NULL,
		Rbc varchar(50) NULL,
		Hgb varchar(50) NULL,
		Hct varchar(50) NULL,
		Plt varchar(50) NULL,
		Bands decimal(18,2) NULL
	)
END
GO

GRANT SELECT ON TcssDonorCompleteBloodCount TO PUBLIC
GO
