/***************************************************************************************************
**	Name: TcssListHlaB1
**	Desc: Creates new table TcssListHlaB1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaB1')
BEGIN
	-- DROP TABLE dbo.TcssListHlaB1
	PRINT 'Creating table TcssListHlaB1'
	CREATE TABLE dbo.TcssListHlaB1
	(
		TcssListHlaB1Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaB1 TO PUBLIC
GO
