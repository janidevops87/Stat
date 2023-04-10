/***************************************************************************************************
**	Name: TcssListT4
**	Desc: Creates new table TcssListT4
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListT4')
BEGIN
	-- DROP TABLE dbo.TcssListT4
	PRINT 'Creating table TcssListT4'
	CREATE TABLE dbo.TcssListT4
	(
		TcssListT4Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListT4 TO PUBLIC
GO
