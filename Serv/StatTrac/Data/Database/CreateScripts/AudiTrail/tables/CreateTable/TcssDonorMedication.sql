/***************************************************************************************************
**	Name: TcssDonorMedication
**	Desc: Creates new table TcssDonorMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorMedication')
BEGIN
	-- DROP TABLE dbo.TcssDonorMedication
	PRINT 'Creating table TcssDonorMedication'
	CREATE TABLE dbo.TcssDonorMedication
	(
		TcssDonorMedicationId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListMedicationId int NULL,
		StartDate smalldatetime NULL,
		StopDateTime smalldatetime NULL,
		Dose int NULL,
		TcssListMedicationDoseUnitId int NULL,
		Duration int NULL
	)
END
GO

-- Alter column length
ALTER TABLE dbo.TcssDonorMedication ALTER COLUMN Dose decimal(18,2)
GO


GRANT SELECT ON TcssDonorMedication TO PUBLIC
GO
