/***************************************************************************************************
**	Name: TcssListKidneyAorticCuff
**	Desc: Creates new table TcssListKidneyAorticCuff
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListKidneyAorticCuff')
BEGIN
	-- DROP TABLE dbo.TcssListKidneyAorticCuff
	PRINT 'Creating table TcssListKidneyAorticCuff'
	CREATE TABLE dbo.TcssListKidneyAorticCuff
	(
		TcssListKidneyAorticCuffId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListKidneyAorticCuff TO PUBLIC
GO
