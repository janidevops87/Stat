/***************************************************************************************************
**	Name: FsbCaseStatus
**	Desc: Add Primary keys, Unique keys, and Default Keys to FsbCaseStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_FsbCaseStatus')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_FsbCaseStatus'
	ALTER TABLE dbo.FsbCaseStatus ADD CONSTRAINT PK_FsbCaseStatus PRIMARY KEY Clustered (FsbCaseStatusId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_FsbCaseStatus_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_FsbCaseStatus_LastModified'
	ALTER TABLE dbo.FsbCaseStatus ADD CONSTRAINT DF_FsbCaseStatus_LastModified DEFAULT(GetUtcDate()) FOR LastModified
END
GO
