/***************************************************************************************************
**	Name: TcssListKidneyCapsularTear
**	Desc: Creates new table TcssListKidneyCapsularTear
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyCapsularTear')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyCapsularTear
	PRINT 'Creating table TcssListKidneyCapsularTear'
	CREATE TABLE dbo.TcssListKidneyCapsularTear
	(
		TcssListKidneyCapsularTearId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyCapsularTear TO PUBLIC
GO
