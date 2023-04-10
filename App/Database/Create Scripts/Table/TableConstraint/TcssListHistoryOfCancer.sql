/***************************************************************************************************
**	Name: TcssListHistoryOfCancer
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHistoryOfCancer
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHistoryOfCancer')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHistoryOfCancer'
	ALTER TABLE dbo.TcssListHistoryOfCancer ADD CONSTRAINT PK_TcssListHistoryOfCancer PRIMARY KEY Clustered (TcssListHistoryOfCancerId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfCancer_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfCancer_LastUpdateDate'
	ALTER TABLE dbo.TcssListHistoryOfCancer ADD CONSTRAINT DF_TcssListHistoryOfCancer_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfCancer_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfCancer_SortOrder'
	ALTER TABLE dbo.TcssListHistoryOfCancer ADD CONSTRAINT DF_TcssListHistoryOfCancer_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHistoryOfCancer_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHistoryOfCancer_IsActive'
	ALTER TABLE dbo.TcssListHistoryOfCancer ADD CONSTRAINT DF_TcssListHistoryOfCancer_IsActive DEFAULT(1) FOR IsActive
END
GO
