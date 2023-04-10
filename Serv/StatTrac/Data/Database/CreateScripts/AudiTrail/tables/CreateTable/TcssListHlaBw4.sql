/***************************************************************************************************
**	Name: TcssListHlaBw4
**	Desc: Creates new table TcssListHlaBw4
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaBw4')
BEGIN
	-- DROP TABLE dbo.TcssListHlaBw4
	PRINT 'Creating table TcssListHlaBw4'
	CREATE TABLE dbo.TcssListHlaBw4
	(
		TcssListHlaBw4Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaBw4 TO PUBLIC
GO
