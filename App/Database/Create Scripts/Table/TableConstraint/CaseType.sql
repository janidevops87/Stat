 /***************************************************************************************************
**	Name: CaseType
**	Desc: Add Primary keys, Unique keys, and Default Keys to CaseType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_CaseType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_CaseType'
	ALTER TABLE dbo.CaseType ADD CONSTRAINT PK_CaseType PRIMARY KEY Clustered (CaseTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_CaseType_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_CaseType_LastModified'
	ALTER TABLE dbo.CaseType ADD CONSTRAINT DF_CaseType_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
