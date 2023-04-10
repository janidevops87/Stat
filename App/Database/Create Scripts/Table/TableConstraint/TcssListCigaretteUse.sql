/***************************************************************************************************
**	Name: TcssListCigaretteUse
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListCigaretteUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListCigaretteUse')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListCigaretteUse'
	ALTER TABLE dbo.TcssListCigaretteUse ADD CONSTRAINT PK_TcssListCigaretteUse PRIMARY KEY Clustered (TcssListCigaretteUseId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCigaretteUse_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCigaretteUse_LastUpdateDate'
	ALTER TABLE dbo.TcssListCigaretteUse ADD CONSTRAINT DF_TcssListCigaretteUse_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCigaretteUse_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCigaretteUse_SortOrder'
	ALTER TABLE dbo.TcssListCigaretteUse ADD CONSTRAINT DF_TcssListCigaretteUse_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCigaretteUse_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCigaretteUse_IsActive'
	ALTER TABLE dbo.TcssListCigaretteUse ADD CONSTRAINT DF_TcssListCigaretteUse_IsActive DEFAULT(1) FOR IsActive
END
GO
