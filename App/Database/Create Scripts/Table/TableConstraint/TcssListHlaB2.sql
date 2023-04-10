/***************************************************************************************************
**	Name: TcssListHlaB2
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaB2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaB2')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaB2'
	ALTER TABLE dbo.TcssListHlaB2 ADD CONSTRAINT PK_TcssListHlaB2 PRIMARY KEY Clustered (TcssListHlaB2Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaB2_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaB2_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaB2 ADD CONSTRAINT DF_TcssListHlaB2_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaB2_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaB2_SortOrder'
	ALTER TABLE dbo.TcssListHlaB2 ADD CONSTRAINT DF_TcssListHlaB2_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaB2_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaB2_IsActive'
	ALTER TABLE dbo.TcssListHlaB2 ADD CONSTRAINT DF_TcssListHlaB2_IsActive DEFAULT(1) FOR IsActive
END
GO
