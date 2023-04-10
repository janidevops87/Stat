/***************************************************************************************************
**	Name: TcssListKidneyAorticPlaque
**	Desc: Creates new table TcssListKidneyAorticPlaque
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyAorticPlaque')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyAorticPlaque
	PRINT 'Creating table TcssListKidneyAorticPlaque'
	CREATE TABLE dbo.TcssListKidneyAorticPlaque
	(
		TcssListKidneyAorticPlaqueId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyAorticPlaque TO PUBLIC
GO
