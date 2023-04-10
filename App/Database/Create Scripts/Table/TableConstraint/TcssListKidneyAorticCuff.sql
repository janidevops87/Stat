/***************************************************************************************************
**	Name: TcssListKidneyAorticCuff
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyAorticCuff
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyAorticCuff')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyAorticCuff'
	ALTER TABLE dbo.TcssListKidneyAorticCuff ADD CONSTRAINT PK_TcssListKidneyAorticCuff PRIMARY KEY Clustered (TcssListKidneyAorticCuffId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyAorticCuff_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyAorticCuff_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyAorticCuff ADD CONSTRAINT DF_TcssListKidneyAorticCuff_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyAorticCuff_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyAorticCuff_SortOrder'
	ALTER TABLE dbo.TcssListKidneyAorticCuff ADD CONSTRAINT DF_TcssListKidneyAorticCuff_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyAorticCuff_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyAorticCuff_IsActive'
	ALTER TABLE dbo.TcssListKidneyAorticCuff ADD CONSTRAINT DF_TcssListKidneyAorticCuff_IsActive DEFAULT(1) FOR IsActive
END
GO
