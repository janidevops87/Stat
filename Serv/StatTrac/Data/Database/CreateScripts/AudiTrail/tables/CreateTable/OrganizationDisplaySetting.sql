     /***************************************************************************************************
**	Name: OrganizationDisplaySetting
**	Desc: Creates new table OrganizationDisplaySetting
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/09	Bret Knoll		Initial Table Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationDisplaySetting')
BEGIN
	-- DROP TABLE dbo.OrganizationDisplaySetting
	PRINT 'Creating table OrganizationDisplaySetting'
	CREATE TABLE OrganizationDisplaySetting
		(
		OrganizationDisplaySettingId int NOT NULL ,
		OrganizationId int NULL, 
		DashBoardDisplaySettingId int NULL, 
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationDisplaySetting SET (LOCK_ESCALATION = TABLE) END

	
END	