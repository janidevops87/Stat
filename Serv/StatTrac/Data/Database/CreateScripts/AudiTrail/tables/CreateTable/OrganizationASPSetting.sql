   /***************************************************************************************************
**	Name: OrganizationASPSetting
**	Desc: Creates new table OrganizationASPSetting
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/09	Bret Knoll		Initial Table Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationASPSetting')
BEGIN
	-- DROP TABLE dbo.OrganizationASPSetting
	PRINT 'Creating table OrganizationASPSetting'
	CREATE TABLE OrganizationASPSetting
		(
		OrganizationASPSettingId int NOT NULL ,
		OrganizationId int NULL, 
		AspSettingTypeId int NULL, 
		LinkToStatlinePhoneSystem int NULL,
		AutoDisplaySourceCode int NULL,
		AutoDisplaySourceCodeId int NULL, 
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationASPSetting SET (LOCK_ESCALATION = TABLE) END

	
END	