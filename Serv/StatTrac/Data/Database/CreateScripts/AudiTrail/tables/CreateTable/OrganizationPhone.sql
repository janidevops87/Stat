/***************************************************************************************************
**	Name: OrganizationPhone
**	Desc: Creates new table OrganizationPhone
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/09	Bret Knoll		Initial Table Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationPhone')
BEGIN
	-- DROP TABLE dbo.OrganizationPhone
	PRINT 'Creating table OrganizationPhone'
	CREATE TABLE OrganizationPhone
		(
		OrganizationPhoneID int NOT NULL ,
		OrganizationID int NULL,
		PhoneID int NULL,
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	
	

	
END	

IF NOT EXISTS (
			select * from sys.columns where object_id in (select object_id from sys.objects where name = 'OrganizationPhone')
			AND sys.columns.name = 'SubLocationID'
			)
BEGIN
	PRINT 'ALTERING TABLE OrganizationPhone Adding New Columns'
	ALTER TABLE OrganizationPhone
		ADD SubLocationID INT NULL,		
		SubLocationLevelID INT NULL
	
END



IF NOT EXISTS (
			select * from sys.columns where object_id in (select object_id from sys.objects where name = 'OrganizationPhone')
			AND sys.columns.name = 'Inactive'
			)
BEGIN
	PRINT 'ALTERING TABLE OrganizationPhone Adding New Columns'
	ALTER TABLE OrganizationPhone
		ADD Inactive SmallInt NULL
			DEFAULT 0 WITH VALUES
	
END




GO
if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationPhone SET (LOCK_ESCALATION = TABLE) END
