/***************************************************************************************************
**	Name: TcssDonorCulture
**	Desc: Creates new table TcssDonorCulture
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorCulture')
BEGIN
	-- DROP TABLE dbo.TcssDonorCulture
	PRINT 'Creating table TcssDonorCulture'
	CREATE TABLE dbo.TcssDonorCulture
	(
		TcssDonorCultureId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		SampleDateTime smalldatetime NULL,
		TcssListCultureTypeId int NULL,
		TcssListCultureResultId int NULL,
		Comment varchar(2500) NULL
	)
END
GO

GRANT SELECT ON TcssDonorCulture TO PUBLIC
GO
