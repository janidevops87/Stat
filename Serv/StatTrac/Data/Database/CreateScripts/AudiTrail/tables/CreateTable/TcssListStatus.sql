/***************************************************************************************************
**	Name: TcssListStatus
**	Desc: Creates new table TcssListStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListStatus')
BEGIN
	-- DROP TABLE dbo.TcssListStatus
	PRINT 'Creating table TcssListStatus'
	CREATE TABLE dbo.TcssListStatus
	(
		TcssListStatusId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListStatus TO PUBLIC
GO
