/***************************************************************************************************
**	Name: TcssListHistoryOfCoronaryArteryDisease
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHistoryOfCoronaryArteryDisease
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHistoryOfCoronaryArteryDisease')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHistoryOfCoronaryArteryDisease'
	ALTER TABLE dbo.TcssListHistoryOfCoronaryArteryDisease ADD CONSTRAINT PK_TcssListHistoryOfCoronaryArteryDisease PRIMARY KEY Clustered (TcssListHistoryOfCoronaryArteryDiseaseId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfCoronaryArteryDisease_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfCoronaryArteryDisease_LastUpdateDate'
	ALTER TABLE dbo.TcssListHistoryOfCoronaryArteryDisease ADD CONSTRAINT DF_TcssListHistoryOfCoronaryArteryDisease_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfCoronaryArteryDisease_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfCoronaryArteryDisease_SortOrder'
	ALTER TABLE dbo.TcssListHistoryOfCoronaryArteryDisease ADD CONSTRAINT DF_TcssListHistoryOfCoronaryArteryDisease_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfCoronaryArteryDisease_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfCoronaryArteryDisease_IsActive'
	ALTER TABLE dbo.TcssListHistoryOfCoronaryArteryDisease ADD CONSTRAINT DF_TcssListHistoryOfCoronaryArteryDisease_IsActive DEFAULT(1) FOR IsActive
END
GO
