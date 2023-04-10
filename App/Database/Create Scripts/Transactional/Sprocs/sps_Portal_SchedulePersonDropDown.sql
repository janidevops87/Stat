IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_Portal_SchedulePersonDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_Portal_SchedulePersonDropDown'
		DROP  Procedure  sps_Portal_SchedulePersonDropDown
	END

GO

PRINT 'Creating Procedure sps_Portal_SchedulePersonDropDown'
GO 

CREATE PROCEDURE sps_Portal_SchedulePersonDropDown
	@OrganizationId	 INT,
	@ScheduleGroupID INT
AS
/******************************************************************************
**		File: sps_Portal_SchedulePersonDropDown.sql
**		Name: sps_Portal_SchedulePersonDropDown
**		Desc: Returns a list of Scheduled People by OrganizationID and Org GroupID
**
** 
**		Called by:   Report Portal site
**              
**
**		Auth: Pam Scheichenost
**		Date: 02/18/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		02/18/2021	Pam Scheichenost	initial
*******************************************************************************/


SELECT DISTINCT 
ScheduleGroupPerson.PersonID AS [value], 
	Person.PersonFirst + ' ' + Person.PersonLast AS [label]
FROM ScheduleGroupPerson 
INNER JOIN Person ON Person.PersonID = ScheduleGroupPerson.PersonID 
INNER JOIN Organization ON Person.OrganizationID = Organization.OrganizationID
WHERE     
	(Person.OrganizationID = @OrganizationId) AND Person.Inactive<>1
AND (ScheduleGroupPerson.ScheduleGroupID = @ScheduleGroupID)
ORDER BY Person.PersonFirst + ' ' + Person.PersonLast;

GO
 