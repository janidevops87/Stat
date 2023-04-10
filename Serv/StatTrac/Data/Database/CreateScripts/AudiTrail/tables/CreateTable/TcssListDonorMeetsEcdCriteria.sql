/***************************************************************************************************
**	Name: TcssListDonorMeetsEcdCriteria
**	Desc: Creates new table TcssListDonorMeetsEcdCriteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListDonorMeetsEcdCriteria')
BEGIN
	-- DROP TABLE dbo.TcssListDonorMeetsEcdCriteria
	PRINT 'Creating table TcssListDonorMeetsEcdCriteria'
	CREATE TABLE dbo.TcssListDonorMeetsEcdCriteria
	(
		TcssListDonorMeetsEcdCriteriaId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListDonorMeetsEcdCriteria TO PUBLIC
GO
