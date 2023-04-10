/***************************************************************************************************
**	Name: TcssListLiverType
**	Desc: Creates new table TcssListLiverType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListLiverType')
BEGIN
	-- DROP TABLE dbo.TcssListLiverType
	PRINT 'Creating table TcssListLiverType'
	CREATE TABLE dbo.TcssListLiverType
	(
		TcssListLiverTypeId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListLiverType TO PUBLIC
GO
