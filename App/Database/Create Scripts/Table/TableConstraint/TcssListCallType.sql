/***************************************************************************************************
**	Name: TcssListCallType
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListCallType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListCallType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListCallType'
	ALTER TABLE dbo.TcssListCallType ADD CONSTRAINT PK_TcssListCallType PRIMARY KEY Clustered (TcssListCallTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCallType_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCallType_LastUpdateDate'
	ALTER TABLE dbo.TcssListCallType ADD CONSTRAINT DF_TcssListCallType_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCallType_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCallType_SortOrder'
	ALTER TABLE dbo.TcssListCallType ADD CONSTRAINT DF_TcssListCallType_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCallType_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCallType_IsActive'
	ALTER TABLE dbo.TcssListCallType ADD CONSTRAINT DF_TcssListCallType_IsActive DEFAULT(1) FOR IsActive
END
GO
