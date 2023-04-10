/***************************************************************************************************
**	Name: TcssListCauseOfDeath
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListCauseOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListCauseOfDeath')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListCauseOfDeath'
	ALTER TABLE dbo.TcssListCauseOfDeath ADD CONSTRAINT PK_TcssListCauseOfDeath PRIMARY KEY Clustered (TcssListCauseOfDeathId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCauseOfDeath_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCauseOfDeath_LastUpdateDate'
	ALTER TABLE dbo.TcssListCauseOfDeath ADD CONSTRAINT DF_TcssListCauseOfDeath_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCauseOfDeath_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCauseOfDeath_SortOrder'
	ALTER TABLE dbo.TcssListCauseOfDeath ADD CONSTRAINT DF_TcssListCauseOfDeath_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCauseOfDeath_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCauseOfDeath_IsActive'
	ALTER TABLE dbo.TcssListCauseOfDeath ADD CONSTRAINT DF_TcssListCauseOfDeath_IsActive DEFAULT(1) FOR IsActive
END
GO
