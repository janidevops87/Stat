/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidney
**	Desc: Creates new table TcssDonorDiagnosisKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
**  6/03/11		jth				added biopsy type varchar(20) NULL
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisKidney')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisKidney
	PRINT 'Creating table TcssDonorDiagnosisKidney'
	CREATE TABLE dbo.TcssDonorDiagnosisKidney
	(
		TcssDonorDiagnosisKidneyId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListKidneyId int NULL,
		TcssListKidneyAorticCuffId int NULL,
		TcssListKidneyFullVenaId int NULL,
		Length float NULL,
		Width float NULL,
		TcssListKidneyAorticPlaqueId int NULL,
		TcssListKidneyArterialPlaqueId int NULL,
		TcssListKidneyInfarctedAreaId int NULL,
		TcssListKidneyCapsularTearId int NULL,
		TcssListKidneySubcapsularId int NULL,
		TcssListKidneyHematomaId int NULL,
		TcssListKidneyFatCleanedId int NULL,
		TcssListKidneyCystsDiscolorationId int NULL,
		TcssListKidneyHorseshoeShapeId int NULL,
		TcssListKidneyRecoveryBiopsyId int NULL,
		GlomeruliObserved varchar(50) NULL,
		GlomeruliSclerosed varchar(50) NULL,
		SclerosedPercent decimal(18,2),
		TcssListKidneyBiopsyId int NULL,
		Comment varchar(5000) NULL,
		TcssListKidneyPumpDeviceId int NULL,
		TcssListKidneyPumpSolutionId int NULL
	)
END
GO

-- Add a new column
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorDiagnosisKidney') AND name = 'TcssListKidneyRecoveryBiopsyId')
BEGIN
	ALTER TABLE dbo.TcssDonorDiagnosisKidney DROP COLUMN TcssListKidneyRecoveryBiopsyId
END
-- Add a new column
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorDiagnosisKidney') AND name = 'BiopsyType')
BEGIN
	PRINT 'ALTER TABLE TcssDonorDiagnosisKidney Add Column BiopsyType'
	ALTER TABLE TcssDonorDiagnosisKidney ADD BiopsyType varchar(20) NULL
END
GO

GRANT SELECT ON TcssDonorDiagnosisKidney TO PUBLIC
GO
