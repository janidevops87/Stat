/***************************************************************************************************
**	Name: TcssListRace
**	Desc: Creates new table TcssListRace
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListRace')
BEGIN
	-- DROP TABLE dbo.TcssListRace
	PRINT 'Creating table TcssListRace'
	CREATE TABLE dbo.TcssListRace
	(
		TcssListRaceId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListRace TO PUBLIC
GO
