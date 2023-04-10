/***************************************************************************************************
**	Name: TcssListOtherOrgan
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListOtherOrgan
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListOtherOrgan')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListOtherOrgan'
	ALTER TABLE dbo.TcssListOtherOrgan ADD CONSTRAINT PK_TcssListOtherOrgan PRIMARY KEY Clustered (TcssListOtherOrganId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOtherOrgan_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOtherOrgan_LastUpdateDate'
	ALTER TABLE dbo.TcssListOtherOrgan ADD CONSTRAINT DF_TcssListOtherOrgan_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOtherOrgan_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOtherOrgan_SortOrder'
	ALTER TABLE dbo.TcssListOtherOrgan ADD CONSTRAINT DF_TcssListOtherOrgan_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOtherOrgan_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOtherOrgan_IsActive'
	ALTER TABLE dbo.TcssListOtherOrgan ADD CONSTRAINT DF_TcssListOtherOrgan_IsActive DEFAULT(1) FOR IsActive
END
GO
