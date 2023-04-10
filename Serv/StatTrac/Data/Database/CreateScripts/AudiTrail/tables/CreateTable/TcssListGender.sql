/***************************************************************************************************
**	Name: TcssListGender
**	Desc: Creates new table TcssListGender
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListGender')
BEGIN
	-- DROP TABLE dbo.TcssListGender
	PRINT 'Creating table TcssListGender'
	CREATE TABLE dbo.TcssListGender
	(
		TcssListGenderId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListGender TO PUBLIC
GO
