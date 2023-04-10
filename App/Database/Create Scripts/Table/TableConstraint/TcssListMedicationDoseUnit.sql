/***************************************************************************************************
**	Name: TcssListMedicationDoseUnit
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListMedicationDoseUnit
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListMedicationDoseUnit')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListMedicationDoseUnit'
	ALTER TABLE dbo.TcssListMedicationDoseUnit ADD CONSTRAINT PK_TcssListMedicationDoseUnit PRIMARY KEY Clustered (TcssListMedicationDoseUnitId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListMedicationDoseUnit_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListMedicationDoseUnit_LastUpdateDate'
	ALTER TABLE dbo.TcssListMedicationDoseUnit ADD CONSTRAINT DF_TcssListMedicationDoseUnit_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListMedicationDoseUnit_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListMedicationDoseUnit_SortOrder'
	ALTER TABLE dbo.TcssListMedicationDoseUnit ADD CONSTRAINT DF_TcssListMedicationDoseUnit_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListMedicationDoseUnit_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListMedicationDoseUnit_IsActive'
	ALTER TABLE dbo.TcssListMedicationDoseUnit ADD CONSTRAINT DF_TcssListMedicationDoseUnit_IsActive DEFAULT(1) FOR IsActive
END
GO
