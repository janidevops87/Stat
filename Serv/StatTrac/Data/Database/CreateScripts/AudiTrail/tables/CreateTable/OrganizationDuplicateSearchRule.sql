    /***************************************************************************************************
**	Name: OrganizationDuplicateSearchRule
**	Desc: Creates new table OrganizationDuplicateSearchRule
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/09	Bret Knoll		Initial Table Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationDuplicateSearchRule')
BEGIN
	-- DROP TABLE dbo.OrganizationDuplicateSearchRule
	PRINT 'Creating table OrganizationDuplicateSearchRule'
	CREATE TABLE OrganizationDuplicateSearchRule
		(
		OrganizationDuplicateSearchRuleId int NOT NULL ,
		OrganizationId int NULL, 
		DuplicateSearchRuleId int NULL,
		CallTypeID int NULL, 
		NumberOfDaysToSearch int NULL, 
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationDuplicateSearchRule SET (LOCK_ESCALATION = TABLE) END

	
END	