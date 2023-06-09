SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_Person]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
	PRINT 'Dropping Procedure spu_Audit_Person'
	drop procedure [dbo].[spu_Audit_Person]
GO

	PRINT 'Creating Procedure spu_Audit_Person'
GO

create procedure "spu_Audit_Person" 
	@c1 int,
	@c2 varchar(50),
	@c3 varchar(1),
	@c4 varchar(50),
	@c5 int,
	@c6 int,
	@c7 varchar(255),
	@c8 smallint,
	@c9 smallint,
	@c10 smallint,
	@c11 datetime,
	@c12 smalldatetime,
	@c13 smallint,
	@c14 smalldatetime,
	@c15 varchar(255),
	@c16 varchar(30),
	@c17 smallint,
	@c18 smallint,
	@c19 int,
	@c20 smallint,
	@c21 int,
	@c22 int,
	@c23 int, -- GenderID
	@c24 int, -- RaceID	int
	@c25 varchar(25), -- Credential	varchar
	@c26 int, -- TrainedRequestorID	int	
	@pkc1 int,
	@bitmap binary(4)
AS
/******************************************************************************
**		File: spu_Audit_Person.sql
**		Name: spu_Audit_Person
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
		@auditLogTypeID int

IF	NOT (
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- PersonID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- PersonFirst
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- PersonMI
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- PersonLast
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- PersonTypeID
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- OrganizationID
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- PersonNotes
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- PersonBusy
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- Verified
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- Inactive
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- LastModified
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- PersonBusyUntil
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- PersonTempNoteActive
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- PersonTempNoteExpires
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- PersonTempNote
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- Unused
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- UpdatedFlag
		AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- AllowInternetScheduleAccess
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- PersonSecurity
		AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- PersonArchive
		AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- AuditLogTypeID
		AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- GenderID
		AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- RaceID
		AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- Credential
		AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- TrainedRequestorID
	)
BEGIN
	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c22, 3)
	FROM
		Person
	WHERE 
		PersonID = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- PersonID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- PersonFirst
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- PersonMI
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- PersonLast
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- PersonTypeID
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- OrganizationID
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- PersonNotes
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- PersonBusy
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- Verified
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- Inactive
		AND SUBSTRING(@bitmap, 2, 1) & 4 = 4 -- LastModified
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- PersonBusyUntil
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- PersonTempNoteActive
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- PersonTempNoteExpires
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- PersonTempNote
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- Unused
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- UpdatedFlag
		AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- AllowInternetScheduleAccess
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- PersonSecurity
		AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- PersonArchive
		-- AND SUBSTRING(@bitmap, 3, 1) & 16 = 16 -- LastStatEmployeeID
		-- this might not be needed AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- AuditLogTypeID
		AND IsNull(@auditLogTypeID, 2) IN (2, 3, 4)			
		AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- GenderID
		AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- RaceID
		AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- Credential
		AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- TrainedRequestorID

	)
BEGIN 	/* Only LastModified Changed. Check for Deleted record */
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
		"Person"
		( 
			PersonID,  --c1
			PersonFirst,  --c2
			PersonMI,  --c3
			PersonLast,  --c4
			PersonTypeID,  --c5
			OrganizationID,  --c6
			PersonNotes,  --c7
			PersonBusy,  --c8
			Verified,  --c9
			Inactive,  --c10
			LastModified,  --c11
			PersonBusyUntil,  --c12
			PersonTempNoteActive,  --c13
			PersonTempNoteExpires,  --c14
			PersonTempNote,  --c15
			Unused,  --c16
			UpdatedFlag,  --c17
			AllowInternetScheduleAccess,  --c18
			PersonSecurity,  --c19
			PersonArchive,  --c20
			LastStatEmployeeID,  --c21
			AuditLogTypeID,  --c22
			GenderID, --c23
			RaceID, --c24
			Credential, --c25
			TrainedRequestorID --c26

		)

	values 
		( 
			@pkc1,
			CASE WHEN /*PersonFirst*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, '') = '' THEN 'ILB' ELSE @c2 END,
			CASE WHEN /*PersonMI*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, '') = '' THEN 'ILB' ELSE @c3 END,
			CASE WHEN /*PersonLast*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN 'ILB' ELSE @c4 END,
			CASE WHEN /*PersonTypeID*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, -1) IN ( -1, 0) THEN -2 ELSE @c5 END,
			CASE WHEN /*OrganizationID*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, -1) IN ( -1, 0) THEN -2 ELSE @c6 END,
			CASE WHEN /*PersonNotes*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, '') = '' THEN 'ILB' ELSE @c7 END,
			CASE WHEN /*PersonBusy*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 THEN IsNull(@c8, 0) END,  -- YN do not show ILB
			CASE WHEN /*Verified*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 THEN IsNull(@c9, 0) END, -- YN do not show ILB
			CASE WHEN /*Inactive*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 THEN IsNull(@c10, 0) END, -- YN do not show ILB
			ISNULL(@c11, @lastModified), 
			CASE WHEN /*PersonBusyUntil*/ SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@c12, '') = '' THEN '01/01/1900' ELSE @c12 END,
			CASE WHEN /*PersonTempNoteActive*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 THEN IsNull(@c13, 0) END, -- YN do not show ILB
			CASE WHEN /*PersonTempNoteExpires*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 AND IsNull(@c14, '') = '' THEN '01/01/1900' ELSE @c14 END,
			CASE WHEN /*PersonTempNote*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@c15, '') = '' THEN 'ILB' ELSE @c15 END,
			CASE WHEN /*Unused*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 AND IsNull(@c16, '') = '' THEN 'ILB' ELSE @c16 END,
			CASE WHEN /*UpdatedFlag*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 THEN IsNull(@c17, 0) END,
			CASE WHEN /*AllowInternetScheduleAccess*/ SUBSTRING(@bitmap, 3, 1) & 2 = 2 THEN IsNull(@c18, 0) END,
			CASE WHEN /*PersonSecurity*/ SUBSTRING(@bitmap, 3, 1) & 4 = 4 THEN IsNull(@c19, 0) END,
			CASE WHEN /*PersonArchive*/ SUBSTRING(@bitmap, 3, 1) & 8 = 8 THEN IsNull(@c20, 0) END,
			ISNULL(@c21, @LastStatEmployeeID), 
			@auditLogTypeID,
			CASE WHEN /*GenderID*/ SUBSTRING(@bitmap, 3, 1) & 64 = 64 AND IsNull(@c23, -1) IN ( -1, 0) THEN -2 ELSE @c23 END,
			CASE WHEN /*RaceID*/ SUBSTRING(@bitmap, 3, 1) & 128 = 128 AND IsNull(@c24, -1) IN ( -1, 0) THEN -2 ELSE @c24 END,
			CASE WHEN /*Credential*/ SUBSTRING(@bitmap, 4, 1) & 1 = 1 AND IsNull(@c25, '') = '' THEN 'ILB' ELSE @c25 END,
			CASE WHEN /*TrainedRequestorID	*/ SUBSTRING(@bitmap, 4, 1) & 2 = 2 AND IsNull(@c26, -1) IN ( -1, 0) THEN -2 ELSE @c26 END
		)
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

