/***************************************************************************************************
**	Name: TcssListStatusOfImportData
**	Desc: Creates new table TcssListStatusOfImportData
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListStatusOfImportData')
BEGIN
	-- DROP TABLE dbo.TcssListStatusOfImportData
	PRINT 'Creating table TcssListStatusOfImportData'
	CREATE TABLE dbo.TcssListStatusOfImportData
	(
		TcssListStatusOfImportDataId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListStatusOfImportData TO PUBLIC
GO
