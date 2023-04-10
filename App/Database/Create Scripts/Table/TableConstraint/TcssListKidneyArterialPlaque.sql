/***************************************************************************************************
**	Name: TcssListKidneyArterialPlaque
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyArterialPlaque
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyArterialPlaque')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyArterialPlaque'
	ALTER TABLE dbo.TcssListKidneyArterialPlaque ADD CONSTRAINT PK_TcssListKidneyArterialPlaque PRIMARY KEY Clustered (TcssListKidneyArterialPlaqueId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyArterialPlaque_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyArterialPlaque_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyArterialPlaque ADD CONSTRAINT DF_TcssListKidneyArterialPlaque_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyArterialPlaque_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyArterialPlaque_SortOrder'
	ALTER TABLE dbo.TcssListKidneyArterialPlaque ADD CONSTRAINT DF_TcssListKidneyArterialPlaque_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyArterialPlaque_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyArterialPlaque_IsActive'
	ALTER TABLE dbo.TcssListKidneyArterialPlaque ADD CONSTRAINT DF_TcssListKidneyArterialPlaque_IsActive DEFAULT(1) FOR IsActive
END
GO
