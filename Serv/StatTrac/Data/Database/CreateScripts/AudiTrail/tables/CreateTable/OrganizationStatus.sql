 /***************************************************************************************************
**	Name: OrganizationStatus
**	Desc: Creates new table OrganizationStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/09	Bret Knoll		Initial Table Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationStatus')
BEGIN
	-- DROP TABLE dbo.OrganizationStatus
	PRINT 'Creating table OrganizationStatus'
	CREATE TABLE OrganizationStatus
		(
		OrganizationStatusID int NOT NULL ,
		OrganizationStatusName nvarchar(25) NULL,
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationStatus SET (LOCK_ESCALATION = TABLE) END

	
END	