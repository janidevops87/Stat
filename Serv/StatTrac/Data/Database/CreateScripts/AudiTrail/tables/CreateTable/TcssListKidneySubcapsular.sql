/***************************************************************************************************
**	Name: TcssListKidneySubcapsular
**	Desc: Creates new table TcssListKidneySubcapsular
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneySubcapsular')
BEGIN
	-- DROP TABLE dbo.TcssListKidneySubcapsular
	PRINT 'Creating table TcssListKidneySubcapsular'
	CREATE TABLE dbo.TcssListKidneySubcapsular
	(
		TcssListKidneySubcapsularId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneySubcapsular TO PUBLIC
GO
