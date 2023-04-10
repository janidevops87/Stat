/***************************************************************************************************
**	Name: TcssListVentSettingMode
**	Desc: Creates new table TcssListVentSettingMode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListVentSettingMode')
BEGIN
	-- DROP TABLE dbo.TcssListVentSettingMode
	PRINT 'Creating table TcssListVentSettingMode'
	CREATE TABLE dbo.TcssListVentSettingMode
	(
		TcssListVentSettingModeId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListVentSettingMode TO PUBLIC
GO
