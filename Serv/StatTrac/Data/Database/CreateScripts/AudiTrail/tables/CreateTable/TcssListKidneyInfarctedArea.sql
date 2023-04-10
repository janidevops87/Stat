/***************************************************************************************************
**	Name: TcssListKidneyInfarctedArea
**	Desc: Creates new table TcssListKidneyInfarctedArea
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyInfarctedArea')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyInfarctedArea
	PRINT 'Creating table TcssListKidneyInfarctedArea'
	CREATE TABLE dbo.TcssListKidneyInfarctedArea
	(
		TcssListKidneyInfarctedAreaId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyInfarctedArea TO PUBLIC
GO
