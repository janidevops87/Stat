/***************************************************************************************************
**	Name: TcssListUrinalysisGlucose
**	Desc: Creates new table TcssListUrinalysisGlucose
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListUrinalysisGlucose')
BEGIN
	-- DROP TABLE dbo.TcssListUrinalysisGlucose
	PRINT 'Creating table TcssListUrinalysisGlucose'
	CREATE TABLE dbo.TcssListUrinalysisGlucose
	(
		TcssListUrinalysisGlucoseId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListUrinalysisGlucose TO PUBLIC
GO
