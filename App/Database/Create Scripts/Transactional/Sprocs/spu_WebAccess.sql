
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spu_WebAccess')
	BEGIN
		PRINT 'Dropping Procedure spu_WebAccess'
		DROP Procedure spu_WebAccess
	END

PRINT 'Creating Procedure spu_WebAccess'
GO

CREATE Procedure spu_WebAccess
(
		@vWebUserID 			int	= null,
		@vWebPersonUserAgent	varchar(100)	= null
)
AS
/******************************************************************************
**	File: spu_WebAccess.sql
**	Name: spu_WebAccess
**	Desc: Updates web user session counter
**	Auth: ccarroll
**	Date: 04/27/2011
**	Called By: Called on web login
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	02/24/1999		unknown				Initial Sproc Creation
**	04/27/2011		ccarroll			Added @StatEmployeeID for audit trail
**	05/31/2011		bret				Changed Statemployee to Left Join added Coalesce
**	07/06/2018		iosipov				Added SaltValue and HashedPassword
**	07/11/2018		Ilya Osipov			Removed WebPersonPassword from the code
*******************************************************************************/
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


DECLARE

    	@vSessionCount	int,
    	@accessDT	datetime,
    	@webPersonUserName varchar(15),
		@webPersonEmail varchar(100),
		@saltValue varchar(100),
		@hashedPassword varchar(100),
		@webPersonPassword varchar(20),
		@statEmployeeID INT

SELECT	
	@vSessionCount = WebPerson.WebPersonSessionCounter + 1,
	@accessDT = GETDATE(),
	@webPersonUserName = WebPersonUserName,
	@webPersonEmail = WebPersonEmail,
	@statEmployeeID = COALESCE(StatEmployeeID, 888), -- OnlineReferral
	@saltValue = SaltValue,
	@hashedPassword = HashedPassword
FROM 		
	WebPerson
	LEFT JOIN StatEmployee ON StatEmployee.PersonID = WebPerson.PersonID
WHERE 	
	WebPersonID = @vWebUserID

	
	EXEC UpdateWebPerson
		@WebPersonUserName = @webPersonUserName,	
		@WebPersonEmail = @webPersonEmail,
		@WebPersonSessionCounter = @vSessionCount,
		@WebPersonLastSessionAccess = @accessDT,
		@WebPersonUserAgent = @vWebPersonUserAgent,
		@LastStatEmployeeID = @statEmployeeID,
		@AuditLogTypeID = 2, -- modify
		@WebPersonID = @vWebUserID,
		@SaltValue = @saltValue,
		@HashedPassword = @hashedPassword


GO
