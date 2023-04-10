/***************************************************************************************************
**	Name: TcssListAntihypertensive
**	Desc: Creates new table TcssListAntihypertensive
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListAntihypertensive')
BEGIN
	-- DROP TABLE dbo.TcssListAntihypertensive
	PRINT 'Creating table TcssListAntihypertensive'
	CREATE TABLE dbo.TcssListAntihypertensive
	(
		TcssListAntihypertensiveId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListAntihypertensive TO PUBLIC
GO
