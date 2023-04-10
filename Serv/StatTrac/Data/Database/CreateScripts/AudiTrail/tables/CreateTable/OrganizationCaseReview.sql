/***************************************************************************************************
**	Name: OrganizationCaseReview
**	Desc: Creates new table OrganizationCaseReview
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/09	Bret Knoll		Initial Table Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationCaseReview')
BEGIN
	-- DROP TABLE dbo.OrganizationCaseReview
	PRINT 'Creating table OrganizationCaseReview'
	CREATE TABLE OrganizationCaseReview
		(
		OrganizationCaseReviewId int NOT NULL ,
		OrganizationId int NULL, 
		CaseTypeId int NULL, 
		CaseReviewPercentage int NULL, 
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationCaseReview SET (LOCK_ESCALATION = TABLE) END

	
END	