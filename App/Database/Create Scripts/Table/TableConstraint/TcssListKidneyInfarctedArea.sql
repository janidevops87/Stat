/***************************************************************************************************
**	Name: TcssListKidneyInfarctedArea
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyInfarctedArea
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyInfarctedArea')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyInfarctedArea'
	ALTER TABLE dbo.TcssListKidneyInfarctedArea ADD CONSTRAINT PK_TcssListKidneyInfarctedArea PRIMARY KEY Clustered (TcssListKidneyInfarctedAreaId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyInfarctedArea_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyInfarctedArea_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyInfarctedArea ADD CONSTRAINT DF_TcssListKidneyInfarctedArea_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyInfarctedArea_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyInfarctedArea_SortOrder'
	ALTER TABLE dbo.TcssListKidneyInfarctedArea ADD CONSTRAINT DF_TcssListKidneyInfarctedArea_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyInfarctedArea_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyInfarctedArea_IsActive'
	ALTER TABLE dbo.TcssListKidneyInfarctedArea ADD CONSTRAINT DF_TcssListKidneyInfarctedArea_IsActive DEFAULT(1) FOR IsActive
END
GO
