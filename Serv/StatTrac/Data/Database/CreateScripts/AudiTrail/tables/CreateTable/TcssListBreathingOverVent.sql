/***************************************************************************************************
**	Name: TcssListBreathingOverVent
**	Desc: Creates new table TcssListBreathingOverVent
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListBreathingOverVent')
BEGIN
	-- DROP TABLE dbo.TcssListBreathingOverVent
	PRINT 'Creating table TcssListBreathingOverVent'
	CREATE TABLE dbo.TcssListBreathingOverVent
	(
		TcssListBreathingOverVentId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListBreathingOverVent TO PUBLIC
GO
