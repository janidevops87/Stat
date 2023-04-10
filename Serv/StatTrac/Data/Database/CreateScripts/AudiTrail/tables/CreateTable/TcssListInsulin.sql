/***************************************************************************************************
**	Name: TcssListInsulin
**	Desc: Creates new table TcssListInsulin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListInsulin')
BEGIN
	-- DROP TABLE dbo.TcssListInsulin
	PRINT 'Creating table TcssListInsulin'
	CREATE TABLE dbo.TcssListInsulin
	(
		TcssListInsulinId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListInsulin TO PUBLIC
GO
