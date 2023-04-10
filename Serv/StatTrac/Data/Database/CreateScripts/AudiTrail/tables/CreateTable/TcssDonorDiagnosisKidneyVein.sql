/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyVein
**	Desc: Creates new table TcssDonorDiagnosisKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisKidneyVein')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisKidneyVein
	PRINT 'Creating table TcssDonorDiagnosisKidneyVein'
	CREATE TABLE dbo.TcssDonorDiagnosisKidneyVein
	(
		TcssDonorDiagnosisKidneyVeinId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListKidneyId int NULL,
		TcssListKidneyVeinId int NULL,
		Length float NULL,
		Diameter float NULL,
		Distance float NULL,
		VeinsOnVenaCava int NULL
	)
END
GO

GRANT SELECT ON TcssDonorDiagnosisKidneyVein TO PUBLIC
GO
