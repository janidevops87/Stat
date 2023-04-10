/***************************************************************************************************
**	Name: TcssDonorVitalSign
**	Desc: Creates new table TcssDonorVitalSign
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorVitalSign')
BEGIN
	-- DROP TABLE dbo.TcssDonorVitalSign
	PRINT 'Creating table TcssDonorVitalSign'
	CREATE TABLE dbo.TcssDonorVitalSign
	(
		TcssDonorVitalSignId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		FromDateTime smalldatetime NULL,
		ToDateTime smalldatetime NULL
	)
END
GO

GRANT SELECT ON TcssDonorVitalSign TO PUBLIC
GO
