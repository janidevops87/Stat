/***************************************************************************************************
**	Name: TcssListHemodynamicallyStable
**	Desc: Creates new table TcssListHemodynamicallyStable
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHemodynamicallyStable')
BEGIN
	-- DROP TABLE dbo.TcssListHemodynamicallyStable
	PRINT 'Creating table TcssListHemodynamicallyStable'
	CREATE TABLE dbo.TcssListHemodynamicallyStable
	(
		TcssListHemodynamicallyStableId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHemodynamicallyStable TO PUBLIC
GO
