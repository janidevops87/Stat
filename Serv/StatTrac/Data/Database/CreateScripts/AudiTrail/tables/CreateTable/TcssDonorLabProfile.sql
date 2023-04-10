/***************************************************************************************************
**	Name: TcssDonorLabProfile
**	Desc: Creates new table TcssDonorLabProfile
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorLabProfile')
BEGIN
	-- DROP TABLE dbo.TcssDonorLabProfile
	PRINT 'Creating table TcssDonorLabProfile'
	CREATE TABLE dbo.TcssDonorLabProfile
	(
		TcssDonorLabProfileId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		SampleDateTime smalldatetime NULL
	)
END
GO

GRANT SELECT ON TcssDonorLabProfile TO PUBLIC
GO
