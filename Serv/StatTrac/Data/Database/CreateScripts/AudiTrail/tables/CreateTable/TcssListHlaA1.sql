/***************************************************************************************************
**	Name: TcssListHlaA1
**	Desc: Creates new table TcssListHlaA1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaA1')
BEGIN
	-- DROP TABLE dbo.TcssListHlaA1
	PRINT 'Creating table TcssListHlaA1'
	CREATE TABLE dbo.TcssListHlaA1
	(
		TcssListHlaA1Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaA1 TO PUBLIC
GO
