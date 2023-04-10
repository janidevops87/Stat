/***************************************************************************************************
**	Name: TcssListVasodilator
**	Desc: Creates new table TcssListVasodilator
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListVasodilator')
BEGIN
	-- DROP TABLE dbo.TcssListVasodilator
	PRINT 'Creating table TcssListVasodilator'
	CREATE TABLE dbo.TcssListVasodilator
	(
		TcssListVasodilatorId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListVasodilator TO PUBLIC
GO
