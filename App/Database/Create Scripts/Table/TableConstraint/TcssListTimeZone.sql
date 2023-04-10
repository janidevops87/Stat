/***************************************************************************************************
**	Name: TcssListTimeZone
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListTimeZone
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListTimeZone')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListTimeZone'
	ALTER TABLE dbo.TcssListTimeZone ADD CONSTRAINT PK_TcssListTimeZone PRIMARY KEY Clustered (TcssListTimeZoneId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListTimeZone_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListTimeZone_LastUpdateDate'
	ALTER TABLE dbo.TcssListTimeZone ADD CONSTRAINT DF_TcssListTimeZone_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListTimeZone_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListTimeZone_SortOrder'
	ALTER TABLE dbo.TcssListTimeZone ADD CONSTRAINT DF_TcssListTimeZone_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListTimeZone_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListTimeZone_IsActive'
	ALTER TABLE dbo.TcssListTimeZone ADD CONSTRAINT DF_TcssListTimeZone_IsActive DEFAULT(1) FOR IsActive
END
GO
