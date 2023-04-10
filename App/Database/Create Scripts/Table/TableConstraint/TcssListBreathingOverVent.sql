/***************************************************************************************************
**	Name: TcssListBreathingOverVent
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListBreathingOverVent
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListBreathingOverVent')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListBreathingOverVent'
	ALTER TABLE dbo.TcssListBreathingOverVent ADD CONSTRAINT PK_TcssListBreathingOverVent PRIMARY KEY Clustered (TcssListBreathingOverVentId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListBreathingOverVent_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListBreathingOverVent_LastUpdateDate'
	ALTER TABLE dbo.TcssListBreathingOverVent ADD CONSTRAINT DF_TcssListBreathingOverVent_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListBreathingOverVent_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListBreathingOverVent_SortOrder'
	ALTER TABLE dbo.TcssListBreathingOverVent ADD CONSTRAINT DF_TcssListBreathingOverVent_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListBreathingOverVent_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListBreathingOverVent_IsActive'
	ALTER TABLE dbo.TcssListBreathingOverVent ADD CONSTRAINT DF_TcssListBreathingOverVent_IsActive DEFAULT(1) FOR IsActive
END
GO
