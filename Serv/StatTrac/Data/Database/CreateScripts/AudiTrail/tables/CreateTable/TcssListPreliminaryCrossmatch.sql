/***************************************************************************************************
**	Name: TcssListPreliminaryCrossmatch
**	Desc: Creates new table TcssListPreliminaryCrossmatch
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListPreliminaryCrossmatch')
BEGIN
	-- DROP TABLE dbo.TcssListPreliminaryCrossmatch
	PRINT 'Creating table TcssListPreliminaryCrossmatch'
	CREATE TABLE dbo.TcssListPreliminaryCrossmatch
	(
		TcssListPreliminaryCrossmatchId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListPreliminaryCrossmatch TO PUBLIC
GO
