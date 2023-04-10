/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyArtery
**	Desc: Creates new table TcssDonorDiagnosisKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisKidneyArtery')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisKidneyArtery
	PRINT 'Creating table TcssDonorDiagnosisKidneyArtery'
	CREATE TABLE dbo.TcssDonorDiagnosisKidneyArtery
	(
		TcssDonorDiagnosisKidneyArteryId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListKidneyId int NULL,
		TcssListKidneyArteryId int NULL,
		Length float NULL,
		Diameter float NULL,
		Distance float NULL,
		ArteriesOnCommonCuff int NULL
	)
END
GO

GRANT SELECT ON TcssDonorDiagnosisKidneyArtery TO PUBLIC
GO
