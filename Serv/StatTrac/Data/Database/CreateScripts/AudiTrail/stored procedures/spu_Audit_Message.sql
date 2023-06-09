SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_Message]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_Message'
		DROP procedure [dbo].[spu_Audit_Message]
	END
GO

	PRINT 'Creating Procedure spu_Audit_Message'
GO

create procedure "spu_Audit_Message" 
	@c1 int,
	@c2 int,
	@c3 varchar(80),
	@c4 varchar(20),
	@c5 varchar(80),
	@c6 int,
	@c7 int,
	@c8 int,
	@c9 smallint,
	@c10 varchar(1000),
	@c11 smallint,
	@c12 datetime,
	@c13 numeric(5,0),
	@c14 varchar(50),
	@c15 varchar(20),
	@c16 varchar(5),
	@c17 smallint,
	@c18 int,
	@c19 int,
	@pkc1 int,
	@bitmap binary(3)
AS
/******************************************************************************
**		File: spu_Audit_Message.sql
**		Name: spu_Audit_Message
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Bret Knoll	
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------------
**		11/12/2007	Bret Knoll		initial
**		05/15/2008	ccarroll		Added CASE statement for ILB insert values
**		04/29/2014	ccarroll		increased MessageDescription param to 1000 CCRST197 wi: 14835
*******************************************************************************/

	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int,
		@callID int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- MessageID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallID
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- MessageCallerName
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- MessageCallerPhone
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- MessageCallerOrganization
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- OrganizationID
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- PersonID
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- MessageTypeID
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- MessageUrgent
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- MessageDescription
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- Inactive
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- LastModified
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- MessageExtension
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- MessageImportPatient
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- MessageImportUNOSID
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- MessageImportCenter
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- UpdatedFlag
		AND SUBSTRING(@bitmap, 3, 1) & 2 = 2 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- AuditLogTypeID

	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c19, 3), --3 Modify Was last auditLogTypeID
		@callID = CallID
	FROM
		Message
	WHERE 
		MessageID = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a Review, Modify or Delete
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- MessageID
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallID
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- MessageCallerName
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- MessageCallerPhone
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- MessageCallerOrganization
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- OrganizationID
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- PersonID
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- MessageTypeID
	AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- MessageUrgent
	AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- MessageDescription
	AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- Inactive
	AND SUBSTRING(@bitmap, 2, 1) & 8 = 8 -- LastModified
	AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- MessageExtension
	AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- MessageImportPatient
	AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- MessageImportUNOSID
	AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- MessageImportCenter
	AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- UpdatedFlag
	--AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- LastStatEmployeeID
	--AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- AuditLogTypeID
	AND IsNull(@auditLogTypeID, 2) IN (2, 3, 4) --Review, Modify, Delete	
	)
BEGIN

	IF 	@auditLogTypeID <> 4 --Deleted
		BEGIN
			SET @auditLogTypeID = 2	-- Review
		END
	ELSE
		BEGIN
			SET @auditLogTypeID = 4	-- Deleted
		END
END



insert into 
	"Message"
	( 
		"MessageID", -- c1
		"CallID", -- c2
		"MessageCallerName", -- c3
		"MessageCallerPhone", -- c4
		"MessageCallerOrganization", -- c5
		"OrganizationID", -- c6
		"PersonID", -- c7
		"MessageTypeID",  -- c8
		"MessageUrgent", -- c9
		"MessageDescription", -- c10
		"Inactive", -- c11
		"LastModified", -- c12
		"MessageExtension", -- c13
		"MessageImportPatient", -- c14
		"MessageImportUNOSID", -- c15
		"MessageImportCenter", -- c16
		"UpdatedFlag", -- c17
		"LastStatEmployeeID", -- c18
		"AuditLogTypeID"  -- c19
	)
				 
values 
	( 
		@pkc1,
		@callID,
		CASE WHEN /*MessageCallerName*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, '') = '' THEN 'ILB' ELSE @c3 END,
		CASE WHEN /*MessageCallerPhone*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN 'ILB' ELSE @c4 END,
		CASE WHEN /*MessageCallerOrganization*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, '') = '' THEN 'ILB' ELSE @c5 END,
		CASE WHEN /*OrganizationID*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, -1) IN ( -1, 0) THEN -2 ELSE @c6 END,
		CASE WHEN /*PersonID*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, -1) IN ( -1, 0) THEN -2 ELSE @c7 END,
		CASE WHEN /*MessageTypeID*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, -1) IN ( -1, 0) THEN -2 ELSE @c8 END,
		CASE WHEN /*MessageUrgent*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 THEN @c9 END, --do not show ILB
		CASE WHEN /*MessageDescription*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@c10, '') = '' THEN 'ILB' ELSE @c10 END,
		CASE WHEN /*Inactive*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 AND IsNull(@c11, -1) IN ( -1, 0) THEN -2 ELSE @c11 END,
		ISNULL(@c12, @lastModified), 
		CASE WHEN /*MessageExtension*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 AND IsNull(@c13, -1) IN ( -1, 0) THEN -2 ELSE @c13 END,
		CASE WHEN /*MessageImportPatient*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 AND IsNull(@c14, '') = '' THEN 'ILB' ELSE @c14 END,
		CASE WHEN /*MessageImportUNOSID*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@c15, '') = '' THEN 'ILB' ELSE @c15 END,
		CASE WHEN /*MessageImportCenter*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 AND IsNull(@c16, '') = '' THEN 'ILB' ELSE @c16 END,
		CASE WHEN /*UpdatedFlag*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 AND IsNull(@c17, -1) IN ( -1, 0) THEN -2 ELSE @c17 END,
		ISNULL(@c18, @LastStatEmployeeID),
		@auditLogTypeID
	)

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

