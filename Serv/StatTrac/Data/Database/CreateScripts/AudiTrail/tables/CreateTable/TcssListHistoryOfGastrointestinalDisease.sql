/***************************************************************************************************
**	Name: TcssListHistoryOfGastrointestinalDisease
**	Desc: Creates new table TcssListHistoryOfGastrointestinalDisease
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHistoryOfGastrointestinalDisease')
BEGIN
	-- DROP TABLE dbo.TcssListHistoryOfGastrointestinalDisease
	PRINT 'Creating table TcssListHistoryOfGastrointestinalDisease'
	CREATE TABLE dbo.TcssListHistoryOfGastrointestinalDisease
	(
		TcssListHistoryOfGastrointestinalDiseaseId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHistoryOfGastrointestinalDisease TO PUBLIC
GO
