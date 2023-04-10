/***************************************************************************************************
**	Name: TcssListHypertensionHistory
**	Desc: Creates new table TcssListHypertensionHistory
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHypertensionHistory')
BEGIN
	-- DROP TABLE dbo.TcssListHypertensionHistory
	PRINT 'Creating table TcssListHypertensionHistory'
	CREATE TABLE dbo.TcssListHypertensionHistory
	(
		TcssListHypertensionHistoryId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHypertensionHistory TO PUBLIC
GO
