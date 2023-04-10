/***************************************************************************************************
**	Name: TcssListCprAdministered
**	Desc: Creates new table TcssListCprAdministered
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListCprAdministered')
BEGIN
	-- DROP TABLE dbo.TcssListCprAdministered
	PRINT 'Creating table TcssListCprAdministered'
	CREATE TABLE dbo.TcssListCprAdministered
	(
		TcssListCprAdministeredId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListCprAdministered TO PUBLIC
GO
