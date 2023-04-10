/***************************************************************************************************
**	Name: TcssDonorDiagnosisPancreas
**	Desc: Creates new table TcssDonorDiagnosisPancreas
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorDiagnosisPancreas')
BEGIN
	-- DROP TABLE dbo.TcssDonorDiagnosisPancreas
	PRINT 'Creating table TcssDonorDiagnosisPancreas'
	CREATE TABLE dbo.TcssDonorDiagnosisPancreas
	(
		TcssDonorDiagnosisPancreasId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		Comment varchar(5000) NULL
	)
END
GO

GRANT SELECT ON TcssDonorDiagnosisPancreas TO PUBLIC
GO
