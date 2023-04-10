/***************************************************************************************************
**	Name: TcssListKidneyUreter
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyUreter')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyUreter'
	ALTER TABLE dbo.TcssListKidneyUreter ADD CONSTRAINT PK_TcssListKidneyUreter PRIMARY KEY Clustered (TcssListKidneyUreterId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyUreter_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyUreter_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyUreter ADD CONSTRAINT DF_TcssListKidneyUreter_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyUreter_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyUreter_SortOrder'
	ALTER TABLE dbo.TcssListKidneyUreter ADD CONSTRAINT DF_TcssListKidneyUreter_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyUreter_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyUreter_IsActive'
	ALTER TABLE dbo.TcssListKidneyUreter ADD CONSTRAINT DF_TcssListKidneyUreter_IsActive DEFAULT(1) FOR IsActive
END
GO
