/***************************************************************************************************
**	Name: TcssListUrinalysisBlood
**	Desc: Creates new table TcssListUrinalysisBlood
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListUrinalysisBlood')
BEGIN
	-- DROP TABLE dbo.TcssListUrinalysisBlood
	PRINT 'Creating table TcssListUrinalysisBlood'
	CREATE TABLE dbo.TcssListUrinalysisBlood
	(
		TcssListUrinalysisBloodId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListUrinalysisBlood TO PUBLIC
GO
