SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_NOK]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
	PRINT 'Dropping Procedure spu_Audit_NOK'
	drop procedure [dbo].[spu_Audit_NOK]
GO

	PRINT 'Creating Procedure spu_Audit_NOK'
GO


create procedure "spu_Audit_NOK" 
	@c1 int,
	@c2 varchar(50),
	@c3 varchar(50),
	@c4 varchar(14),
	@c5 varchar(255),
	@c6 varchar(50),
	@c7 int,
	@c8 varchar(10),
	@c9 varchar(50),
	@c10 datetime,
	@c11 int,
	@c12 int,
	@pkc1 int,
	@bitmap binary(2)
AS
/******************************************************************************
**		File: spu_Audit_NOK.sql
**		Name: spu_Audit_NOK
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
IF NOT (
			SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- NOKID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- NOKFirstName
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- NOKLastName
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- NOKPhone
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- NOKAddress
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- NOKCity
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- NOKStateID
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- NOKZip
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- NOKApproachRelation
		AND SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- LastModified
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- AuditLogTypeID

	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c12, AuditLogTypeID)
	FROM
		NOK
	WHERE 
		NOKID = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- NOKID
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- NOKFirstName
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- NOKLastName
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- NOKPhone
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- NOKAddress
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- NOKCity
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- NOKStateID
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- NOKZip
	AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- NOKApproachRelation
	AND SUBSTRING(@bitmap, 2, 1) & 2 = 2 -- LastModified
	--AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- LastStatEmployeeID
	--AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- AuditLogTypeID
	AND @auditLogTypeID = 3	
	)
BEGIN
		SET @auditLogTypeID = 2	-- Review
END


insert into 
	"NOK"
	( 
		"NOKID", -- c1
		"NOKFirstName", -- c2
		"NOKLastName", -- c3
		"NOKPhone", -- c4
		"NOKAddress", -- c5
		"NOKCity", -- c6
		"NOKStateID", -- c7
		"NOKZip", -- c8
		"NOKApproachRelation", -- c9
		"LastModified", -- c10
		"LastStatEmployeeID", -- c11
		"AuditLogTypeID" -- c12
	)

values 
	( 
		@pkc1,
		CASE WHEN /*NOKFirstName*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, '') = '' THEN 'ILB' ELSE @c2 END,
		CASE WHEN /*NOKLastName*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, '') = '' THEN 'ILB' ELSE @c3 END,
		CASE WHEN /*NOKPhone*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN 'ILB' ELSE @c4 END,
		CASE WHEN /*NOKAddress*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, '') = '' THEN 'ILB' ELSE @c5 END,
		CASE WHEN /*NOKCity*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, '') = '' THEN 'ILB' ELSE @c6 END,
		CASE WHEN /*NOKStateID*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, -1) IN ( -1, 0) THEN -2 ELSE @c7 END,
		CASE WHEN /*NOKZip*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, '') = '' THEN 'ILB' ELSE @c8 END,
		CASE WHEN /*NOKApproachRelation*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@c9, '') = '' THEN 'ILB' ELSE @c9 END,
		ISNULL(@c10, @lastModified), 
		ISNULL(@c11, @LastStatEmployeeID),
		@auditLogTypeID
	)
		 
END		 
		 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

