IF  EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_GetStatInfoReportWebGroups]') AND xtype IN (N'FN', N'IF', N'TF'))
BEGIN
	PRINT 'Dropping Function fn_GetStatInfoReportWebGroups';
	DROP FUNCTION fn_GetStatInfoReportWebGroups;
END
GO

PRINT 'Creating Function fn_GetStatInfoReportWebGroups';
GO


CREATE FUNCTION [dbo].[fn_GetStatInfoReportWebGroups]
	(
		@UserName VARCHAR(50)
	)
RETURNS @ReportGroupTable TABLE
	(
		SourceCodeID INT,
		OrgID INT
	) 		
AS

/******************************************************************************
**		File: 
**		Name: dbo.fn_GetStatInfoReportWebGroups
**		Desc: 
**
**		This function provides a list of report groups after a user id is passed in
**		Called by:  
** 
**      Statinfo web service...update sprocs      
**
**		Auth: jth
**		Date: 7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**    
*******************************************************************************/
BEGIN

	INSERT @ReportGroupTable
	SELECT distinct
        WebReportGroupSourceCode.SourceCodeID,
        WebReportGroupOrg.OrganizationID
    FROM  
        WebReportGroupOrg
        INNER JOIN WebReportGroup ON WebReportGroupOrg.WebReportGroupID = WebReportGroup.WebReportGroupID
        INNER JOIN WebReportGroupSourceCode ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
        INNER JOIN Person ON Person.organizationID = WebReportGroup.OrgHierarchyParentID
        INNER JOIN WebPerson ON WebPerson.PersonID = Person.PersonID
        LEFT JOIN Organization on person.OrganizationID = Organization.OrganizationID
        LEFT JOIN (
                    SELECT OrgHierarchyParentID 
                    FROM WebReportGroup 
                    WHERE PATINDEX('DTStatTrac%' , WebReportGroup.WebReportGroupName) > 0 
                ) dtstattrac ON WebReportGroup.OrgHierarchyParentID = dtstattrac.OrgHierarchyParentID
        WHERE  
            WebPerson.WebPersonUserName = @UserName
        AND
        (
            (
                WebReportGroup.WebReportGroupName = 'All Referrals' 
                AND  dtstattrac.OrgHierarchyParentID IS NULL
            )
            OR
            (
                PATINDEX('DTStatTrac%' , WebReportGroup.WebReportGroupName) > 0
            )
        )
	RETURN;	

END      
		
GO
SET QUOTED_IDENTIFIER OFF; 
GO
SET ANSI_NULLS ON;
GO

