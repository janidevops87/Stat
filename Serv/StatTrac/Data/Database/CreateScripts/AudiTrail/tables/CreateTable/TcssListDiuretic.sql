/***************************************************************************************************
**	Name: TcssListDiuretic
**	Desc: Creates new table TcssListDiuretic
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListDiuretic')
BEGIN
	-- DROP TABLE dbo.TcssListDiuretic
	PRINT 'Creating table TcssListDiuretic'
	CREATE TABLE dbo.TcssListDiuretic
	(
		TcssListDiureticId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListDiuretic TO PUBLIC
GO
