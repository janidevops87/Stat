/***************************************************************************************************
**	Name: TcssListHlaDr51
**	Desc: Creates new table TcssListHlaDr51
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaDr51')
BEGIN
	-- DROP TABLE dbo.TcssListHlaDr51
	PRINT 'Creating table TcssListHlaDr51'
	CREATE TABLE dbo.TcssListHlaDr51
	(
		TcssListHlaDr51Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaDr51 TO PUBLIC
GO
