/***************************************************************************************************
**	Name: TcssListCprAdministered
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListCprAdministered
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListCprAdministered')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListCprAdministered'
	ALTER TABLE dbo.TcssListCprAdministered ADD CONSTRAINT PK_TcssListCprAdministered PRIMARY KEY Clustered (TcssListCprAdministeredId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCprAdministered_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCprAdministered_LastUpdateDate'
	ALTER TABLE dbo.TcssListCprAdministered ADD CONSTRAINT DF_TcssListCprAdministered_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCprAdministered_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCprAdministered_SortOrder'
	ALTER TABLE dbo.TcssListCprAdministered ADD CONSTRAINT DF_TcssListCprAdministered_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCprAdministered_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCprAdministered_IsActive'
	ALTER TABLE dbo.TcssListCprAdministered ADD CONSTRAINT DF_TcssListCprAdministered_IsActive DEFAULT(1) FOR IsActive
END
GO
