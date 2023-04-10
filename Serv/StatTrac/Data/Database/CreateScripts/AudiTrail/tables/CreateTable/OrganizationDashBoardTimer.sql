    /***************************************************************************************************
**	Name: OrganizationDashBoardTimer
**	Desc: Creates new table OrganizationDashBoardTimer
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/09	Bret Knoll		Initial Table Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationDashBoardTimer')
BEGIN
	-- DROP TABLE dbo.OrganizationDashBoardTimer
	PRINT 'Creating table OrganizationDashBoardTimer'
	CREATE TABLE OrganizationDashBoardTimer
		(
		OrganizationDashBoardTimerId int NOT NULL ,
		OrganizationId int NULL, 
		DashBoardWindowId int NULL,
		DashBoardTimerTypeId int NULL, 
		ExpirationMinutes int NULL, 
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationDashBoardTimer SET (LOCK_ESCALATION = TABLE) END

	
END	