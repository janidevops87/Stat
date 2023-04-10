/***************************************************************************************************
**	Name: TcssDonorDiagnosisLiver
**	Desc: Creates new table TcssDonorDiagnosisLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisLiver')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisLiver
	PRINT 'Creating table TcssDonorDiagnosisLiver'
	CREATE TABLE dbo.TcssDonorDiagnosisLiver
	(
		TcssDonorDiagnosisLiverId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListLiverBiopsyId int NULL,
		Comment varchar(5000) NULL
	)
END
GO

GRANT SELECT ON TcssDonorDiagnosisLiver TO PUBLIC
GO
