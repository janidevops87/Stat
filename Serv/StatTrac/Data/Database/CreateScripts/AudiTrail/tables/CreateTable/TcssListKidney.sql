/***************************************************************************************************
**	Name: TcssListKidney
**	Desc: Creates new table TcssListKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidney')
BEGIN
	-- DROP TABLE dbo.TcssListKidney
	PRINT 'Creating table TcssListKidney'
	CREATE TABLE dbo.TcssListKidney
	(
		TcssListKidneyId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidney TO PUBLIC
GO
