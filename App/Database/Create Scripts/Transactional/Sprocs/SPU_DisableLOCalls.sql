SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPU_DisableLOCalls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPU_DisableLOCalls]
GO


CREATE PROCEDURE SPU_DisableLOCalls
	
	@pvOrganizationID int
	 
	

AS 

Declare @pvUpdateValue int





Set @pvUpdateValue = 0
--'Enable / Disable LO Calls
UPDATE Organization
SET OrganizationLOEnabled =@pvUpdateValue
WHERE OrganizationID = @pvOrganizationID

-- Enable / Disable Line Checks

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

