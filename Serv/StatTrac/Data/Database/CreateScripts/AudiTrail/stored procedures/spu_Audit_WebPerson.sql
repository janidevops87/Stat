IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spu_Audit_WebPerson')
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_WebPerson'
		DROP  Procedure  spu_Audit_WebPerson
	END

GO

PRINT 'Creating Procedure spu_Audit_WebPerson'
GO
CREATE Procedure spu_Audit_WebPerson
	@c1 int, -- WebPersonID
	@c2 varchar(15), -- WebPersonUserName
	@c3 int, -- PersonID
	@c4 varchar(20), -- WebPersonPassword
	@c5 int, -- UnusedField1
	@c6 datetime, -- LastModified
	@c7 int, -- WebPersonSessionCounter
	@c8 int, -- UnusedField2
	@c9 smalldatetime, -- WebPersonLastSessionAccess
	@c10 varchar(100), -- WebPersonEmail
	@c11 smallint, -- UpdatedFlag
	@c12 varchar(100), -- WebPersonUserAgent
	@c13 int, -- Access
	@c14 int, -- LastStatEmployeeID
	@c15 int, -- AuditLogTypeID
	@c16  varchar(100) , -- SaltValue
	@c17  varchar(50),  -- HashedPassword
	@pkc1 int, 
	@bitmap binary(3)

AS

/******************************************************************************
**		File: spu_Audit_WebPerson.sql
**		Name: spu_Audit_WebPerson
**		Desc: 
**
**		This template can be customized:
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
	DECLARE 
		@lastModified datetime,
		@lastStatEmployeeID int,
		@auditLogTypeID int

IF (
	SUBSTRING(@bitmap, 1, 1) & 1 = 1 -- WebPersonID
	OR SUBSTRING(@bitmap, 1, 1) & 2 = 2 -- WebPersonUserName
	OR SUBSTRING(@bitmap, 1, 1) & 4 = 4 -- PersonID
	OR SUBSTRING(@bitmap, 1, 1) & 8 = 8 -- WebPersonPassword
	OR SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- UnusedField1
	-- IGNORE OR SUBSTRING(@bitmap, 1, 1) & 32 = 32 -- LastModified
	OR SUBSTRING(@bitmap, 1, 1) & 64 = 64 -- WebPersonSessionCounter
	OR SUBSTRING(@bitmap, 1, 1) & 128 = 128 -- UnusedField2
	OR SUBSTRING(@bitmap, 2, 1) & 1 = 1 -- WebPersonLastSessionAccess
	OR SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- WebPersonEmail
	OR SUBSTRING(@bitmap, 2, 1) & 4 = 4 -- UpdatedFlag
	OR SUBSTRING(@bitmap, 2, 1) & 8 = 8 -- WebPersonUserAgent
	OR SUBSTRING(@bitmap, 2, 1) & 16 = 16 -- Access
	OR SUBSTRING(@bitmap, 2, 1) & 32 = 32 -- LastStatEmployeeID
	OR SUBSTRING(@bitmap, 2, 1) & 64 = 64 -- AuditLogTypeID
	OR SUBSTRING(@bitmap, 3, 1) & 128 = 128 -- SaltValue
	OR SUBSTRING(@bitmap, 3, 1) & 1 = 1 -- HashedPassword
	)
BEGIN
	-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(LastModified, GetDate()),
		@lastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c15, AuditLogTypeID)
	FROM
		WebPerson
	WHERE 
		WebPersonID = @pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
	IF
		(
			(
			SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- WebPersonID
			AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- WebPersonUserName
			AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- PersonID
			AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- WebPersonPassword
			AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- UnusedField1
			AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- WebPersonSessionCounter
			AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- UnusedField2
			AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- WebPersonLastSessionAccess
			AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- WebPersonEmail
			AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- UpdatedFlag
			AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- WebPersonUserAgent
			AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- Access
			AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- SaltValue
			AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- HashedPassword
			)			
			AND SUBSTRING(@bitmap, 1, 1) & 32 = 32 -- LastModified
		)
	BEGIN
		SET @auditLogTypeID = 2	-- Review
	END
	ELSE
	BEGIN
		SET @auditLogTypeID = 3	-- Modify
	END
	
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
			@pkc1, -- WebPersonID
			CASE WHEN /*WebPersonUserName*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, '') = '' THEN 'ILB' ELSE @c2 END,
			CASE WHEN /*PersonID*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, -1) IN ( -1, 0) THEN -2 ELSE @c3 END,
			CASE WHEN /*WebPersonPassword*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN 'ILB' ELSE @c4 END,
			CASE WHEN /*UnusedField1*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, -1) IN ( -1, 0) THEN -2 ELSE @c5 END,
			ISNULL(@c6, @lastModified), -- LastModified
			CASE WHEN /*WebPersonSessionCounter*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, -1) IN ( -1, 0) THEN -2 ELSE @c7 END,
			CASE WHEN /*UnusedField2*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, -1) IN ( -1, 0) THEN -2 ELSE @c8 END,
			CASE WHEN /*WebPersonLastSessionAccess*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@c9, '') = '' THEN '01/01/1900' ELSE @c9 END,
			CASE WHEN /*WebPersonEmail*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@c10, '') = '' THEN 'ILB' ELSE @c10 END,
			CASE WHEN /*UpdatedFlag*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 AND IsNull(@c11, -1) IN ( -1, 0) THEN -2 ELSE @c11 END,
			CASE WHEN /*WebPersonUserAgent*/ SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@c12, '') = '' THEN 'ILB' ELSE @c12 END,
			CASE WHEN /*Access*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 AND IsNull(@c13, -1) IN ( -1, 0) THEN -2 ELSE @c13 END,
			CASE WHEN /*SaltValue*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 AND ISNULL(@c16, '') = '' THEN 'ILB' ELSE @c16 END,
			CASE WHEN /*HashedPassword*/ SUBSTRING(@bitmap, 3, 1) & 2 = 2 AND IsNull(@c17,  '') = '' THEN 'ILB' ELSE @c17 END,
			ISNULL(@c14, @lastStatEmployeeID), -- LastStatEmployeeID
			@auditLogTypeID -- AuditLogTypeID
		) 
	
END


GO

GRANT EXEC ON spu_Audit_WebPerson TO PUBLIC

GO
