 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetWebPersonByWebPersonId')
	BEGIN
		PRINT 'Dropping Procedure GetWebPersonByWebPersonId'
		DROP  Procedure  GetWebPersonByWebPersonId
	END

GO

PRINT 'Creating Procedure GetWebPersonByWebPersonId'
GO
CREATE Procedure GetWebPersonByWebPersonId
	@WebPersonID INT
AS

/******************************************************************************
**		File: GetWebPersonByWebPersonId.sql
**		Name: GetWebPersonByWebPersonId
**		Desc: retrieves webPerson Information
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
**		05/18/2011	ccarroll			Added IsNull for WebPersonPassword
**		07/11/2018	Ilya Osipov			Removed WebPersonPassword from the code
*******************************************************************************/

SELECT     
	WebPersonID, 
	WebPersonUserName, 
	PersonID, 
	UnusedField1,
	WebPersonSessionCounter, 
	UnusedField2,
	WebPersonLastSessionAccess, 
	WebPersonEmail, 
	WebPersonUserAgent, 
	Access
FROM         
	WebPerson
WHERE     
	(WebPersonID = @WebPersonID)


GO

GRANT EXEC ON GetWebPersonByWebPersonId TO PUBLIC

GO
