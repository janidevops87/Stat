/***************************************************************************************************
**	Name: TcssListUrinalysisCast
**	Desc: Creates new table TcssListUrinalysisCast
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListUrinalysisCast')
BEGIN
	-- DROP TABLE dbo.TcssListUrinalysisCast
	PRINT 'Creating table TcssListUrinalysisCast'
	CREATE TABLE dbo.TcssListUrinalysisCast
	(
		TcssListUrinalysisCastId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListUrinalysisCast TO PUBLIC
GO
