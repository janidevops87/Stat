SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_MessageImportOrganizations]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_MessageImportOrganizations]
GO






/****** Object:  Stored Procedure dbo.sps_MessageImportOrganizations    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_MessageImportOrganizations	
	@sourceCode varchar(10) = null,
	@sourceCodeType int = null,
	@organizationID int  = null
AS
/******************************************************************************
**		File: sps_MessageImportOrganizations.sql
**		Name: sps_MessageImportOrganizations
**		Desc: gets list of organizations in a sourcecode
**
**		Called by:   Message and Import paramter pages
**              
**
**		Auth: Bret Knoll
**		Date: 7/30/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		7/30/08		Bret Knoll			initial
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @sourceCodeList TABLE
	(
		ID INT IDENTITY(1, 1),
		SourceCodeID INT
	)

INSERT @sourceCodeList
SELECT     SourceCode.SourceCodeID
FROM         WebReportGroupSourceCode INNER JOIN
                      SourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID INNER JOIN
                      WebReportGroup ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID
WHERE     (SourceCode.SourceCodeType = ISNULL(@sourceCodeType, SourceCode.SourceCodeType)) AND (WebReportGroup.OrgHierarchyParentID = case when @organizationID = 194 then WebReportGroup.OrgHierarchyParentID else @organizationID end )

SELECT     OrganizationID, OrganizationName
FROM         Organization
WHERE     (OrganizationID IN (SELECT     SourceCodeOrganization.OrganizationID
                              FROM         SourceCodeOrganization 
                              INNER JOIN
                                    SourceCode ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID
                              WHERE     
									(SourceCodeOrganization.SourceCodeID IN (SELECT SourceCodeID FROM @sourceCodeList)) 
								AND (SourceCode.SourceCodeName = ISNULL(@sourceCode, SourceCode.SourceCodeName)) 
								AND (SourceCode.SourceCodeType = ISNULL(@sourceCodeType, SourceCode.SourceCodeType))))
ORDER BY Organization.OrganizationName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 