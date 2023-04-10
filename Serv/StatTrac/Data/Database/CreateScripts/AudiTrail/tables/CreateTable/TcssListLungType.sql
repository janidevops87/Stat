/***************************************************************************************************
**	Name: TcssListLungType
**	Desc: Creates new table TcssListLungType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListLungType')
BEGIN
	-- DROP TABLE dbo.TcssListLungType
	PRINT 'Creating table TcssListLungType'
	CREATE TABLE dbo.TcssListLungType
	(
		TcssListLungTypeId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListLungType TO PUBLIC
GO
