/***************************************************************************************************
**	Name: TcssListSerologyQuestion
**	Desc: Creates new table TcssListSerologyQuestion
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListSerologyQuestion')
BEGIN
	-- DROP TABLE dbo.TcssListSerologyQuestion
	PRINT 'Creating table TcssListSerologyQuestion'
	CREATE TABLE dbo.TcssListSerologyQuestion
	(
		TcssListSerologyQuestionId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL,
		ConfigVersion bigint NULL
	)
END
GO

GRANT SELECT ON TcssListSerologyQuestion TO PUBLIC
GO
