/***************************************************************************************************
**	Name: TcssListHlaDr1
**	Desc: Creates new table TcssListHlaDr1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaDr1')
BEGIN
	-- DROP TABLE dbo.TcssListHlaDr1
	PRINT 'Creating table TcssListHlaDr1'
	CREATE TABLE dbo.TcssListHlaDr1
	(
		TcssListHlaDr1Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaDr1 TO PUBLIC
GO
