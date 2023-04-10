/***************************************************************************************************
**	Name: TcssListUrinalysisEpith
**	Desc: Creates new table TcssListUrinalysisEpith
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListUrinalysisEpith')
BEGIN
	-- DROP TABLE dbo.TcssListUrinalysisEpith
	PRINT 'Creating table TcssListUrinalysisEpith'
	CREATE TABLE dbo.TcssListUrinalysisEpith
	(
		TcssListUrinalysisEpithId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListUrinalysisEpith TO PUBLIC
GO
