/***************************************************************************************************
**	Name: TcssListHlaBw6
**	Desc: Creates new table TcssListHlaBw6
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaBw6')
BEGIN
	-- DROP TABLE dbo.TcssListHlaBw6
	PRINT 'Creating table TcssListHlaBw6'
	CREATE TABLE dbo.TcssListHlaBw6
	(
		TcssListHlaBw6Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaBw6 TO PUBLIC
GO
