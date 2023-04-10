IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetScheduledPersonList')
	BEGIN
		PRINT 'Dropping Procedure GetScheduledPersonList'
		DROP  Procedure  GetScheduledPersonList
	END

GO

PRINT 'Creating Procedure GetScheduledPersonList'
GO 

CREATE PROCEDURE GetScheduledPersonList
	@OrganizationId	 INT = NULL,
	@ScheduleGroupID INT = NULL
AS
/******************************************************************************
**		File: GetScheduledPersonList.sql
**		Name: GetScheduledPersonList
**		Desc: Returns a list of Scheduled People by OrganizationID and Org GroupID
**
** 
**		Called by:   ScheduleSearchControl.ascx
**              
**
**		Auth: jth
**		Date: 08/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		8/08		jth				initial
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT DISTINCT ScheduleGroupPerson.PersonID, Person.PersonFirst + ' ' + Person.PersonLast AS Name
FROM         ScheduleGroupPerson INNER JOIN
                      Person ON Person.PersonID = ScheduleGroupPerson.PersonID INNER JOIN
                      Organization ON Person.OrganizationID = Organization.OrganizationID
WHERE     (Person.OrganizationID = @OrganizationId) AND (ScheduleGroupPerson.ScheduleGroupID = @ScheduleGroupID)
ORDER BY Person.PersonFirst + ' ' + Person.PersonLast

GO
 