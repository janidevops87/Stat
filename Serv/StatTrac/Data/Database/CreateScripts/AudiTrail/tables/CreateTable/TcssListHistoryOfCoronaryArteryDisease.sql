/***************************************************************************************************
**	Name: TcssListHistoryOfCoronaryArteryDisease
**	Desc: Creates new table TcssListHistoryOfCoronaryArteryDisease
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHistoryOfCoronaryArteryDisease')
BEGIN
	-- DROP TABLE dbo.TcssListHistoryOfCoronaryArteryDisease
	PRINT 'Creating table TcssListHistoryOfCoronaryArteryDisease'
	CREATE TABLE dbo.TcssListHistoryOfCoronaryArteryDisease
	(
		TcssListHistoryOfCoronaryArteryDiseaseId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHistoryOfCoronaryArteryDisease TO PUBLIC
GO
