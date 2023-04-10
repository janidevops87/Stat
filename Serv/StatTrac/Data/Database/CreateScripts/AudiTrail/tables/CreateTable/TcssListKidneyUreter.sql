/***************************************************************************************************
**	Name: TcssListKidneyUreter
**	Desc: Creates new table TcssListKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyUreter')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyUreter
	PRINT 'Creating table TcssListKidneyUreter'
	CREATE TABLE dbo.TcssListKidneyUreter
	(
		TcssListKidneyUreterId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyUreter TO PUBLIC
GO
