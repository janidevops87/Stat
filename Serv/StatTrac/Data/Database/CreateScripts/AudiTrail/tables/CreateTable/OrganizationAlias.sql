   /***************************************************************************************************
**	Name: OrganizationAlias
**	Desc: Creates new table OrganizationAlias
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/09	Bret Knoll		Initial Table Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationAlias')
BEGIN
	-- DROP TABLE dbo.OrganizationAlias
	PRINT 'Creating table OrganizationAlias'
	CREATE TABLE OrganizationAlias
		(
		OrganizationAliasId int NOT NULL ,
		OrganizationId int NULL, 
		OrganizationAliasName nvarchar(80) NULL,
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationAlias SET (LOCK_ESCALATION = TABLE) END

	
END
