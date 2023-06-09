SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_RegistryStatus]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
	PRINT 'Dropping Procedure spu_Audit_RegistryStatus'
	drop procedure [dbo].[spu_Audit_RegistryStatus]
GO

	PRINT 'Creating Procedure spu_Audit_RegistryStatus'
GO

create procedure "spu_Audit_RegistryStatus" 
	@c1 int,
	@c2 int,
	@c3 int,
	@c4 datetime,
	@c5 int,
	@c6 int,
	@pkc1 int,
	@bitmap binary(1)
AS
/******************************************************************************
**		File: spu_Audit_RegistryStatus.sql
**		Name: spu_Audit_RegistryStatus
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
		@callID int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- ID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- RegistryStatus
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- CallID
		AND SUBSTRING(@bitmap, 1, 1) & 8 = 8 -- LastModified
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- AuditLogTypeID
	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c6, AuditLogTypeID),
		@callID = CallID
	FROM
		RegistryStatus
	WHERE 
		ID = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- ID
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- RegistryStatus
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- CallID
	AND SUBSTRING(@bitmap, 1, 1) & 8 = 8 -- LastModified
	-- AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- LastStatEmployeeID
	-- AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- AuditLogTypeID
	AND @auditLogTypeID = 3		
	)
BEGIN
	SET @auditLogTypeID = 2	-- Review
END


insert into 
	"RegistryStatus"
	( 
		"ID", -- c1
		"RegistryStatus", -- c2
		"CallID", -- c3
		"LastModified",  -- c4
		"LastStatEmployeeID", -- c5
		"AuditLogTypeID" -- c6
 )

values 
	( 
		@pkc1,
		CASE WHEN /*RegistryStatus*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, -1) IN ( -1, 0) THEN -2 ELSE @c2 END,
		@callID,
		ISNULL(@c4, @lastModified), 
		ISNULL(@c5, @LastStatEmployeeID),
		@auditLogTypeID
	)
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

