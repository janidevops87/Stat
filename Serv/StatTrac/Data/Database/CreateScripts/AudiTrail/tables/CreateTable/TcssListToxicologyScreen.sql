/***************************************************************************************************
**	Name: TcssListToxicologyScreen
**	Desc: Creates new table TcssListToxicologyScreen
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListToxicologyScreen')
BEGIN
	-- DROP TABLE dbo.TcssListToxicologyScreen
	PRINT 'Creating table TcssListToxicologyScreen'
	CREATE TABLE dbo.TcssListToxicologyScreen
	(
		TcssListToxicologyScreenId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListToxicologyScreen TO PUBLIC
GO
