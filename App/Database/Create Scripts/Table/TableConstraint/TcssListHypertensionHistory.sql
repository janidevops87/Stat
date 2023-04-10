/***************************************************************************************************
**	Name: TcssListHypertensionHistory
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHypertensionHistory
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHypertensionHistory')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHypertensionHistory'
	ALTER TABLE dbo.TcssListHypertensionHistory ADD CONSTRAINT PK_TcssListHypertensionHistory PRIMARY KEY Clustered (TcssListHypertensionHistoryId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHypertensionHistory_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHypertensionHistory_LastUpdateDate'
	ALTER TABLE dbo.TcssListHypertensionHistory ADD CONSTRAINT DF_TcssListHypertensionHistory_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHypertensionHistory_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHypertensionHistory_SortOrder'
	ALTER TABLE dbo.TcssListHypertensionHistory ADD CONSTRAINT DF_TcssListHypertensionHistory_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHypertensionHistory_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHypertensionHistory_IsActive'
	ALTER TABLE dbo.TcssListHypertensionHistory ADD CONSTRAINT DF_TcssListHypertensionHistory_IsActive DEFAULT(1) FOR IsActive
END
GO
