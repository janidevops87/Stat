  /***************************************************************************************************
**	Name: OrganizationStatus
**	Desc: Add Primary keys, Unique keys, and Default Keys to OrganizationStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationStatus')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_OrganizationStatus'
	ALTER TABLE dbo.OrganizationStatus ADD CONSTRAINT PK_OrganizationStatus PRIMARY KEY Clustered (OrganizationStatusId) 
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_OrganizationStatus_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_OrganizationStatus_LastModified'
	ALTER TABLE dbo.OrganizationStatus ADD CONSTRAINT DF_OrganizationStatus_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
 