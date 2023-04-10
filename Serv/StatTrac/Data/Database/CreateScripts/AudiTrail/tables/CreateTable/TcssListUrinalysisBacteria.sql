/***************************************************************************************************
**	Name: TcssListUrinalysisBacteria
**	Desc: Creates new table TcssListUrinalysisBacteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListUrinalysisBacteria')
BEGIN
	-- DROP TABLE dbo.TcssListUrinalysisBacteria
	PRINT 'Creating table TcssListUrinalysisBacteria'
	CREATE TABLE dbo.TcssListUrinalysisBacteria
	(
		TcssListUrinalysisBacteriaId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListUrinalysisBacteria TO PUBLIC
GO
