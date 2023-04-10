/***************************************************************************************************
**	Name: TcssListT3
**	Desc: Creates new table TcssListT3
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListT3')
BEGIN
	-- DROP TABLE dbo.TcssListT3
	PRINT 'Creating table TcssListT3'
	CREATE TABLE dbo.TcssListT3
	(
		TcssListT3Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListT3 TO PUBLIC
GO
