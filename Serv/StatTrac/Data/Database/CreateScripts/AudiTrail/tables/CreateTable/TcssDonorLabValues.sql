/***************************************************************************************************
**	Name: TcssDonorLabValues
**	Desc: Creates new table TcssDonorLabValues
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorLabValues')
BEGIN
	-- DROP TABLE dbo.TcssDonorLabValues
	PRINT 'Creating table TcssDonorLabValues'
	CREATE TABLE dbo.TcssDonorLabValues
	(
		TcssDonorLabValuesId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		SampleDateTime smalldatetime NULL,
		Cpk varchar(50) NULL,
		Ckmb varchar(50) NULL,
		TroponinL varchar(50) NULL,
		TroponinT varchar(50) NULL
	)
END
GO

GRANT SELECT ON TcssDonorLabValues TO PUBLIC
GO
