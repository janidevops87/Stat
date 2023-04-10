/***************************************************************************************************
**	Name: TcssListKidneyPumpSolution
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyPumpSolution
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyPumpSolution')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyPumpSolution'
	ALTER TABLE dbo.TcssListKidneyPumpSolution ADD CONSTRAINT PK_TcssListKidneyPumpSolution PRIMARY KEY Clustered (TcssListKidneyPumpSolutionId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyPumpSolution_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyPumpSolution_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyPumpSolution ADD CONSTRAINT DF_TcssListKidneyPumpSolution_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyPumpSolution_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyPumpSolution_SortOrder'
	ALTER TABLE dbo.TcssListKidneyPumpSolution ADD CONSTRAINT DF_TcssListKidneyPumpSolution_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyPumpSolution_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyPumpSolution_IsActive'
	ALTER TABLE dbo.TcssListKidneyPumpSolution ADD CONSTRAINT DF_TcssListKidneyPumpSolution_IsActive DEFAULT(1) FOR IsActive
END
GO
