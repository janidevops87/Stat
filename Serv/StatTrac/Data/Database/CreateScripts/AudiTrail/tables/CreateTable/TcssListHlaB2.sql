/***************************************************************************************************
**	Name: TcssListHlaB2
**	Desc: Creates new table TcssListHlaB2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaB2')
BEGIN
	-- DROP TABLE dbo.TcssListHlaB2
	PRINT 'Creating table TcssListHlaB2'
	CREATE TABLE dbo.TcssListHlaB2
	(
		TcssListHlaB2Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaB2 TO PUBLIC
GO
