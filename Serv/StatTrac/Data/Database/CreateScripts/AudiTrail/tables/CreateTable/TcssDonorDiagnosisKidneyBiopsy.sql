/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyBiopsy
**	Desc: Creates new table TcssDonorDiagnosisKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisKidneyBiopsy')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisKidneyBiopsy
	PRINT 'Creating table TcssDonorDiagnosisKidneyBiopsy'
	CREATE TABLE dbo.TcssDonorDiagnosisKidneyBiopsy
	(
		TcssDonorDiagnosisKidneyBiopsyId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListKidneyId int NULL,
		DateTime datetime NULL,
		Flow varchar(50) NULL,
		PressureSystolic varchar(50) NULL,
		PressureDiastolic varchar(50) NULL,
		Resistance varchar(50) NULL
	)
END
GO

GRANT SELECT ON TcssDonorDiagnosisKidneyBiopsy TO PUBLIC
GO
