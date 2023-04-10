/***************************************************************************************************
**	Name: TcssListHlaDq1
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaDq1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaDq1')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaDq1'
	ALTER TABLE dbo.TcssListHlaDq1 ADD CONSTRAINT PK_TcssListHlaDq1 PRIMARY KEY Clustered (TcssListHlaDq1Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDq1_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDq1_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaDq1 ADD CONSTRAINT DF_TcssListHlaDq1_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDq1_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDq1_SortOrder'
	ALTER TABLE dbo.TcssListHlaDq1 ADD CONSTRAINT DF_TcssListHlaDq1_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDq1_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDq1_IsActive'
	ALTER TABLE dbo.TcssListHlaDq1 ADD CONSTRAINT DF_TcssListHlaDq1_IsActive DEFAULT(1) FOR IsActive
END
GO
