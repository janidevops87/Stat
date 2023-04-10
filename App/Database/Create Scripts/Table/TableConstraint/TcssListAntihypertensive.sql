/***************************************************************************************************
**	Name: TcssListAntihypertensive
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListAntihypertensive
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListAntihypertensive')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListAntihypertensive'
	ALTER TABLE dbo.TcssListAntihypertensive ADD CONSTRAINT PK_TcssListAntihypertensive PRIMARY KEY Clustered (TcssListAntihypertensiveId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListAntihypertensive_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListAntihypertensive_LastUpdateDate'
	ALTER TABLE dbo.TcssListAntihypertensive ADD CONSTRAINT DF_TcssListAntihypertensive_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListAntihypertensive_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListAntihypertensive_SortOrder'
	ALTER TABLE dbo.TcssListAntihypertensive ADD CONSTRAINT DF_TcssListAntihypertensive_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListAntihypertensive_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListAntihypertensive_IsActive'
	ALTER TABLE dbo.TcssListAntihypertensive ADD CONSTRAINT DF_TcssListAntihypertensive_IsActive DEFAULT(1) FOR IsActive
END
GO
