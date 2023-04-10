/***************************************************************************************************
**	Name: TcssListHlaDq2
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaDq2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaDq2')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaDq2'
	ALTER TABLE dbo.TcssListHlaDq2 ADD CONSTRAINT PK_TcssListHlaDq2 PRIMARY KEY Clustered (TcssListHlaDq2Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDq2_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDq2_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaDq2 ADD CONSTRAINT DF_TcssListHlaDq2_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDq2_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDq2_SortOrder'
	ALTER TABLE dbo.TcssListHlaDq2 ADD CONSTRAINT DF_TcssListHlaDq2_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDq2_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDq2_IsActive'
	ALTER TABLE dbo.TcssListHlaDq2 ADD CONSTRAINT DF_TcssListHlaDq2_IsActive DEFAULT(1) FOR IsActive
END
GO
