/***************************************************************************************************
**	Name: TcssListHeavyAlcoholUse
**	Desc: Creates new table TcssListHeavyAlcoholUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHeavyAlcoholUse')
BEGIN
	-- DROP TABLE dbo.TcssListHeavyAlcoholUse
	PRINT 'Creating table TcssListHeavyAlcoholUse'
	CREATE TABLE dbo.TcssListHeavyAlcoholUse
	(
		TcssListHeavyAlcoholUseId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHeavyAlcoholUse TO PUBLIC
GO
