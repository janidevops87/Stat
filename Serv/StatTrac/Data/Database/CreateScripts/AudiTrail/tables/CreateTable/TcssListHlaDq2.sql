/***************************************************************************************************
**	Name: TcssListHlaDq2
**	Desc: Creates new table TcssListHlaDq2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaDq2')
BEGIN
	-- DROP TABLE dbo.TcssListHlaDq2
	PRINT 'Creating table TcssListHlaDq2'
	CREATE TABLE dbo.TcssListHlaDq2
	(
		TcssListHlaDq2Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaDq2 TO PUBLIC
GO
