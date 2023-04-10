/***************************************************************************************************
**	Name: TcssListKidneyVein
**	Desc: Creates new table TcssListKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyVein')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyVein
	PRINT 'Creating table TcssListKidneyVein'
	CREATE TABLE dbo.TcssListKidneyVein
	(
		TcssListKidneyVeinId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyVein TO PUBLIC
GO
