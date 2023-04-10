/***************************************************************************************************
**	Name: TcssListArginineVasopressin
**	Desc: Creates new table TcssListArginineVasopressin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListArginineVasopressin')
BEGIN
	-- DROP TABLE dbo.TcssListArginineVasopressin
	PRINT 'Creating table TcssListArginineVasopressin'
	CREATE TABLE dbo.TcssListArginineVasopressin
	(
		TcssListArginineVasopressinId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListArginineVasopressin TO PUBLIC
GO
