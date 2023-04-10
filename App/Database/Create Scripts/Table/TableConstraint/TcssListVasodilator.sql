/***************************************************************************************************
**	Name: TcssListVasodilator
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListVasodilator
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListVasodilator')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListVasodilator'
	ALTER TABLE dbo.TcssListVasodilator ADD CONSTRAINT PK_TcssListVasodilator PRIMARY KEY Clustered (TcssListVasodilatorId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVasodilator_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVasodilator_LastUpdateDate'
	ALTER TABLE dbo.TcssListVasodilator ADD CONSTRAINT DF_TcssListVasodilator_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVasodilator_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVasodilator_SortOrder'
	ALTER TABLE dbo.TcssListVasodilator ADD CONSTRAINT DF_TcssListVasodilator_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVasodilator_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVasodilator_IsActive'
	ALTER TABLE dbo.TcssListVasodilator ADD CONSTRAINT DF_TcssListVasodilator_IsActive DEFAULT(1) FOR IsActive
END
GO
