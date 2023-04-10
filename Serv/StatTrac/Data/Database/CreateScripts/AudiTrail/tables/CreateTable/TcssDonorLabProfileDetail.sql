/***************************************************************************************************
**	Name: TcssDonorLabProfileDetail
**	Desc: Creates new table TcssDonorLabProfileDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorLabProfileDetail')
BEGIN
	-- DROP TABLE dbo.TcssDonorLabProfileDetail
	PRINT 'Creating table TcssDonorLabProfileDetail'
	CREATE TABLE dbo.TcssDonorLabProfileDetail
	(
		TcssDonorLabProfileDetailId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssDonorLabProfileId int NULL,
		TcssListLabId int NULL,
		Answer varchar(50) NULL
	)
END
GO

GRANT SELECT ON TcssDonorLabProfileDetail TO PUBLIC
GO
