/***************************************************************************************************
**	Name: TcssListDiagnosisHeartMethod
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDiagnosisHeartMethod
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDiagnosisHeartMethod')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDiagnosisHeartMethod'
	ALTER TABLE dbo.TcssListDiagnosisHeartMethod ADD CONSTRAINT PK_TcssListDiagnosisHeartMethod PRIMARY KEY Clustered (TcssListDiagnosisHeartMethodId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDiagnosisHeartMethod_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDiagnosisHeartMethod_LastUpdateDate'
	ALTER TABLE dbo.TcssListDiagnosisHeartMethod ADD CONSTRAINT DF_TcssListDiagnosisHeartMethod_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDiagnosisHeartMethod_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDiagnosisHeartMethod_SortOrder'
	ALTER TABLE dbo.TcssListDiagnosisHeartMethod ADD CONSTRAINT DF_TcssListDiagnosisHeartMethod_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDiagnosisHeartMethod_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDiagnosisHeartMethod_IsActive'
	ALTER TABLE dbo.TcssListDiagnosisHeartMethod ADD CONSTRAINT DF_TcssListDiagnosisHeartMethod_IsActive DEFAULT(1) FOR IsActive
END
GO
