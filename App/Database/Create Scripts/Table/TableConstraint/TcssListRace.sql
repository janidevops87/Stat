/***************************************************************************************************
**	Name: TcssListRace
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListRace
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListRace')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListRace'
	ALTER TABLE dbo.TcssListRace ADD CONSTRAINT PK_TcssListRace PRIMARY KEY Clustered (TcssListRaceId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListRace_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListRace_LastUpdateDate'
	ALTER TABLE dbo.TcssListRace ADD CONSTRAINT DF_TcssListRace_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListRace_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListRace_SortOrder'
	ALTER TABLE dbo.TcssListRace ADD CONSTRAINT DF_TcssListRace_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListRace_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListRace_IsActive'
	ALTER TABLE dbo.TcssListRace ADD CONSTRAINT DF_TcssListRace_IsActive DEFAULT(1) FOR IsActive
END
GO
