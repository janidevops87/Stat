/***************************************************************************************************
**	Name: TcssListCauseOfDeath
**	Desc: Creates new table TcssListCauseOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListCauseOfDeath')
BEGIN
	-- DROP TABLE dbo.TcssListCauseOfDeath
	PRINT 'Creating table TcssListCauseOfDeath'
	CREATE TABLE dbo.TcssListCauseOfDeath
	(
		TcssListCauseOfDeathId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListCauseOfDeath TO PUBLIC
GO
