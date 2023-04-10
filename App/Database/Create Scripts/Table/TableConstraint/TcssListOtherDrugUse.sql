/***************************************************************************************************
**	Name: TcssListOtherDrugUse
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListOtherDrugUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListOtherDrugUse')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListOtherDrugUse'
	ALTER TABLE dbo.TcssListOtherDrugUse ADD CONSTRAINT PK_TcssListOtherDrugUse PRIMARY KEY Clustered (TcssListOtherDrugUseId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOtherDrugUse_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOtherDrugUse_LastUpdateDate'
	ALTER TABLE dbo.TcssListOtherDrugUse ADD CONSTRAINT DF_TcssListOtherDrugUse_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOtherDrugUse_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOtherDrugUse_SortOrder'
	ALTER TABLE dbo.TcssListOtherDrugUse ADD CONSTRAINT DF_TcssListOtherDrugUse_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOtherDrugUse_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOtherDrugUse_IsActive'
	ALTER TABLE dbo.TcssListOtherDrugUse ADD CONSTRAINT DF_TcssListOtherDrugUse_IsActive DEFAULT(1) FOR IsActive
END
GO
