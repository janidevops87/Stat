/***************************************************************************************************
**	Name: TcssListCompliantWithTreatment
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListCompliantWithTreatment
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListCompliantWithTreatment')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListCompliantWithTreatment'
	ALTER TABLE dbo.TcssListCompliantWithTreatment ADD CONSTRAINT PK_TcssListCompliantWithTreatment PRIMARY KEY Clustered (TcssListCompliantWithTreatmentId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCompliantWithTreatment_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCompliantWithTreatment_LastUpdateDate'
	ALTER TABLE dbo.TcssListCompliantWithTreatment ADD CONSTRAINT DF_TcssListCompliantWithTreatment_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCompliantWithTreatment_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCompliantWithTreatment_SortOrder'
	ALTER TABLE dbo.TcssListCompliantWithTreatment ADD CONSTRAINT DF_TcssListCompliantWithTreatment_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCompliantWithTreatment_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCompliantWithTreatment_IsActive'
	ALTER TABLE dbo.TcssListCompliantWithTreatment ADD CONSTRAINT DF_TcssListCompliantWithTreatment_IsActive DEFAULT(1) FOR IsActive
END
GO
