/***************************************************************************************************
**	Name: TcssDonorDiagnosisOther
**	Desc: Creates new table TcssDonorDiagnosisOther
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisOther')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisOther
	PRINT 'Creating table TcssDonorDiagnosisOther'
	CREATE TABLE dbo.TcssDonorDiagnosisOther
	(
		TcssDonorDiagnosisOtherId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListOtherOrganId int NULL,
		Comment varchar(5000) NULL
	)
END
GO

GRANT SELECT ON TcssDonorDiagnosisOther TO PUBLIC
GO
