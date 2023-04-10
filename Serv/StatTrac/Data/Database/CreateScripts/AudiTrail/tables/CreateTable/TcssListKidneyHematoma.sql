/***************************************************************************************************
**	Name: TcssListKidneyHematoma
**	Desc: Creates new table TcssListKidneyHematoma
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyHematoma')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyHematoma
	PRINT 'Creating table TcssListKidneyHematoma'
	CREATE TABLE dbo.TcssListKidneyHematoma
	(
		TcssListKidneyHematomaId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyHematoma TO PUBLIC
GO
