/***************************************************************************************************
**	Name: TcssListHlaDr2
**	Desc: Creates new table TcssListHlaDr2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaDr2')
BEGIN
	-- DROP TABLE dbo.TcssListHlaDr2
	PRINT 'Creating table TcssListHlaDr2'
	CREATE TABLE dbo.TcssListHlaDr2
	(
		TcssListHlaDr2Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaDr2 TO PUBLIC
GO
