IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPersonByWebPersonId')
	BEGIN
		PRINT 'Dropping Procedure GetPersonByWebPersonId'
		DROP  Procedure  GetPersonByWebPersonId
	END

GO

PRINT 'Creating Procedure GetPersonByWebPersonId'
GO
CREATE Procedure GetPersonByWebPersonId
	@WebPersonID INT
AS

/******************************************************************************
**		File: GetPersonByWebPersonId.sql
**		Name: GetPersonByWebPersonId
**		Desc: retrieves Person Information
**
**		Called by:   
**              Statline.StatTrac.Web.UI.UserAdminEditControl.ascx
**
**		Auth: Bret Knoll
**		Date: 1/26/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		1/26/08		Bret Knoll			Reporting Site Admin functionality
*******************************************************************************/

SELECT
	PersonID, 
	PersonFirst, 
	PersonMI, 
	PersonLast, 
	PersonTypeID, 
	OrganizationID, 
	PersonNotes,	
	PersonBusy, 
	Verified, 
	Inactive, 	
	PersonBusyUntil, 
	PersonTempNoteActive, 
	PersonTempNoteExpires, 
	PersonTempNote, 
	Unused,
	AllowInternetScheduleAccess,
	PersonSecurity, 
	PersonArchive
FROM         
	Person
WHERE     
	(PersonID = (
	SELECT     PersonID
	FROM         WebPerson
	WHERE     (WebPersonID = @WebPersonID))
	)
	
	

GO

GRANT EXEC ON GetPersonByWebPersonId TO PUBLIC

GO
