/***************************************************************************************************
**	Name: TcssListOtherBloodProduct
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListOtherBloodProduct
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListOtherBloodProduct')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListOtherBloodProduct'
	ALTER TABLE dbo.TcssListOtherBloodProduct ADD CONSTRAINT PK_TcssListOtherBloodProduct PRIMARY KEY Clustered (TcssListOtherBloodProductId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOtherBloodProduct_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOtherBloodProduct_LastUpdateDate'
	ALTER TABLE dbo.TcssListOtherBloodProduct ADD CONSTRAINT DF_TcssListOtherBloodProduct_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOtherBloodProduct_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOtherBloodProduct_SortOrder'
	ALTER TABLE dbo.TcssListOtherBloodProduct ADD CONSTRAINT DF_TcssListOtherBloodProduct_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOtherBloodProduct_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOtherBloodProduct_IsActive'
	ALTER TABLE dbo.TcssListOtherBloodProduct ADD CONSTRAINT DF_TcssListOtherBloodProduct_IsActive DEFAULT(1) FOR IsActive
END
GO
