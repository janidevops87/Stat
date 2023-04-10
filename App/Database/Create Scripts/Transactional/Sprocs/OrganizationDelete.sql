 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[OrganizationDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[OrganizationDelete]
	PRINT 'Dropping Procedure: OrganizationDelete'
END
	PRINT 'Creating Procedure: OrganizationDelete'
GO

CREATE PROCEDURE [dbo].[OrganizationDelete]
(
	@OrganizationID int,
	@LastStatEmployeeId int = null,
	@LastModified datetime = null,
	@AuditLogTypeId int = null
)
/******************************************************************************
**		File: OrganizationDelete.sql
**		Name: OrganizationDelete
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 6/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:		Author:		Description:
**	--------	--------	-------------------------------------------
**	6/19/2009	bret	`	initial
**  01/18/2011	Bret Knoll	Updated to handle cascade delete from Organization
**  08/11/2011	ccarroll	fixed delete for Alert,Criteria, WebReportGroup, ServiceLevel and Schedule Group
*******************************************************************************/
AS
	SET NOCOUNT ON
	IF(COALESCE(@OrganizationID, 0) <> 0)
	BEGIN

		-- delete children records
		EXEC BillToDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		
		EXEC OrganizationAliasDelete  @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		
		EXEC OrganizationASPSettingDelete  @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		
		EXEC OrganizationCaseReviewDelete  @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		
		EXEC OrganizationDashBoardTimerDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		
		EXEC OrganizationDisplaySettingDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		
		EXEC OrganizationDuplicateSearchRuleDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		
		
		EXEC OrganizationFsSourceCodeDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		
		EXEC OrganizationPhoneDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		

		EXEC OrganizationSourceCodeDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		 
		
		--ccarroll	Added @OrganizationID and other parameters to delete sprocs for organization cleanup
		EXEC AlertOrganizationDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		
		EXEC CriteriaOrganizationDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		
		EXEC WebReportGroupOrgDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId	
		EXEC ServiceLevel30OrganizationDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId
		EXEC ScheduleGroupOrganizationDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId


		EXEC SourceCodeOrganizationDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		 

		EXEC PersonDelete @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		 





		UPDATE
				[Organization]
		SET
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted
		WHERE 			
			[OrganizationID] = @OrganizationID

		DELETE 
		FROM   [Organization]
		WHERE  
			[OrganizationID] = @OrganizationID
	END

	RETURN @@Error
GO
