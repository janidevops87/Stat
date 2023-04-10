/***************************************************************************************************
**	Name: TcssListDaylightSavingsObserved
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDaylightSavingsObserved
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDaylightSavingsObserved')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDaylightSavingsObserved'
	ALTER TABLE dbo.TcssListDaylightSavingsObserved ADD CONSTRAINT PK_TcssListDaylightSavingsObserved PRIMARY KEY Clustered (TcssListDaylightSavingsObservedId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDaylightSavingsObserved_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDaylightSavingsObserved_LastUpdateDate'
	ALTER TABLE dbo.TcssListDaylightSavingsObserved ADD CONSTRAINT DF_TcssListDaylightSavingsObserved_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDaylightSavingsObserved_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDaylightSavingsObserved_SortOrder'
	ALTER TABLE dbo.TcssListDaylightSavingsObserved ADD CONSTRAINT DF_TcssListDaylightSavingsObserved_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDaylightSavingsObserved_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDaylightSavingsObserved_IsActive'
	ALTER TABLE dbo.TcssListDaylightSavingsObserved ADD CONSTRAINT DF_TcssListDaylightSavingsObserved_IsActive DEFAULT(1) FOR IsActive
END
GO
