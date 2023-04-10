/***************************************************************************************************
**	Name: TcssListKidneyBiopsy
**	Desc: Creates new table TcssListKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyBiopsy')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyBiopsy
	PRINT 'Creating table TcssListKidneyBiopsy'
	CREATE TABLE dbo.TcssListKidneyBiopsy
	(
		TcssListKidneyBiopsyId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100)
	)
END
GO

GRANT SELECT ON TcssListKidneyBiopsy TO PUBLIC
GO
