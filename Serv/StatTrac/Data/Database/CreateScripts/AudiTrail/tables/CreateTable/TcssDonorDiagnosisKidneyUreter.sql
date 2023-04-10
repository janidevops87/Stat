/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyUreter
**	Desc: Creates new table TcssDonorDiagnosisKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisKidneyUreter')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisKidneyUreter
	PRINT 'Creating table TcssDonorDiagnosisKidneyUreter'
	CREATE TABLE dbo.TcssDonorDiagnosisKidneyUreter
	(
		TcssDonorDiagnosisKidneyUreterId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListKidneyId int NULL,
		TcssListKidneyUreterId int NULL,
		Length float NULL,
		TcssListKidneyUreterTissueQualityId int NULL
	)
END
GO

GRANT SELECT ON TcssDonorDiagnosisKidneyUreter TO PUBLIC
GO
