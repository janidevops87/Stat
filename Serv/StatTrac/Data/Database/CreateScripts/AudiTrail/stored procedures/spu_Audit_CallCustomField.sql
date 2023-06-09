SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_CallCustomField]') and OBJECTPROPERTY(id,
	N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_CallCustomField'
		DROP procedure [dbo].[spu_Audit_CallCustomField]
	END
GO

	PRINT 'Creating Procedure spu_Audit_CallCustomField'
GO

create procedure "spu_Audit_CallCustomField" 
		@c1 int,
		@c2 varchar(40),
		@c3 varchar(40),
		@c4 varchar(40),
		@c5 varchar(40),
		@c6 varchar(40),
		@c7 varchar(40),
		@c8 varchar(255),
		@c9 varchar(255),
		@c10 varchar(40),
		@c11 varchar(40),
		@c12 varchar(40),
		@c13 varchar(40),
		@c14 varchar(40),
		@c15 varchar(40),
		@c16 varchar(40),
		@c17 varchar(40),
		@c18 datetime,
		@c19 smallint,
		@c20 int,
		@c21 int,
		@pkc1 int,
		@bitmap binary(3)
AS
/******************************************************************************
**		File: spu_Audit_CallCustomField.sql
**		Name: spu_Audit_CallCustomField
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
**		05/15/2008	ccarroll			Added CASE statement for ILB insert
*******************************************************************************/
	DECLARE 
		@lastModified datetime,
		@lastStatEmployeeID int,
		@auditLogTypeID int,
		@callID int
IF  (
		    SUBSTRING(@bitmap, 1, 1) & 1 = 1 -- CallID
		OR SUBSTRING(@bitmap, 1, 1) & 2 = 2 -- CallCustomField1
		OR SUBSTRING(@bitmap, 1, 1) & 4 = 4 -- CallCustomField2
		OR SUBSTRING(@bitmap, 1, 1) & 8 = 8 -- CallCustomField3
		OR SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- CallCustomField4
		OR SUBSTRING(@bitmap, 1, 1) & 32 = 32 -- CallCustomField5
		OR SUBSTRING(@bitmap, 1, 1) & 64 = 64 -- CallCustomField6
		OR SUBSTRING(@bitmap, 1, 1) & 128 = 128 -- CallCustomField7
		OR SUBSTRING(@bitmap, 2, 1) & 1 = 1 -- CallCustomField8
		OR SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- CallCustomField9
		OR SUBSTRING(@bitmap, 2, 1) & 4 = 4 -- CallCustomField10
		OR SUBSTRING(@bitmap, 2, 1) & 8 = 8 -- CallCustomField11
		OR SUBSTRING(@bitmap, 2, 1) & 16 = 16 -- CallCustomField12
		OR SUBSTRING(@bitmap, 2, 1) & 32 = 32 -- CallCustomField13
		OR SUBSTRING(@bitmap, 2, 1) & 64 = 64 -- CallCustomField14
		OR SUBSTRING(@bitmap, 2, 1) & 128 = 128 -- CallCustomField15
		OR SUBSTRING(@bitmap, 3, 1) & 1 = 1 -- CallCustomField16
		-- DO NOT CARE ABOUT LastModified OR SUBSTRING(@bitmap, 3, 1) & 2 = 2 -- LastModified
		OR SUBSTRING(@bitmap, 3, 1) & 4 = 4 -- UpdatedFlag
		OR SUBSTRING(@bitmap, 3, 1) & 8 = 8 -- LastStatEmployeeID
		OR SUBSTRING(@bitmap, 3, 1) & 16 = 16 -- AuditLogTypeID

	   )
BEGIN	   
	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c21, AuditLogTypeID),
		@callID = CallID
	FROM
		CallCustomField
	WHERE 
		CallID = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		(
			SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallCustomField1
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- CallCustomField2
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- CallCustomField3
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- CallCustomField4
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- CallCustomField5
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- CallCustomField6
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- CallCustomField7
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- CallCustomField8
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- CallCustomField9
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- CallCustomField10
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- CallCustomField11
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- CallCustomField12
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- CallCustomField13
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- CallCustomField14
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- CallCustomField15
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- CallCustomField16	
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- UpdatedFlag
		-- AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- LastStatEmployeeID
		-- AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- AuditLogTypeID
		)
		
	AND SUBSTRING(@bitmap, 3, 1) & 2 = 2 -- LastModified
	)
BEGIN
	SET @auditLogTypeID = 2	-- Review
END
ELSE
BEGIN
	SET @auditLogTypeID = 3	-- Modify
END

insert into "CallCustomField"( 
	"CallID", -- c1
	"CallCustomField1",  -- c2
	"CallCustomField2", -- c3
	"CallCustomField3", -- c4
	"CallCustomField4", -- c5
	"CallCustomField5", -- c6
	"CallCustomField6", -- c7
	"CallCustomField7", -- c8
	"CallCustomField8", -- c9
	"CallCustomField9", -- c10
	"CallCustomField10", -- c11
	"CallCustomField11", -- c12
	"CallCustomField12", -- c13
	"CallCustomField13", -- c14
	"CallCustomField14", -- c15
	"CallCustomField15", -- c16
	"CallCustomField16", -- c17
	"LastModified", -- c18
	"UpdatedFlag", -- c19
	"LastStatEmployeeID", -- c20
	"AuditLogTypeID" -- c21
 )

values ( 
	@pkc1,
	CASE WHEN /*CallCustomField1*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, '') = '' THEN 'ILB' ELSE @c2 END,
	CASE WHEN /*CallCustomField2*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, '') = '' THEN 'ILB' ELSE @c3 END,
	CASE WHEN /*CallCustomField3*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN 'ILB' ELSE @c4 END,
	CASE WHEN /*CallCustomField4*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, '') = '' THEN 'ILB' ELSE @c5 END,
	CASE WHEN /*CallCustomField5*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, '') = '' THEN 'ILB' ELSE @c6 END,
	CASE WHEN /*CallCustomField6*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, '') = '' THEN 'ILB' ELSE @c7 END,
	CASE WHEN /*CallCustomField7*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, '') = '' THEN 'ILB' ELSE @c8 END,
	CASE WHEN /*CallCustomField8*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@c9, '') = '' THEN 'ILB' ELSE @c9 END,
	CASE WHEN /*CallCustomField9*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@c10, '') = '' THEN 'ILB' ELSE @c10 END,
	CASE WHEN /*CallCustomField10*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 AND IsNull(@c11, '') = '' THEN 'ILB' ELSE @c11 END,
	CASE WHEN /*CallCustomField11*/ SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@c12, '') = '' THEN 'ILB' ELSE @c12 END,
	CASE WHEN /*CallCustomField12*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 AND IsNull(@c13, '') = '' THEN 'ILB' ELSE @c13 END,
	CASE WHEN /*CallCustomField13*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 AND IsNull(@c14, '') = '' THEN 'ILB' ELSE @c14 END,
	CASE WHEN /*CallCustomField14*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@c15, '') = '' THEN 'ILB' ELSE @c15 END,
	CASE WHEN /*CallCustomField15*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 AND IsNull(@c16, '') = '' THEN 'ILB' ELSE @c16 END,
	CASE WHEN /*CallCustomField16*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 AND IsNull(@c17, '') = '' THEN 'ILB' ELSE @c17 END,
	ISNULL(@c18, @lastModified),
	@c19,
	ISNULL(@c20, @lastStatEmployeeID),
	@auditLogTypeID
 )
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

