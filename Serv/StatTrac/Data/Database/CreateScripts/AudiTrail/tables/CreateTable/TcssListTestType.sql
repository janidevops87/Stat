/***************************************************************************************************
**	Name: TcssListTestType
**	Desc: Creates new table TcssListTestType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListTestType')
BEGIN
	-- DROP TABLE dbo.TcssListTestType
	PRINT 'Creating table TcssListTestType'
	CREATE TABLE dbo.TcssListTestType
	(
		TcssListTestTypeId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListTestType TO PUBLIC
GO
