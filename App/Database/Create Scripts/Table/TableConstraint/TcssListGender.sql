/***************************************************************************************************
**	Name: TcssListGender
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListGender
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListGender')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListGender'
	ALTER TABLE dbo.TcssListGender ADD CONSTRAINT PK_TcssListGender PRIMARY KEY Clustered (TcssListGenderId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListGender_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListGender_LastUpdateDate'
	ALTER TABLE dbo.TcssListGender ADD CONSTRAINT DF_TcssListGender_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListGender_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListGender_SortOrder'
	ALTER TABLE dbo.TcssListGender ADD CONSTRAINT DF_TcssListGender_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListGender_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListGender_IsActive'
	ALTER TABLE dbo.TcssListGender ADD CONSTRAINT DF_TcssListGender_IsActive DEFAULT(1) FOR IsActive
END
GO
