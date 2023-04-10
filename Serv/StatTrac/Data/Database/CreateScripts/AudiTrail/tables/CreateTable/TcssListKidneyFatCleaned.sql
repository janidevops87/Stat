/***************************************************************************************************
**	Name: TcssListKidneyFatCleaned
**	Desc: Creates new table TcssListKidneyFatCleaned
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyFatCleaned')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyFatCleaned
	PRINT 'Creating table TcssListKidneyFatCleaned'
	CREATE TABLE dbo.TcssListKidneyFatCleaned
	(
		TcssListKidneyFatCleanedId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyFatCleaned TO PUBLIC
GO
