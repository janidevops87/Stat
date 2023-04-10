/***************************************************************************************************
**	Name: TcssDonorDiagnosisLung
**	Desc: Creates new table TcssDonorDiagnosisLung
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisLung')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisLung
	PRINT 'Creating table TcssDonorDiagnosisLung'
	CREATE TABLE dbo.TcssDonorDiagnosisLung
	(
		TcssDonorDiagnosisLungId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		DateIntubated datetime NULL,
		LengthOfRightLung decimal(18,2),
		LengthOfLeftLung decimal(18,2),
		AorticKnobWidth decimal(18,2),
		DiaphragmWidth decimal(18,2),
		DistanceRcpaToLcpa decimal(18,2),
		ChestCircLandmark decimal(18,2),
		TcssListDiagnosisLungChestXrayId int NULL,
		LeftLungComments varchar(500) NULL,
		RightLungComments varchar(5000) NULL
	)
END
GO

-- Add the column DonorPredictedTotalLungCapacity
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisLung')
						AND name = 'DonorPredictedTotalLungCapacity')
BEGIN
	ALTER TABLE dbo.TcssDonorDiagnosisLung ADD DonorPredictedTotalLungCapacity decimal(18,2) NULL
END
GO

GRANT SELECT ON TcssDonorDiagnosisLung TO PUBLIC
GO
