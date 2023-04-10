/***************************************************************************************************
**	Name: TcssListDonorMeetsDcdCriteria
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDonorMeetsDcdCriteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDonorMeetsDcdCriteria')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDonorMeetsDcdCriteria'
	ALTER TABLE dbo.TcssListDonorMeetsDcdCriteria ADD CONSTRAINT PK_TcssListDonorMeetsDcdCriteria PRIMARY KEY Clustered (TcssListDonorMeetsDcdCriteriaId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorMeetsDcdCriteria_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorMeetsDcdCriteria_LastUpdateDate'
	ALTER TABLE dbo.TcssListDonorMeetsDcdCriteria ADD CONSTRAINT DF_TcssListDonorMeetsDcdCriteria_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorMeetsDcdCriteria_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorMeetsDcdCriteria_SortOrder'
	ALTER TABLE dbo.TcssListDonorMeetsDcdCriteria ADD CONSTRAINT DF_TcssListDonorMeetsDcdCriteria_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorMeetsDcdCriteria_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorMeetsDcdCriteria_IsActive'
	ALTER TABLE dbo.TcssListDonorMeetsDcdCriteria ADD CONSTRAINT DF_TcssListDonorMeetsDcdCriteria_IsActive DEFAULT(1) FOR IsActive
END
GO
