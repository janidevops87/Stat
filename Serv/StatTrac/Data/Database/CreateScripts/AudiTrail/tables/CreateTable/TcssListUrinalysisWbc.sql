/***************************************************************************************************
**	Name: TcssListUrinalysisWbc
**	Desc: Creates new table TcssListUrinalysisWbc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListUrinalysisWbc')
BEGIN
	-- DROP TABLE dbo.TcssListUrinalysisWbc
	PRINT 'Creating table TcssListUrinalysisWbc'
	CREATE TABLE dbo.TcssListUrinalysisWbc
	(
		TcssListUrinalysisWbcId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListUrinalysisWbc TO PUBLIC
GO
