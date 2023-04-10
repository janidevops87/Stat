/***************************************************************************************************
**	Name: TcssListKidneyType
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyType'
	ALTER TABLE dbo.TcssListKidneyType ADD CONSTRAINT PK_TcssListKidneyType PRIMARY KEY Clustered (TcssListKidneyTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyType_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyType_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyType ADD CONSTRAINT DF_TcssListKidneyType_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyType_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyType_SortOrder'
	ALTER TABLE dbo.TcssListKidneyType ADD CONSTRAINT DF_TcssListKidneyType_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyType_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyType_IsActive'
	ALTER TABLE dbo.TcssListKidneyType ADD CONSTRAINT DF_TcssListKidneyType_IsActive DEFAULT(1) FOR IsActive
END
GO
