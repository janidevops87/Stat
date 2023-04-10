IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportMessageImportOrganizationsDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportMessageImportOrganizationsDropDown';
		DROP Procedure sps_ReportMessageImportOrganizationsDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportMessageImportOrganizationsDropDown';
GO


CREATE PROCEDURE [dbo].[sps_ReportMessageImportOrganizationsDropDown]	
	@SourceCodeName varchar(10) = null,
	@SourceCodeTypeId int = null,
	@OrganizationId int  = null
AS
 /******************************************************************************
**	File: sps_ReportMessageImportOrganizationsDropDown.sql
**	Name: sps_ReportMessageImportOrganizationsDropDown
**	Desc: Populates dropdown for message for organization dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 12/02/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	12/02/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @sourceCodeList TABLE
	(
		ID INT IDENTITY(1, 1),
		SourceCodeID INT
	);

INSERT @sourceCodeList
SELECT     SourceCode.SourceCodeID
FROM         WebReportGroupSourceCode INNER JOIN
                      SourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID INNER JOIN
                      WebReportGroup ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID
WHERE     (SourceCode.SourceCodeType = ISNULL(@SourceCodeTypeId, SourceCode.SourceCodeType)) AND (WebReportGroup.OrgHierarchyParentID = case when @OrganizationId = 194 then WebReportGroup.OrgHierarchyParentID else @OrganizationId end );

SELECT     OrganizationID as [value], 
			OrganizationName as [label]
FROM         Organization
WHERE     (OrganizationID IN (SELECT     SourceCodeOrganization.OrganizationID
                              FROM         SourceCodeOrganization 
                              INNER JOIN
                                    SourceCode ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID
                              WHERE     
									(SourceCodeOrganization.SourceCodeID IN (SELECT SourceCodeID FROM @sourceCodeList)) 
								AND (SourceCode.SourceCodeName = ISNULL(@SourceCodeName, SourceCode.SourceCodeName)) 
								AND (SourceCode.SourceCodeType = ISNULL(@SourceCodeTypeId, SourceCode.SourceCodeType))))
ORDER BY Organization.OrganizationName;


GO

GRANT EXEC ON sps_ReportMessageImportOrganizationsDropDown TO PUBLIC;
GO

