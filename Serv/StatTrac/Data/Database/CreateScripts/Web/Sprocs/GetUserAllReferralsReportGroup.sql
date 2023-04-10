IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetUserAllReferralsReportGroup')
	BEGIN
		PRINT 'Dropping Procedure GetUserAllReferralsReportGroup'
		DROP  Procedure  GetUserAllReferralsReportGroup
	END

GO

PRINT 'Creating Procedure GetUserAllReferralsReportGroup'
GO
CREATE Procedure GetUserAllReferralsReportGroup
	@OrganizationID	INT,
	@WebReportGroupID INT OUTPUT
AS

/******************************************************************************
**		File: 
**		Name: GetUserAllReferralsReportGroup
**		Desc: 
**			Obtains users All Referrals Report Group
**              
**		Return values:
**			WebReportGroupID
**
**		Called by:   
**			UserAdminControl.ascx              
**
**		Auth: Bret Knoll
**		Date: 11/27/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------
**		11/27/07	Bret Knoll			Initial
*******************************************************************************/

	SELECT TOP 1
	   	@WebReportGroupID = WebReportGroupID
	FROM         
		WebReportGroup
	WHERE     	
		(OrgHierarchyParentID = @OrganizationID) 
	AND 
		(WebReportGroupName LIKE '%All Referrals%')


GO

GRANT EXEC ON GetUserAllReferralsReportGroup TO PUBLIC

GO
