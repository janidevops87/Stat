/***************************************************************************************************
**	Name: TcssListStatus
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListStatus')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListStatus'
	ALTER TABLE dbo.TcssListStatus ADD CONSTRAINT PK_TcssListStatus PRIMARY KEY Clustered (TcssListStatusId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListStatus_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListStatus_LastUpdateDate'
	ALTER TABLE dbo.TcssListStatus ADD CONSTRAINT DF_TcssListStatus_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListStatus_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListStatus_SortOrder'
	ALTER TABLE dbo.TcssListStatus ADD CONSTRAINT DF_TcssListStatus_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListStatus_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListStatus_IsActive'
	ALTER TABLE dbo.TcssListStatus ADD CONSTRAINT DF_TcssListStatus_IsActive DEFAULT(1) FOR IsActive
END
GO
