/***************************************************************************************************
**	Name: TcssDonorVitalSignDetail
**	Desc: Creates new table TcssDonorVitalSignDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorVitalSignDetail')
BEGIN
	-- DROP TABLE dbo.TcssDonorVitalSignDetail
	PRINT 'Creating table TcssDonorVitalSignDetail'
	CREATE TABLE dbo.TcssDonorVitalSignDetail
	(
		TcssDonorVitalSignDetailId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssDonorVitalSignId int NULL,
		TcssListVitalSignId int NULL,
		Answer varchar(50) NULL
	)
END

IF EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorVitalSignDetail') AND name = 'Answer')
BEGIN
	ALTER TABLE dbo.TcssDonorVitalSignDetail ALTER COLUMN Answer varchar(200) NULL
END
GO

GRANT SELECT ON TcssDonorVitalSignDetail TO PUBLIC
GO
