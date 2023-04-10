/***************************************************************************************************
**	Name: TcssListCircumstancesOfDeath
**	Desc: Creates new table TcssListCircumstancesOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListCircumstancesOfDeath')
BEGIN
	-- DROP TABLE dbo.TcssListCircumstancesOfDeath
	PRINT 'Creating table TcssListCircumstancesOfDeath'
	CREATE TABLE dbo.TcssListCircumstancesOfDeath
	(
		TcssListCircumstancesOfDeathId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListCircumstancesOfDeath TO PUBLIC
GO
