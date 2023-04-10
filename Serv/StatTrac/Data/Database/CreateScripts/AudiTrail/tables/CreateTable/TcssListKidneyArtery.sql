/***************************************************************************************************
**	Name: TcssListKidneyArtery
**	Desc: Creates new table TcssListKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyArtery')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyArtery
	PRINT 'Creating table TcssListKidneyArtery'
	CREATE TABLE dbo.TcssListKidneyArtery
	(
		TcssListKidneyArteryId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyArtery TO PUBLIC
GO
