/***************************************************************************************************
**	Name: TcssListCardiacArrestDownTime
**	Desc: Creates new table TcssListCardiacArrestDownTime
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListCardiacArrestDownTime')
BEGIN
	-- DROP TABLE dbo.TcssListCardiacArrestDownTime
	PRINT 'Creating table TcssListCardiacArrestDownTime'
	CREATE TABLE dbo.TcssListCardiacArrestDownTime
	(
		TcssListCardiacArrestDownTimeId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListCardiacArrestDownTime TO PUBLIC
GO
