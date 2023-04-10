/***************************************************************************************************
**	Name: TcssListKidneyCystsDiscoloration
**	Desc: Creates new table TcssListKidneyCystsDiscoloration
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyCystsDiscoloration')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyCystsDiscoloration
	PRINT 'Creating table TcssListKidneyCystsDiscoloration'
	CREATE TABLE dbo.TcssListKidneyCystsDiscoloration
	(
		TcssListKidneyCystsDiscolorationId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyCystsDiscoloration TO PUBLIC
GO
