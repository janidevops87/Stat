/***************************************************************************************************
**	Name: TcssListKidneyUreterTissueQuality
**	Desc: Creates new table TcssListKidneyUreterTissueQuality
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyUreterTissueQuality')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyUreterTissueQuality
	PRINT 'Creating table TcssListKidneyUreterTissueQuality'
	CREATE TABLE dbo.TcssListKidneyUreterTissueQuality
	(
		TcssListKidneyUreterTissueQualityId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyUreterTissueQuality TO PUBLIC
GO
