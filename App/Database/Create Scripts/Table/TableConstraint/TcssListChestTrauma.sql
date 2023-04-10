/***************************************************************************************************
**	Name: TcssListChestTrauma
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListChestTrauma
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListChestTrauma')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListChestTrauma'
	ALTER TABLE dbo.TcssListChestTrauma ADD CONSTRAINT PK_TcssListChestTrauma PRIMARY KEY Clustered (TcssListChestTraumaId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListChestTrauma_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListChestTrauma_LastUpdateDate'
	ALTER TABLE dbo.TcssListChestTrauma ADD CONSTRAINT DF_TcssListChestTrauma_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListChestTrauma_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListChestTrauma_SortOrder'
	ALTER TABLE dbo.TcssListChestTrauma ADD CONSTRAINT DF_TcssListChestTrauma_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListChestTrauma_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListChestTrauma_IsActive'
	ALTER TABLE dbo.TcssListChestTrauma ADD CONSTRAINT DF_TcssListChestTrauma_IsActive DEFAULT(1) FOR IsActive
END
GO
