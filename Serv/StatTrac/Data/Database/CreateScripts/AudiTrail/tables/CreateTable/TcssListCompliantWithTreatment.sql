/***************************************************************************************************
**	Name: TcssListCompliantWithTreatment
**	Desc: Creates new table TcssListCompliantWithTreatment
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListCompliantWithTreatment')
BEGIN
	-- DROP TABLE dbo.TcssListCompliantWithTreatment
	PRINT 'Creating table TcssListCompliantWithTreatment'
	CREATE TABLE dbo.TcssListCompliantWithTreatment
	(
		TcssListCompliantWithTreatmentId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListCompliantWithTreatment TO PUBLIC
GO
