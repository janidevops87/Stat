/***************************************************************************************************
**	Name: TcssListChestTrauma
**	Desc: Creates new table TcssListChestTrauma
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListChestTrauma')
BEGIN
	-- DROP TABLE dbo.TcssListChestTrauma
	PRINT 'Creating table TcssListChestTrauma'
	CREATE TABLE dbo.TcssListChestTrauma
	(
		TcssListChestTraumaId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListChestTrauma TO PUBLIC
GO
