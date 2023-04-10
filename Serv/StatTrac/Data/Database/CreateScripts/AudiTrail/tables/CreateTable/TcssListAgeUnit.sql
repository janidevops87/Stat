/***************************************************************************************************
**	Name: TcssListAgeUnit
**	Desc: Creates new table TcssListAgeUnit
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListAgeUnit')
BEGIN
	-- DROP TABLE dbo.TcssListAgeUnit
	PRINT 'Creating table TcssListAgeUnit'
	CREATE TABLE dbo.TcssListAgeUnit
	(
		TcssListAgeUnitId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListAgeUnit TO PUBLIC
GO
