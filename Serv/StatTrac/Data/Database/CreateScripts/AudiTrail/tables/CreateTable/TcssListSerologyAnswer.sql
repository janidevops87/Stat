/***************************************************************************************************
**	Name: TcssListSerologyAnswer
**	Desc: Creates new table TcssListSerologyAnswer
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListSerologyAnswer')
BEGIN
	-- DROP TABLE dbo.TcssListSerologyAnswer
	PRINT 'Creating table TcssListSerologyAnswer'
	CREATE TABLE dbo.TcssListSerologyAnswer
	(
		TcssListSerologyAnswerId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListSerologyAnswer TO PUBLIC
GO
