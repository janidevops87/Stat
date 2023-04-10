IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'UpdateWebPerson')
	BEGIN
		PRINT 'Dropping Procedure UpdateWebPerson'
		DROP  Procedure  UpdateWebPerson
	END

GO

PRINT 'Creating Procedure UpdateWebPerson'
GO
CREATE Procedure UpdateWebPerson
	@WebPersonID int, 
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
	@AuditLogTypeID INT = NULL,
	@SaltValue  VARCHAR(100) = NULL , 
	@HashedPassword varchar(100) = NULL 
AS

/******************************************************************************
**		File: UpdateWebPerson.sql
**		Name: UpdateWebPerson
**		Desc: 
**
**              
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
**	07/11/2018		Ilya Osipov			Removed WebPersonPassword from the code
*******************************************************************************/

UPDATE 
	WebPerson 
SET 
	WebPersonUserName = @WebPersonUserName,  
	UnusedField1 = ISNULL(@UnusedField1, UnusedField1), 
	LastModified = GETDATE(), 
	WebPersonSessionCounter = ISNULL(@WebPersonSessionCounter, WebPersonSessionCounter), 
	UnusedField2 = ISNULL(@UnusedField2, UnusedField2), 
	WebPersonLastSessionAccess = ISNULL(@WebPersonLastSessionAccess, WebPersonLastSessionAccess), 
	WebPersonEmail = @WebPersonEmail,  
	WebPersonUserAgent = @WebPersonUserAgent,  
	Access = ISNULL(@Access, Access), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3 ), -- 3 Review  
	SaltValue = @SaltValue,  
	HashedPassword = @HashedPassword
WHERE 
	WebPersonID = @WebPersonID



GO

GRANT EXEC ON UpdateWebPerson TO PUBLIC

GO
