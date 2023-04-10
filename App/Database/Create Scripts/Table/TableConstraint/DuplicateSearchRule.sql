 /***************************************************************************************************
**	Name: DuplicateSearchRule
**	Desc: Add Primary keys, Unique keys, and Default Keys to DuplicateSearchRule
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_DuplicateSearchRule')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_DuplicateSearchRule'
	ALTER TABLE dbo.DuplicateSearchRule ADD CONSTRAINT PK_DuplicateSearchRule PRIMARY KEY Clustered (DuplicateSearchRuleId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_DuplicateSearchRule_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_DuplicateSearchRule_LastModified'
	ALTER TABLE dbo.DuplicateSearchRule ADD CONSTRAINT DF_DuplicateSearchRule_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
