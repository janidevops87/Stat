/***************************************************************************************************
**	Name: TcssListMedicationDoseUnit
**	Desc: Creates new table TcssListMedicationDoseUnit
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListMedicationDoseUnit')
BEGIN
	-- DROP TABLE dbo.TcssListMedicationDoseUnit
	PRINT 'Creating table TcssListMedicationDoseUnit'
	CREATE TABLE dbo.TcssListMedicationDoseUnit
	(
		TcssListMedicationDoseUnitId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListMedicationDoseUnit TO PUBLIC
GO
