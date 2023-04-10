/***************************************************************************************************
**	Name: OrganizationFsSourceCode
**	Desc: Creates new table OrganizationFsSourceCode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/09	Bret Knoll		Initial Table Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationFsSourceCode')
BEGIN
	-- DROP TABLE dbo.OrganizationFsSourceCodeMap
	PRINT 'Creating table OrganizationFsSourceCode'
	CREATE TABLE OrganizationFsSourceCode
		(
		OrganizationFsSourceCodeId int NOT NULL ,
		OrganizationId int NULL, 
		SourceCodeId int NULL, 
		FsSourceCodeId int NULL, 
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationFsSourceCode SET (LOCK_ESCALATION = TABLE) END

	
END	 