/***************************************************************************************************
**	Name: TcssListHistoryOfGastrointestinalDisease
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHistoryOfGastrointestinalDisease
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHistoryOfGastrointestinalDisease')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHistoryOfGastrointestinalDisease'
	ALTER TABLE dbo.TcssListHistoryOfGastrointestinalDisease ADD CONSTRAINT PK_TcssListHistoryOfGastrointestinalDisease PRIMARY KEY Clustered (TcssListHistoryOfGastrointestinalDiseaseId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfGastrointestinalDisease_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfGastrointestinalDisease_LastUpdateDate'
	ALTER TABLE dbo.TcssListHistoryOfGastrointestinalDisease ADD CONSTRAINT DF_TcssListHistoryOfGastrointestinalDisease_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfGastrointestinalDisease_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfGastrointestinalDisease_SortOrder'
	ALTER TABLE dbo.TcssListHistoryOfGastrointestinalDisease ADD CONSTRAINT DF_TcssListHistoryOfGastrointestinalDisease_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfGastrointestinalDisease_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfGastrointestinalDisease_IsActive'
	ALTER TABLE dbo.TcssListHistoryOfGastrointestinalDisease ADD CONSTRAINT DF_TcssListHistoryOfGastrointestinalDisease_IsActive DEFAULT(1) FOR IsActive
END
GO
