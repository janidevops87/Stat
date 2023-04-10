/***************************************************************************************************
**	Name: TcssListHeparin
**	Desc: Creates new table TcssListHeparin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/11/2010	jth				Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHeparin')
BEGIN
	-- DROP TABLE dbo.TcssListHeparin
	PRINT 'Creating table TcssListHeparin'
	CREATE TABLE dbo.TcssListHeparin
	(
		TcssListHeparinId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHeparin TO PUBLIC
GO
