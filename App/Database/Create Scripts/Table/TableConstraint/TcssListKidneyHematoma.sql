/***************************************************************************************************
**	Name: TcssListKidneyHematoma
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyHematoma
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyHematoma')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyHematoma'
	ALTER TABLE dbo.TcssListKidneyHematoma ADD CONSTRAINT PK_TcssListKidneyHematoma PRIMARY KEY Clustered (TcssListKidneyHematomaId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyHematoma_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyHematoma_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyHematoma ADD CONSTRAINT DF_TcssListKidneyHematoma_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyHematoma_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyHematoma_SortOrder'
	ALTER TABLE dbo.TcssListKidneyHematoma ADD CONSTRAINT DF_TcssListKidneyHematoma_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyHematoma_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyHematoma_IsActive'
	ALTER TABLE dbo.TcssListKidneyHematoma ADD CONSTRAINT DF_TcssListKidneyHematoma_IsActive DEFAULT(1) FOR IsActive
END
GO
