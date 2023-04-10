/***************************************************************************************************
**	Name: TcssListLiverBiopsy
**	Desc: Creates new table TcssListLiverBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListLiverBiopsy')
BEGIN
	-- DROP TABLE dbo.TcssListLiverBiopsy
	PRINT 'Creating table TcssListLiverBiopsy'
	CREATE TABLE dbo.TcssListLiverBiopsy
	(
		TcssListLiverBiopsyId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListLiverBiopsy TO PUBLIC
GO
