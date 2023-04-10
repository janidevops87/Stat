/***************************************************************************************************
**	Name: TcssListKidneyType
**	Desc: Creates new table TcssListKidneyType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyType')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyType
	PRINT 'Creating table TcssListKidneyType'
	CREATE TABLE dbo.TcssListKidneyType
	(
		TcssListKidneyTypeId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyType TO PUBLIC
GO
