/***************************************************************************************************
**	Name: TcssListUrinalysisRbc
**	Desc: Creates new table TcssListUrinalysisRbc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListUrinalysisRbc')
BEGIN
	-- DROP TABLE dbo.TcssListUrinalysisRbc
	PRINT 'Creating table TcssListUrinalysisRbc'
	CREATE TABLE dbo.TcssListUrinalysisRbc
	(
		TcssListUrinalysisRbcId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListUrinalysisRbc TO PUBLIC
GO
