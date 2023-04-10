/***************************************************************************************************
**	Name: TcssRecipientCandidate
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssRecipientCandidate
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssRecipientCandidate')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssRecipientCandidate'
	ALTER TABLE dbo.TcssRecipientCandidate ADD CONSTRAINT PK_TcssRecipientCandidate PRIMARY KEY Clustered (TcssRecipientCandidateId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssRecipientCandidate_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssRecipientCandidate_LastUpdateDate'
	ALTER TABLE dbo.TcssRecipientCandidate ADD CONSTRAINT DF_TcssRecipientCandidate_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
