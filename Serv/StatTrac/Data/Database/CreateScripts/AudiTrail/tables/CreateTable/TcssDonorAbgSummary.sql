/***************************************************************************************************
**	Name: TcssDonorAbgSummary
**	Desc: Creates new table TcssDonorAbgSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorAbgSummary')
BEGIN
	-- DROP TABLE dbo.TcssDonorAbgSummary
	PRINT 'Creating table TcssDonorAbgSummary'
	CREATE TABLE dbo.TcssDonorAbgSummary
	(
		TcssDonorAbgSummaryId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		HowManyDaysVented int NULL
	)
END
GO

GO
GRANT SELECT ON TcssDonorAbgSummary TO PUBLIC
GO
