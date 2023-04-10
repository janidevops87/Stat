/***************************************************************************************************
**	Name: TcssListHlaDr52
**	Desc: Creates new table TcssListHlaDr52
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaDr52')
BEGIN
	-- DROP TABLE dbo.TcssListHlaDr52
	PRINT 'Creating table TcssListHlaDr52'
	CREATE TABLE dbo.TcssListHlaDr52
	(
		TcssListHlaDr52Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaDr52 TO PUBLIC
GO
