/***************************************************************************************************
**	Name: TcssListDiagnosisLungChestXray
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDiagnosisLungChestXray
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDiagnosisLungChestXray')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDiagnosisLungChestXray'
	ALTER TABLE dbo.TcssListDiagnosisLungChestXray ADD CONSTRAINT PK_TcssListDiagnosisLungChestXray PRIMARY KEY Clustered (TcssListDiagnosisLungChestXrayId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDiagnosisLungChestXray_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDiagnosisLungChestXray_LastUpdateDate'
	ALTER TABLE dbo.TcssListDiagnosisLungChestXray ADD CONSTRAINT DF_TcssListDiagnosisLungChestXray_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDiagnosisLungChestXray_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDiagnosisLungChestXray_SortOrder'
	ALTER TABLE dbo.TcssListDiagnosisLungChestXray ADD CONSTRAINT DF_TcssListDiagnosisLungChestXray_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDiagnosisLungChestXray_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDiagnosisLungChestXray_IsActive'
	ALTER TABLE dbo.TcssListDiagnosisLungChestXray ADD CONSTRAINT DF_TcssListDiagnosisLungChestXray_IsActive DEFAULT(1) FOR IsActive
END
GO
