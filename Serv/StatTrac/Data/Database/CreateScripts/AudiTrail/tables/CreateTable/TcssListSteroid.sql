/***************************************************************************************************
**	Name: TcssListSteroid
**	Desc: Creates new table TcssListSteroid
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListSteroid')
BEGIN
	-- DROP TABLE dbo.TcssListSteroid
	PRINT 'Creating table TcssListSteroid'
	CREATE TABLE dbo.TcssListSteroid
	(
		TcssListSteroidId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListSteroid TO PUBLIC
GO
