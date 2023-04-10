/***************************************************************************************************
**	Name: TcssListAbo
**	Desc: Creates new table TcssListAbo
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListAbo')
BEGIN
	-- DROP TABLE dbo.TcssListAbo
	PRINT 'Creating table TcssListAbo'
	CREATE TABLE dbo.TcssListAbo
	(
		TcssListAboId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListAbo TO PUBLIC
GO
