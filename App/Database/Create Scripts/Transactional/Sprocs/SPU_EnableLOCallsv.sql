SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'SPU_EnableLOCallsv')
	BEGIN
		PRINT 'Dropping Procedure SPU_EnableLOCallsv'
		DROP  Procedure  SPU_EnableLOCallsv
	END
GO

PRINT 'Creating Procedure SPU_EnableLOCallsv'
GO

CREATE PROCEDURE SPU_EnableLOCallsv
	@pvUpdateValue int, 
	@pvOrganizationID int,
	@pvTriage int,
	@pvFamilyServices int,
    @LastStatEmployeeID int = NULL  

AS
/******************************************************************************
**		File: SPU_EnableLOCallsv.sql
**		Name: SPU_EnableLOCallsv
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		unknown									initial release
**		09/08/2008		ccarroll				Added LastModified and LastStatEmployeeID for AuditTrail 
*******************************************************************************/
DECLARE @CurrentLOTriageEnable int
DECLARE @CurrentLOFSEnable int

SELECT @CurrentLOTriageEnable = C.OrganizationLOTriageEnabled,
	   @CurrentLOFSEnable	  = C.OrganizationLOFSEnabled
	FROM
		(SELECT
				OrganizationLOTriageEnabled,
				OrganizationLOFSEnabled
			FROM Organization 
			WHERE OrganizationID = @pvOrganizationID
		) AS C
	 

If @pvTriage + @CurrentLOFSEnable = 0
	OR @pvFamilyServices + @CurrentLOTriageEnable = 0
	BEGIN
		SELECT @pvUpdateValue = 0
	END


--'Enable / Disable LO Calls
If @pvTriage < 1
BEGIN
		UPDATE	Organization
			SET		OrganizationLOEnabled = IsNull(@pvUpdateValue, -1),
					OrganizationLOTriageEnabled = IsNull(@pvTriage, -1),
					LastModified = GetDate(),
					LastStatEmployeeID = @LastStatEmployeeID,
					AuditLogTypeID = 3
		WHERE OrganizationID = @pvOrganizationID
END

If @pvFamilyServices < 1
BEGIN
		UPDATE	Organization
			SET		OrganizationLOEnabled = IsNull(@pvUpdateValue, -1),
					OrganizationLOFSEnabled = IsNull(@pvFamilyServices, -1),
					LastModified = GetDate(),
					LastStatEmployeeID = @LastStatEmployeeID,
					AuditLogTypeID = 3
		WHERE OrganizationID = @pvOrganizationID
END



UPDATE SourceCode
SET SourceCodeDisabledInterval = CASE @pvUpdateValue WHEN -1 THEN SourceCodeLineCheckInterval ELSE 0 END,
SourceCodeLineCheckInterval = CASE @pvUpdateValue WHEN -1 THEN 0 ELSE SourceCodeLineCheckInterval END
WHERE SourceCodeName IN (SELECT DISTINCT SourceCodeName
			 FROM SourceCode
			 JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID 
			 JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
			 WHERE OrgHierarchyParentID = @pvOrganizationID )

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

