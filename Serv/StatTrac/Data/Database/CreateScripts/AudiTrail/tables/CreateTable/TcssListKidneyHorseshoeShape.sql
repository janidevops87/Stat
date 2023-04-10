/***************************************************************************************************
**	Name: TcssListKidneyHorseshoeShape
**	Desc: Creates new table TcssListKidneyHorseshoeShape
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyHorseshoeShape')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyHorseshoeShape
	PRINT 'Creating table TcssListKidneyHorseshoeShape'
	CREATE TABLE dbo.TcssListKidneyHorseshoeShape
	(
		TcssListKidneyHorseshoeShapeId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyHorseshoeShape TO PUBLIC
GO
