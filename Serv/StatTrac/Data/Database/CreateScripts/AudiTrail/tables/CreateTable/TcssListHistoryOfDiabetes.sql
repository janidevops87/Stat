/***************************************************************************************************
**	Name: TcssListHistoryOfDiabetes
**	Desc: Creates new table TcssListHistoryOfDiabetes
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHistoryOfDiabetes')
BEGIN
	-- DROP TABLE dbo.TcssListHistoryOfDiabetes
	PRINT 'Creating table TcssListHistoryOfDiabetes'
	CREATE TABLE dbo.TcssListHistoryOfDiabetes
	(
		TcssListHistoryOfDiabetesId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHistoryOfDiabetes TO PUBLIC
GO
