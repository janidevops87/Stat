 /***************************************************************************************************
**	Name: CountryCode
**	Desc: Creates new table CountryCode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/10/09	Bret Knoll		Initial Table Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
 IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'CountryCode')
BEGIN
	-- DROP TABLE dbo.CountryCode
	PRINT 'Creating table CountryCode'
	CREATE TABLE CountryCode
		(
		CountryCodeId int NOT NULL ,
		CountryCode nvarchar(10) NULL,
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	

END	

IF NOT EXISTS (
			select * from sys.columns 
			where object_id in (select object_id from sys.objects where name = 'CountryCode')
			AND sys.columns.name = 'CountryId'
			)
BEGIN
	PRINT 'ALTERING TABLE CountryCode Adding New Columns'
	ALTER TABLE CountryCode
		ADD CountryId INT NULL
	
END 

GO
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE CountryCode SET (LOCK_ESCALATION = TABLE) END

	