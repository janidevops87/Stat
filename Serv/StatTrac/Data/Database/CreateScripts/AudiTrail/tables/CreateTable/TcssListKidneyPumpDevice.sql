/***************************************************************************************************
**	Name: TcssListKidneyPumpDevice
**	Desc: Creates new table TcssListKidneyPumpDevice
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyPumpDevice')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyPumpDevice
	PRINT 'Creating table TcssListKidneyPumpDevice'
	CREATE TABLE dbo.TcssListKidneyPumpDevice
	(
		TcssListKidneyPumpDeviceId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyPumpDevice TO PUBLIC
GO
