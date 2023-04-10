/***************************************************************************************************
**	Name: TcssListDonorMeetCdcGuidelines
**	Desc: Creates new table TcssListDonorMeetCdcGuidelines
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListDonorMeetCdcGuidelines')
BEGIN
	-- DROP TABLE dbo.TcssListDonorMeetCdcGuidelines
	PRINT 'Creating table TcssListDonorMeetCdcGuidelines'
	CREATE TABLE dbo.TcssListDonorMeetCdcGuidelines
	(
		TcssListDonorMeetCdcGuidelinesId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListDonorMeetCdcGuidelines TO PUBLIC
GO
