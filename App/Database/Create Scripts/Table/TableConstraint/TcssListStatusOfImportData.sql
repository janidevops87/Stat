/***************************************************************************************************
**	Name: TcssListStatusOfImportData
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListStatusOfImportData
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListStatusOfImportData')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListStatusOfImportData'
	ALTER TABLE dbo.TcssListStatusOfImportData ADD CONSTRAINT PK_TcssListStatusOfImportData PRIMARY KEY Clustered (TcssListStatusOfImportDataId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListStatusOfImportData_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListStatusOfImportData_LastUpdateDate'
	ALTER TABLE dbo.TcssListStatusOfImportData ADD CONSTRAINT DF_TcssListStatusOfImportData_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListStatusOfImportData_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListStatusOfImportData_SortOrder'
	ALTER TABLE dbo.TcssListStatusOfImportData ADD CONSTRAINT DF_TcssListStatusOfImportData_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListStatusOfImportData_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListStatusOfImportData_IsActive'
	ALTER TABLE dbo.TcssListStatusOfImportData ADD CONSTRAINT DF_TcssListStatusOfImportData_IsActive DEFAULT(1) FOR IsActive
END
GO
