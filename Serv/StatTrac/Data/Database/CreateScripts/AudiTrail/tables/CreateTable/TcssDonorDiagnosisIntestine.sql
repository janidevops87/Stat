/***************************************************************************************************
**	Name: TcssDonorDiagnosisIntestine
**	Desc: Creates new table TcssDonorDiagnosisIntestine
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisIntestine')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisIntestine
	PRINT 'Creating table TcssDonorDiagnosisIntestine'
	CREATE TABLE dbo.TcssDonorDiagnosisIntestine
	(
		TcssDonorDiagnosisIntestineId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		Comment varchar(5000) NULL
	)
END
GO

GRANT SELECT ON TcssDonorDiagnosisIntestine TO PUBLIC
GO
