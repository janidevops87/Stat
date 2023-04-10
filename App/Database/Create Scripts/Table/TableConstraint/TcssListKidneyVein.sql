/***************************************************************************************************
**	Name: TcssListKidneyVein
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyVein')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyVein'
	ALTER TABLE dbo.TcssListKidneyVein ADD CONSTRAINT PK_TcssListKidneyVein PRIMARY KEY Clustered (TcssListKidneyVeinId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyVein_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyVein_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyVein ADD CONSTRAINT DF_TcssListKidneyVein_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyVein_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyVein_SortOrder'
	ALTER TABLE dbo.TcssListKidneyVein ADD CONSTRAINT DF_TcssListKidneyVein_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyVein_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyVein_IsActive'
	ALTER TABLE dbo.TcssListKidneyVein ADD CONSTRAINT DF_TcssListKidneyVein_IsActive DEFAULT(1) FOR IsActive
END
GO
