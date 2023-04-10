/***************************************************************************************************
**	Name: TcssDonorDiagnosisHeart
**	Desc: Creates new table TcssDonorDiagnosisHeart
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisHeart')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisHeart
	PRINT 'Creating table TcssDonorDiagnosisHeart'
	CREATE TABLE dbo.TcssDonorDiagnosisHeart
	(
		TcssDonorDiagnosisHeartId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		LvEjectionFraction decimal(18,2) NULL,
		TcssListDiagnosisHeartMethodId int NULL,
		ShorteningFraction decimal(18,2) NULL,
		SeptalWallThickness int NULL,
		LvPosteriorWallThickness int NULL,
		Comment varchar(5000) NULL
	)
END
GO

GRANT SELECT ON TcssDonorDiagnosisHeart TO PUBLIC
GO
