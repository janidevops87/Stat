/***************************************************************************************************
**	Name: TcssListHlaB1
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaB1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaB1')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaB1'
	ALTER TABLE dbo.TcssListHlaB1 ADD CONSTRAINT PK_TcssListHlaB1 PRIMARY KEY Clustered (TcssListHlaB1Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaB1_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaB1_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaB1 ADD CONSTRAINT DF_TcssListHlaB1_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaB1_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaB1_SortOrder'
	ALTER TABLE dbo.TcssListHlaB1 ADD CONSTRAINT DF_TcssListHlaB1_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaB1_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaB1_IsActive'
	ALTER TABLE dbo.TcssListHlaB1 ADD CONSTRAINT DF_TcssListHlaB1_IsActive DEFAULT(1) FOR IsActive
END
GO
