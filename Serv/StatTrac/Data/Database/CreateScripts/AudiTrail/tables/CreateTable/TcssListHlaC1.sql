/***************************************************************************************************
**	Name: TcssListHlaC1
**	Desc: Creates new table TcssListHlaC1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaC1')
BEGIN
	-- DROP TABLE dbo.TcssListHlaC1
	PRINT 'Creating table TcssListHlaC1'
	CREATE TABLE dbo.TcssListHlaC1
	(
		TcssListHlaC1Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaC1 TO PUBLIC
GO
