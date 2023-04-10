/***************************************************************************************************
**	Name: TcssListHistoryOfDiabetes
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHistoryOfDiabetes
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHistoryOfDiabetes')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHistoryOfDiabetes'
	ALTER TABLE dbo.TcssListHistoryOfDiabetes ADD CONSTRAINT PK_TcssListHistoryOfDiabetes PRIMARY KEY Clustered (TcssListHistoryOfDiabetesId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfDiabetes_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfDiabetes_LastUpdateDate'
	ALTER TABLE dbo.TcssListHistoryOfDiabetes ADD CONSTRAINT DF_TcssListHistoryOfDiabetes_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfDiabetes_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfDiabetes_SortOrder'
	ALTER TABLE dbo.TcssListHistoryOfDiabetes ADD CONSTRAINT DF_TcssListHistoryOfDiabetes_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfDiabetes_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfDiabetes_IsActive'
	ALTER TABLE dbo.TcssListHistoryOfDiabetes ADD CONSTRAINT DF_TcssListHistoryOfDiabetes_IsActive DEFAULT(1) FOR IsActive
END
GO
