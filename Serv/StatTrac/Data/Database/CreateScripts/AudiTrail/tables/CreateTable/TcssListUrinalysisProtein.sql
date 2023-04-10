/***************************************************************************************************
**	Name: TcssListUrinalysisProtein
**	Desc: Creates new table TcssListUrinalysisProtein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListUrinalysisProtein')
BEGIN
	-- DROP TABLE dbo.TcssListUrinalysisProtein
	PRINT 'Creating table TcssListUrinalysisProtein'
	CREATE TABLE dbo.TcssListUrinalysisProtein
	(
		TcssListUrinalysisProteinId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListUrinalysisProtein TO PUBLIC
GO
