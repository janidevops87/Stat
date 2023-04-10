/***************************************************************************************************
**	Name: TcssListUrinalysisLeukocyte
**	Desc: Creates new table TcssListUrinalysisLeukocyte
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListUrinalysisLeukocyte')
BEGIN
	-- DROP TABLE dbo.TcssListUrinalysisLeukocyte
	PRINT 'Creating table TcssListUrinalysisLeukocyte'
	CREATE TABLE dbo.TcssListUrinalysisLeukocyte
	(
		TcssListUrinalysisLeukocyteId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListUrinalysisLeukocyte TO PUBLIC
GO
