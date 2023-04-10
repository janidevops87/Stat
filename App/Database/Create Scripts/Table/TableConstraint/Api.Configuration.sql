/******************************************************************************
		**	File: Api.Configuration.sql
		**	Name: Api.Configuration
		**	Desc: Primary Key of table Api.Configuration
		**	Auth: iosipov
		**	Date: 08/14/2017
		*******************************************************************************/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Configuration')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_Configuration'
	ALTER TABLE Api.Configuration ADD CONSTRAINT PK_Configuration PRIMARY KEY Clustered (ConfigurationId) --ON Primary
END
GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Configuration_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_Configuration_LastModified'
	ALTER TABLE Api.Configuration ADD CONSTRAINT DF_Configuration_LastModified DEFAULT(GetDate()) FOR LastModified
END