SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_LogEvent]') and OBJECTPROPERTY(id,
	N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_LogEvent'
		DROP procedure [dbo].[spu_Audit_LogEvent]
	END
GO

	PRINT 'Creating Procedure spu_Audit_LogEvent'
GO


create procedure "spu_Audit_LogEvent" 
	@c1 int,
	@c2 int,
	@c3 int,
	@c4 smalldatetime,
	@c5 int,
	@c6 varchar(50),
	@c7 varchar(100),
	@c8 varchar(80),
	@c9 varchar(1000),
	@c10 int,
	@c11 smallint,
	@c12 datetime,
	@c13 int,
	@c14 int,
	@c15 int,
	@c16 int,
	@c17 smallint,
	@c18 smallint,
	@c19 smalldatetime,
	@c20 int,
	@c21 int,
	@c22 bit,
	@pkc1 int,
	@bitmap binary(3)
AS
/******************************************************************************
**		File: spu_Audit_LogEvent.sql
**		Name: spu_Audit_LogEvent
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
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
**		05/15/2008	ccarroll			Added CASE statement for ILB insert values
*******************************************************************************/
	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int,
		@callID int,
		@logEventNumber int
IF NOT (
		--	SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- LogEventID
		-- AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallID
		SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- LogEventTypeID
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- LogEventDateTime
		-- AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- LogEventNumber
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- LogEventName
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- LogEventPhone
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- LogEventOrg
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- LogEventDesc
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- StatEmployeeID
		-- AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- LogEventCallbackPending
		-- AND SUBSTRING(@bitmap, 2, 1) & 8 = 8 -- LastModified
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- ScheduleGroupID
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- PersonID
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- OrganizationID
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- PhoneID
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- LogEventContactConfirmed
		AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- UpdatedFlag
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- LogEventCalloutDateTime
		-- AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- LastStatEmployeeID
		-- AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- AuditLogTypeID
		-- AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- LogEventDeleted
	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c21, AuditLogTypeID),
		@callID = CallID,
		@logEventNumber = LogEventNumber

	FROM
		LogEvent
	WHERE 
		LogEventID = 	@pkc1
	ORDER BY
		LastModified DESC	


	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- LogEventID
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallID
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- LogEventTypeID
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- LogEventDateTime
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- LogEventNumber
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- LogEventName
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- LogEventPhone
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- LogEventOrg
	AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- LogEventDesc
	AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- StatEmployeeID
	AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- LogEventCallbackPending
	AND SUBSTRING(@bitmap, 2, 1) & 8 = 8 -- LastModified
	AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- ScheduleGroupID
	AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- PersonID
	AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- OrganizationID
	AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- PhoneID
	AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- LogEventContactConfirmed
	AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- UpdatedFlag
	AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- LogEventCalloutDateTime
	--AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- LastStatEmployeeID
	--AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- AuditLogTypeID
	AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- LogEventDeleted
	AND @auditLogTypeID = 3	
	)
BEGIN
		SET @auditLogTypeID = 2	-- Review
END

		
insert into "LogEvent"
	( 
	"LogEventID", -- c1
	"CallID", -- c2
	"LogEventTypeID", -- c3
	"LogEventDateTime", -- c4
	"LogEventNumber", -- c5
	"LogEventName", -- c6
	"LogEventPhone", -- c7
	"LogEventOrg", -- c8
	"LogEventDesc", -- c9
	"StatEmployeeID", -- c10
	"LogEventCallbackPending", -- c11
	"LastModified", -- c12
	"ScheduleGroupID", -- c13
	"PersonID", -- c14
	"OrganizationID", -- c15
	"PhoneID", -- c16
	"LogEventContactConfirmed", -- c17
	"UpdatedFlag", -- c18
	"LogEventCalloutDateTime", -- c19
	"LastStatEmployeeID", -- c20
	"AuditLogTypeID", -- c21	
	"LogEventDeleted" -- c22
	)
		 
values	
	( 
	@pkc1,
	@callID,
	CASE WHEN /*LogEventTypeID*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, -1) IN ( -1, 0) THEN -2 ELSE @c3 END,
	CASE WHEN /*LogEventDateTime*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN '01/01/1900' ELSE @c4 END,
	isnull(@c5, @logEventNumber),
	CASE WHEN /*LogEventName*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, '') = '' THEN 'ILB' ELSE @c6 END,
	CASE WHEN /*LogEventPhone*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, '') = '' THEN 'ILB' ELSE @c7 END,
	CASE WHEN /*LogEventOrg*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, '') = '' THEN 'ILB' ELSE @c8 END,
	CASE WHEN /*LogEventDesc*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@c9, '') = '' THEN 'ILB' ELSE @c9 END,
	CASE WHEN /*StatEmployeeID*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@c10, -1) IN ( -1, 0) THEN -2 ELSE @c10 END,
	CASE WHEN /*LogEventCallbackPending*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 THEN @c11 END, --do not show ILB
	ISNULL(@c12, @lastModified),
	CASE WHEN /*ScheduleGroupID*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 AND IsNull(@c13, -1) IN ( -1, 0) THEN -2 ELSE @c13 END,
	CASE WHEN /*PersonID*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 AND IsNull(@c14, -1) IN ( -1, 0) THEN -2 ELSE @c14 END,
	CASE WHEN /*OrganizationID*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@c15, -1) IN ( -1, 0) THEN -2 ELSE @c15 END,
	CASE WHEN /*PhoneID*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 AND IsNull(@c16, -1) IN ( -1, 0) THEN -2 ELSE @c16 END,
	CASE WHEN /*LogEventContactConfirmed*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 THEN @c17 END,  --do not show ILB
	CASE WHEN /*UpdatedFlag*/ SUBSTRING(@bitmap, 3, 1) & 2 = 2 THEN @c18 END,  --do not show ILB
	CASE WHEN /*LogEventCalloutDateTime*/ SUBSTRING(@bitmap, 3, 1) & 4 = 4 AND IsNull(@c19, '') = '' THEN '01/01/1900' ELSE @c19 END,
	ISNULL(@c20, @LastStatEmployeeID),
	@auditLogTypeID,
	@c22
	)

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

