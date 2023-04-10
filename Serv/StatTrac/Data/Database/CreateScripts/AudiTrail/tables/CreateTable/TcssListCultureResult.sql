/***************************************************************************************************
**	Name: TcssListCultureResult
**	Desc: Creates new table TcssListCultureResult
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListCultureResult')
BEGIN
	-- DROP TABLE dbo.TcssListCultureResult
	PRINT 'Creating table TcssListCultureResult'
	CREATE TABLE dbo.TcssListCultureResult
	(
		TcssListCultureResultId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListCultureResult TO PUBLIC
GO
