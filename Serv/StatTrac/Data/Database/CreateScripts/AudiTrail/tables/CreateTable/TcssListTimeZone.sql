/***************************************************************************************************
**	Name: TcssListTimeZone
**	Desc: Creates new table TcssListTimeZone
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListTimeZone')
BEGIN
	-- DROP TABLE dbo.TcssListTimeZone
	PRINT 'Creating table TcssListTimeZone'
	CREATE TABLE dbo.TcssListTimeZone
	(
		TcssListTimeZoneId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListTimeZone TO PUBLIC
GO
