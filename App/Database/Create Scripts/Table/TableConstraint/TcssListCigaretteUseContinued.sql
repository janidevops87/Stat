/***************************************************************************************************
**	Name: TcssListCigaretteUseContinued
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListCigaretteUseContinued
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListCigaretteUseContinued')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListCigaretteUseContinued'
	ALTER TABLE dbo.TcssListCigaretteUseContinued ADD CONSTRAINT PK_TcssListCigaretteUseContinued PRIMARY KEY Clustered (TcssListCigaretteUseContinuedId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCigaretteUseContinued_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCigaretteUseContinued_LastUpdateDate'
	ALTER TABLE dbo.TcssListCigaretteUseContinued ADD CONSTRAINT DF_TcssListCigaretteUseContinued_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCigaretteUseContinued_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCigaretteUseContinued_SortOrder'
	ALTER TABLE dbo.TcssListCigaretteUseContinued ADD CONSTRAINT DF_TcssListCigaretteUseContinued_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCigaretteUseContinued_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCigaretteUseContinued_IsActive'
	ALTER TABLE dbo.TcssListCigaretteUseContinued ADD CONSTRAINT DF_TcssListCigaretteUseContinued_IsActive DEFAULT(1) FOR IsActive
END
GO
