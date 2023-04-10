 /***************************************************************************************************
**	Name: CountryCode
**	Desc: Add Primary keys, Unique keys, and Default Keys to CountryCode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_CountryCode')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_CountryCode'
	ALTER TABLE dbo.CountryCode ADD CONSTRAINT PK_CountryCode PRIMARY KEY Clustered (CountryCodeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_CountryCode_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_CountryCode_LastModified'
	ALTER TABLE dbo.CountryCode ADD CONSTRAINT DF_CountryCode_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
