IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_Audit_WebPerson')
	BEGIN
		PRINT 'Dropping Procedure spi_Audit_WebPerson'
		DROP  Procedure  spi_Audit_WebPerson
	END

GO

PRINT 'Creating Procedure spi_Audit_WebPerson'
GO
CREATE Procedure spi_Audit_WebPerson
	@1 int , -- WebPersonID
	@2 varchar(15) , -- WebPersonUserName
	@3 int , -- PersonID
	@4 varchar(20) , -- WebPersonPassword
	@5 int , -- UnusedField1
	@6 datetime , -- LastModified
	@7 int , -- WebPersonSessionCounter
	@8 int , -- UnusedField2
	@9 smalldatetime , -- WebPersonLastSessionAccess
	@10 varchar(100) , -- WebPersonEmail
	@11 smallint , -- UpdatedFlag
	@12 varchar(100) , -- WebPersonUserAgent
	@13 int , -- Access
	@14 int , -- LastStatEmployeeID
	@15 INT , -- AuditLogTypeID
	@16 varchar(100) , -- SaltValue
	@17 varchar(50)  -- HashedPassword
AS

/******************************************************************************
**		File: 
**		Name: spi_Audit_WebPerson
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
**		06/22/2018	Ilya Osipov			Added SaltValue and HashedPassword
*******************************************************************************/

INSERT 
	WebPerson 
	( 
		WebPersonID,
		WebPersonUserName,
		PersonID,
		WebPersonPassword,
		UnusedField1,
		LastModified,
		WebPersonSessionCounter,
		UnusedField2,
		WebPersonLastSessionAccess,
		WebPersonEmail,
		UpdatedFlag,
		WebPersonUserAgent,
		Access,
		LastStatEmployeeID,
		AuditLogTypeID,
		SaltValue,
		HashedPassword
	) 
VALUES 
	( 
		@1, -- WebPersonID
		@2, -- WebPersonUserName
		@3, -- PersonID
		@4, -- WebPersonPassword
		@5, -- UnusedField1
		@6, -- LastModified
		@7, -- WebPersonSessionCounter
		@8, -- UnusedField2
		@9, -- WebPersonLastSessionAccess
		@10, -- WebPersonEmail
		@11, -- UpdatedFlag
		@12, -- WebPersonUserAgent
		@13, -- Access
		@14, -- LastStatEmployeeID
		@15, -- AuditLogTypeID
		@16, -- SaltValue	
		@17 -- HashedPassword	
	) 



GO

GRANT EXEC ON spi_Audit_WebPerson TO PUBLIC

GO
