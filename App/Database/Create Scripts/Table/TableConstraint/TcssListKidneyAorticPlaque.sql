/***************************************************************************************************
**	Name: TcssListKidneyAorticPlaque
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyAorticPlaque
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyAorticPlaque')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyAorticPlaque'
	ALTER TABLE dbo.TcssListKidneyAorticPlaque ADD CONSTRAINT PK_TcssListKidneyAorticPlaque PRIMARY KEY Clustered (TcssListKidneyAorticPlaqueId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyAorticPlaque_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyAorticPlaque_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyAorticPlaque ADD CONSTRAINT DF_TcssListKidneyAorticPlaque_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyAorticPlaque_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyAorticPlaque_SortOrder'
	ALTER TABLE dbo.TcssListKidneyAorticPlaque ADD CONSTRAINT DF_TcssListKidneyAorticPlaque_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyAorticPlaque_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyAorticPlaque_IsActive'
	ALTER TABLE dbo.TcssListKidneyAorticPlaque ADD CONSTRAINT DF_TcssListKidneyAorticPlaque_IsActive DEFAULT(1) FOR IsActive
END
GO
