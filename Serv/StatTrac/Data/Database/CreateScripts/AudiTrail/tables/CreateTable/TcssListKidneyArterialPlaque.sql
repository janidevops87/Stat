/***************************************************************************************************
**	Name: TcssListKidneyArterialPlaque
**	Desc: Creates new table TcssListKidneyArterialPlaque
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyArterialPlaque')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyArterialPlaque
	PRINT 'Creating table TcssListKidneyArterialPlaque'
	CREATE TABLE dbo.TcssListKidneyArterialPlaque
	(
		TcssListKidneyArterialPlaqueId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyArterialPlaque TO PUBLIC
GO
