/***************************************************************************************************
**	Name: TcssListDonorMeetCdcGuidelines
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDonorMeetCdcGuidelines
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDonorMeetCdcGuidelines')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDonorMeetCdcGuidelines'
	ALTER TABLE dbo.TcssListDonorMeetCdcGuidelines ADD CONSTRAINT PK_TcssListDonorMeetCdcGuidelines PRIMARY KEY Clustered (TcssListDonorMeetCdcGuidelinesId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorMeetCdcGuidelines_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorMeetCdcGuidelines_LastUpdateDate'
	ALTER TABLE dbo.TcssListDonorMeetCdcGuidelines ADD CONSTRAINT DF_TcssListDonorMeetCdcGuidelines_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorMeetCdcGuidelines_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorMeetCdcGuidelines_SortOrder'
	ALTER TABLE dbo.TcssListDonorMeetCdcGuidelines ADD CONSTRAINT DF_TcssListDonorMeetCdcGuidelines_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorMeetCdcGuidelines_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorMeetCdcGuidelines_IsActive'
	ALTER TABLE dbo.TcssListDonorMeetCdcGuidelines ADD CONSTRAINT DF_TcssListDonorMeetCdcGuidelines_IsActive DEFAULT(1) FOR IsActive
END
GO
