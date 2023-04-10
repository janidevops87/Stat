/***************************************************************************************************
**	Name: TcssListMedication
**	Desc: Creates new table TcssListMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListMedication')
BEGIN
	-- DROP TABLE dbo.TcssListMedication
	PRINT 'Creating table TcssListMedication'
	CREATE TABLE dbo.TcssListMedication
	(
		TcssListMedicationId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListMedication TO PUBLIC
GO
