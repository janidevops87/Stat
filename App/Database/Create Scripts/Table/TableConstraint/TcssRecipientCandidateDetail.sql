/***************************************************************************************************
**	Name: TcssRecipientCandidateDetail
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssRecipientCandidateDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssRecipientCandidateDetail')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssRecipientCandidateDetail'
	ALTER TABLE dbo.TcssRecipientCandidateDetail ADD CONSTRAINT PK_TcssRecipientCandidateDetail PRIMARY KEY Clustered (TcssRecipientCandidateDetailId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssRecipientCandidateDetail_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssRecipientCandidateDetail_LastUpdateDate'
	ALTER TABLE dbo.TcssRecipientCandidateDetail ADD CONSTRAINT DF_TcssRecipientCandidateDetail_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
