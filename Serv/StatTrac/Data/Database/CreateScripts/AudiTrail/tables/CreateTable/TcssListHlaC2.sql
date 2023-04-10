/***************************************************************************************************
**	Name: TcssListHlaC2
**	Desc: Creates new table TcssListHlaC2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaC2')
BEGIN
	-- DROP TABLE dbo.TcssListHlaC2
	PRINT 'Creating table TcssListHlaC2'
	CREATE TABLE dbo.TcssListHlaC2
	(
		TcssListHlaC2Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaC2 TO PUBLIC
GO
