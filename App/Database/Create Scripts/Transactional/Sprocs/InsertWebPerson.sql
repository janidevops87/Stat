IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'InsertWebPerson')
	BEGIN
		PRINT 'Dropping Procedure InsertWebPerson'
		DROP  Procedure  InsertWebPerson
	END

GO

PRINT 'Creating Procedure InsertWebPerson'
GO
CREATE Procedure InsertWebPerson
	@WebPersonID int = NULL , 
	@WebPersonUserName varchar(15) = NULL , 
	@PersonID int = NULL , 
	@UnusedField1 int = NULL , 
	@WebPersonSessionCounter int = NULL , 
	@UnusedField2 int = NULL , 
	@WebPersonLastSessionAccess smalldatetime = NULL , 
	@WebPersonEmail varchar(100) = NULL , 	
	@WebPersonUserAgent varchar(100) = NULL , 
	@Access int = NULL , 
	@LastStatEmployeeID int , 
	@AuditLogTypeID int = NULL ,
	@SaltValue  VARCHAR(100) = NULL , 
	@HashedPassword varchar(100) = NULL 
AS

/******************************************************************************
**		File: InsertWebPerson.sql
**		Name: InsertWebPerson
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
**
**		Auth: Bret Knoll	
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
**		29/05/2007	Ilya Osipov			Added SaltValue and HashedPasswords columns
**		07/11/2018		Ilya Osipov			Removed WebPersonPassword from the code
*******************************************************************************/

INSERT 
	WebPerson 
	(
	WebPersonUserName,
	PersonID,
	UnusedField1,
	LastModified,
	WebPersonSessionCounter,
	UnusedField2,
	WebPersonLastSessionAccess,
	WebPersonEmail,	
	WebPersonUserAgent,
	Access,
	LastStatEmployeeID,
	AuditLogTypeID,
	SaltValue,
	HashedPassword 
	) 
VALUES 
	( 
	@WebPersonUserName, 
	@PersonID, 
	@UnusedField1, 
	GETDATE(), 
	@WebPersonSessionCounter, 
	@UnusedField2, 
	@WebPersonLastSessionAccess, 
	@WebPersonEmail, 	
	@WebPersonUserAgent, 
	ISNULL(@Access, 0), 
	@LastStatEmployeeID, 
	ISNULL(@AuditLogTypeID, 1 ), -- 1 Create
	@SaltValue,
	@HashedPassword
	) 

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
	Access,
	SaltValue,
	HashedPassword 
FROM 
	WebPerson 
WHERE 
	WebPersonID = SCOPE_IDENTITY()


GO

GRANT EXEC ON InsertWebPerson TO PUBLIC

GO
