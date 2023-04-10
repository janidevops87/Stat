/***************************************************************************************************
**	Name: TcssListKidneyArtery
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyArtery')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyArtery'
	ALTER TABLE dbo.TcssListKidneyArtery ADD CONSTRAINT PK_TcssListKidneyArtery PRIMARY KEY Clustered (TcssListKidneyArteryId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyArtery_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyArtery_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyArtery ADD CONSTRAINT DF_TcssListKidneyArtery_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyArtery_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyArtery_SortOrder'
	ALTER TABLE dbo.TcssListKidneyArtery ADD CONSTRAINT DF_TcssListKidneyArtery_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyArtery_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyArtery_IsActive'
	ALTER TABLE dbo.TcssListKidneyArtery ADD CONSTRAINT DF_TcssListKidneyArtery_IsActive DEFAULT(1) FOR IsActive
END
GO
