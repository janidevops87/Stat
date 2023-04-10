/***************************************************************************************************
**	Name: TcssDonorMedication
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorMedication')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorMedication'
	ALTER TABLE dbo.TcssDonorMedication ADD CONSTRAINT PK_TcssDonorMedication PRIMARY KEY Clustered (TcssDonorMedicationId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorMedication_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorMedication_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorMedication ADD CONSTRAINT DF_TcssDonorMedication_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorMedication_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorMedication_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorMedication_TcssDonorId ON dbo.TcssDonorMedication (TcssDonorId) ON IDX
END
GO
