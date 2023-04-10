/***************************************************************************************************
**	Name: TcssListHlaDq1
**	Desc: Creates new table TcssListHlaDq1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListHlaDq1')
BEGIN
	-- DROP TABLE dbo.TcssListHlaDq1
	PRINT 'Creating table TcssListHlaDq1'
	CREATE TABLE dbo.TcssListHlaDq1
	(
		TcssListHlaDq1Id int NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListHlaDq1 TO PUBLIC
GO
