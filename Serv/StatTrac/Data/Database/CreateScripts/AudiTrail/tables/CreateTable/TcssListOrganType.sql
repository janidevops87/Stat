/***************************************************************************************************
**	Name: TcssListOrganType
**	Desc: Creates new table TcssListOrganType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListOrganType')
BEGIN
	-- DROP TABLE dbo.TcssListOrganType
	PRINT 'Creating table TcssListOrganType'
	CREATE TABLE dbo.TcssListOrganType
	(
		TcssListOrganTypeId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListOrganType TO PUBLIC
GO
