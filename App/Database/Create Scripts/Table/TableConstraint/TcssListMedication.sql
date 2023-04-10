/***************************************************************************************************
**	Name: TcssListMedication
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListMedication')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListMedication'
	ALTER TABLE dbo.TcssListMedication ADD CONSTRAINT PK_TcssListMedication PRIMARY KEY Clustered (TcssListMedicationId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListMedication_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListMedication_LastUpdateDate'
	ALTER TABLE dbo.TcssListMedication ADD CONSTRAINT DF_TcssListMedication_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListMedication_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListMedication_SortOrder'
	ALTER TABLE dbo.TcssListMedication ADD CONSTRAINT DF_TcssListMedication_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListMedication_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListMedication_IsActive'
	ALTER TABLE dbo.TcssListMedication ADD CONSTRAINT DF_TcssListMedication_IsActive DEFAULT(1) FOR IsActive
END
GO
