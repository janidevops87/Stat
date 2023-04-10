/***************************************************************************************************
**	Name: TcssDonorTest
**	Desc: Creates new table TcssDonorTest
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorTest')
BEGIN
	-- DROP TABLE dbo.TcssDonorTest
	PRINT 'Creating table TcssDonorTest'
	CREATE TABLE dbo.TcssDonorTest
	(
		TcssDonorTestId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		TcssListTestTypeId int NULL,
		TestDateTime smalldatetime NULL,
		Interpretation varchar(5000) NULL
	)
END
GO

GRANT SELECT ON TcssDonorTest TO PUBLIC
GO
