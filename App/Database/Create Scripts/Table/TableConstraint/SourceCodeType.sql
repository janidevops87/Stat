 /***************************************************************************************************
**	Name: SourceCodeType
**	Desc: Add Primary keys, Unique keys, and Default Keys to SourceCodeType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/


IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_SourceCodeType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_SourceCodeType'
	ALTER TABLE dbo.SourceCodeType ADD CONSTRAINT PK_SourceCodeType PRIMARY KEY Clustered (SourceCodeTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_SourceCodeType_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_SourceCodeType_LastModified'
	ALTER TABLE dbo.SourceCodeType ADD CONSTRAINT DF_SourceCodeType_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
