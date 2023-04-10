/***************************************************************************************************
**	Name: TcssListHlaA2
**	Desc: Creates new table TcssListHlaA2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaA2')
BEGIN
	-- DROP TABLE dbo.TcssListHlaA2
	PRINT 'Creating table TcssListHlaA2'
	CREATE TABLE dbo.TcssListHlaA2
	(
		TcssListHlaA2Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaA2 TO PUBLIC
GO
