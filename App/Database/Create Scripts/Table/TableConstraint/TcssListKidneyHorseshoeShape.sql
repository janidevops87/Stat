/***************************************************************************************************
**	Name: TcssListKidneyHorseshoeShape
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyHorseshoeShape
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyHorseshoeShape')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyHorseshoeShape'
	ALTER TABLE dbo.TcssListKidneyHorseshoeShape ADD CONSTRAINT PK_TcssListKidneyHorseshoeShape PRIMARY KEY Clustered (TcssListKidneyHorseshoeShapeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyHorseshoeShape_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyHorseshoeShape_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyHorseshoeShape ADD CONSTRAINT DF_TcssListKidneyHorseshoeShape_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyHorseshoeShape_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyHorseshoeShape_SortOrder'
	ALTER TABLE dbo.TcssListKidneyHorseshoeShape ADD CONSTRAINT DF_TcssListKidneyHorseshoeShape_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyHorseshoeShape_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyHorseshoeShape_IsActive'
	ALTER TABLE dbo.TcssListKidneyHorseshoeShape ADD CONSTRAINT DF_TcssListKidneyHorseshoeShape_IsActive DEFAULT(1) FOR IsActive
END
GO
