/***************************************************************************************************
**	Name: TcssListDaylightSavingsObserved
**	Desc: Creates new table TcssListDaylightSavingsObserved
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListDaylightSavingsObserved')
BEGIN
	-- DROP TABLE dbo.TcssListDaylightSavingsObserved
	PRINT 'Creating table TcssListDaylightSavingsObserved'
	CREATE TABLE dbo.TcssListDaylightSavingsObserved
	(
		TcssListDaylightSavingsObservedId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListDaylightSavingsObserved TO PUBLIC
GO
