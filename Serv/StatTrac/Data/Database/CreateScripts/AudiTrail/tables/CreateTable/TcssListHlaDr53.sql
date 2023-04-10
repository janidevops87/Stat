/***************************************************************************************************
**	Name: TcssListHlaDr53
**	Desc: Creates new table TcssListHlaDr53
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaDr53')
BEGIN
	-- DROP TABLE dbo.TcssListHlaDr53
	PRINT 'Creating table TcssListHlaDr53'
	CREATE TABLE dbo.TcssListHlaDr53
	(
		TcssListHlaDr53Id int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaDr53 TO PUBLIC
GO
