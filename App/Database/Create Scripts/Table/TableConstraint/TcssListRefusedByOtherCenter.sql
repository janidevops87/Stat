/***************************************************************************************************
**	Name: TcssListRefusedByOtherCenter
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListRefusedByOtherCenter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListRefusedByOtherCenter')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListRefusedByOtherCenter'
	ALTER TABLE dbo.TcssListRefusedByOtherCenter ADD CONSTRAINT PK_TcssListRefusedByOtherCenter PRIMARY KEY Clustered (TcssListRefusedByOtherCenterId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListRefusedByOtherCenter_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListRefusedByOtherCenter_LastUpdateDate'
	ALTER TABLE dbo.TcssListRefusedByOtherCenter ADD CONSTRAINT DF_TcssListRefusedByOtherCenter_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListRefusedByOtherCenter_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListRefusedByOtherCenter_SortOrder'
	ALTER TABLE dbo.TcssListRefusedByOtherCenter ADD CONSTRAINT DF_TcssListRefusedByOtherCenter_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListRefusedByOtherCenter_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListRefusedByOtherCenter_IsActive'
	ALTER TABLE dbo.TcssListRefusedByOtherCenter ADD CONSTRAINT DF_TcssListRefusedByOtherCenter_IsActive DEFAULT(1) FOR IsActive
END
GO
