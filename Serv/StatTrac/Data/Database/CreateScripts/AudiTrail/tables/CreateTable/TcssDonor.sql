/***************************************************************************************************
**	Name: TcssDonor
**	Desc: Creates new table TcssDonor
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonor')
BEGIN
	-- DROP TABLE dbo.TcssDonor
	PRINT 'Creating table TcssDonor'
	CREATE TABLE dbo.TcssDonor
	(
		TcssDonorId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		OptnNumber varchar(20) NULL
	)
END
GO

GRANT SELECT ON TcssDonor TO PUBLIC
GO
