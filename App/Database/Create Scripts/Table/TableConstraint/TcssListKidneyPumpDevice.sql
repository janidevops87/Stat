/***************************************************************************************************
**	Name: TcssListKidneyPumpDevice
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyPumpDevice
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyPumpDevice')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyPumpDevice'
	ALTER TABLE dbo.TcssListKidneyPumpDevice ADD CONSTRAINT PK_TcssListKidneyPumpDevice PRIMARY KEY Clustered (TcssListKidneyPumpDeviceId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyPumpDevice_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyPumpDevice_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyPumpDevice ADD CONSTRAINT DF_TcssListKidneyPumpDevice_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyPumpDevice_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyPumpDevice_SortOrder'
	ALTER TABLE dbo.TcssListKidneyPumpDevice ADD CONSTRAINT DF_TcssListKidneyPumpDevice_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyPumpDevice_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyPumpDevice_IsActive'
	ALTER TABLE dbo.TcssListKidneyPumpDevice ADD CONSTRAINT DF_TcssListKidneyPumpDevice_IsActive DEFAULT(1) FOR IsActive
END
GO
