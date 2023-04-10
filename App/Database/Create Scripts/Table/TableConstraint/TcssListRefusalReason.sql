/***************************************************************************************************
**	Name: TcssListRefusalReason
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListRefusalReason
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListRefusalReason')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListRefusalReason'
	ALTER TABLE dbo.TcssListRefusalReason ADD CONSTRAINT PK_TcssListRefusalReason PRIMARY KEY Clustered (TcssListRefusalReasonId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListRefusalReason_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListRefusalReason_LastUpdateDate'
	ALTER TABLE dbo.TcssListRefusalReason ADD CONSTRAINT DF_TcssListRefusalReason_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListRefusalReason_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListRefusalReason_SortOrder'
	ALTER TABLE dbo.TcssListRefusalReason ADD CONSTRAINT DF_TcssListRefusalReason_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListRefusalReason_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListRefusalReason_IsActive'
	ALTER TABLE dbo.TcssListRefusalReason ADD CONSTRAINT DF_TcssListRefusalReason_IsActive DEFAULT(1) FOR IsActive
END
GO
