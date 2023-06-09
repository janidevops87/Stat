SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_ReferralSecondaryData]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
	PRINT 'Dropping Procedure spu_Audit_ReferralSecondaryData'
	drop procedure [dbo].[spu_Audit_ReferralSecondaryData]
GO

	PRINT 'Creating Procedure spu_Audit_ReferralSecondaryData'
GO


create procedure "spu_Audit_ReferralSecondaryData" 
	@c1 int,
	@c2 varchar(500),
	@c3 smalldatetime,
	@c4 smallint,
	@c5 float,
	@c6 float,
	@c7 float,
	@c8 float,
	@c9 float,
	@c10 float,
	@c11 float,
	@c12 float,
	@c13 varchar(50),
	@c14 float,
	@c15 float,
	@c16 float,
	@c17 float,
	@c18 varchar(50),
	@c19 smallint,
	@c20 smallint,
	@c21 smallint,
	@c22 smallint,
	@c23 smallint,
	@c24 smallint,
	@c25 smallint,
	@c26 smallint,
	@c27 smallint,
	@c28 int,
	@c29 datetime,
	@c30 varchar(50),
	@c31 varchar(50),
	@c32 varchar(50),
	@c33 int,
	@c34 int,
	@pkc1 int,
	@bitmap binary(5)
AS
/******************************************************************************
**		File: spu_Audit_ReferralSecondaryData.sql
**		Name: spu_Audit_ReferralSecondaryData
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
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- ReferralID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- ReferralSecondaryHistory
		AND SUBSTRING(@bitmap, 1, 1) & 4 = 4 -- LastModified
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- hdBloodRecv48
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- hdWholeBloodUnits
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- hdWholeBloodAmt
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- hdRedBloodUnits
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- hdRedBloodAmt
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- hdColloid_1
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- hdColloid_2
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- hdColloid_3
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- hdColloid_4
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- hdColloid_List
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- hdCrystalloid_1
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- hdCrystalloid_2
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- hdCrystalloid_3
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- hdCrystalloid_4
		AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- hdCrystalloid_List
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- hdQuest1_1
		AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- hdQuest2_1
		AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- hdQuest2_2
		AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- hdQuest2_3
		AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- hdQuest2_4
		AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- hdQuest3_1
		AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- hdQuest3_2
		AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- hdQuest3_3
		AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- hdQuest3_4
		AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- fscUserID
		AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- hdLastModified
		AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- hdQuest3_2a
		AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- hdQuest3_3a
		AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- hdQuest3_4a
		AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- AuditLogTypeID

	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c34, AuditLogTypeID)
	FROM
		ReferralSecondaryData
	WHERE 
		ReferralID = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- ReferralID
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- ReferralSecondaryHistory
	AND SUBSTRING(@bitmap, 1, 1) & 4 = 4 -- LastModified
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- hdBloodRecv48
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- hdWholeBloodUnits
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- hdWholeBloodAmt
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- hdRedBloodUnits
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- hdRedBloodAmt
	AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- hdColloid_1
	AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- hdColloid_2
	AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- hdColloid_3
	AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- hdColloid_4
	AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- hdColloid_List
	AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- hdCrystalloid_1
	AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- hdCrystalloid_2
	AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- hdCrystalloid_3
	AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- hdCrystalloid_4
	AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- hdCrystalloid_List
	AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- hdQuest1_1
	AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- hdQuest2_1
	AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- hdQuest2_2
	AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- hdQuest2_3
	AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- hdQuest2_4
	AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- hdQuest3_1
	AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- hdQuest3_2
	AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- hdQuest3_3
	AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- hdQuest3_4
	AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- fscUserID
	AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- hdLastModified
	AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- hdQuest3_2a
	AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- hdQuest3_3a
	AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- hdQuest3_4a
	-- AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- LastStatEmployeeID
	-- AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- AuditLogTypeID
	AND @auditLogTypeID = 3	
	
	)
BEGIN
	SET @auditLogTypeID = 2	-- Review
END


insert into 
	"ReferralSecondaryData"
	( 
		ReferralID,  --c1
		ReferralSecondaryHistory,  --c2
		LastModified,  --c3
		hdBloodRecv48,  --c4
		hdWholeBloodUnits,  --c5
		hdWholeBloodAmt,  --c6
		hdRedBloodUnits,  --c7
		hdRedBloodAmt,  --c8
		hdColloid_1,  --c9
		hdColloid_2,  --c10
		hdColloid_3,  --c11
		hdColloid_4,  --c12
		hdColloid_List,  --c13
		hdCrystalloid_1,  --c14
		hdCrystalloid_2,  --c15
		hdCrystalloid_3,  --c16
		hdCrystalloid_4,  --c17
		hdCrystalloid_List,  --c18
		hdQuest1_1,  --c19
		hdQuest2_1,  --c20
		hdQuest2_2,  --c21
		hdQuest2_3,  --c22
		hdQuest2_4,  --c23
		hdQuest3_1,  --c24
		hdQuest3_2,  --c25
		hdQuest3_3,  --c26
		hdQuest3_4,  --c27
		fscUserID,  --c28
		hdLastModified,  --c29
		hdQuest3_2a,  --c30
		hdQuest3_3a,  --c31
		hdQuest3_4a,  --c32
		LastStatEmployeeID,  --c33
		AuditLogTypeID  --c34

	)

values 
	( 
		@pkc1,
		@c2,
		ISNULL(@c3, @lastModified), 
		CASE WHEN /*hdBloodRecv48*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, -1) IN ( -1, 0) THEN -2 ELSE @c4 END,
		CASE WHEN /*hdWholeBloodUnits*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, -1) IN ( -1, 0) THEN -2 ELSE @c5 END,
		CASE WHEN /*hdWholeBloodAmt*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, -1) IN ( -1, 0) THEN -2 ELSE @c6 END,
		CASE WHEN /*hdRedBloodUnits*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, -1) IN ( -1, 0) THEN -2 ELSE @c7 END,
		CASE WHEN /*hdRedBloodAmt*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, -1) IN ( -1, 0) THEN -2 ELSE @c8 END,
		CASE WHEN /*hdColloid_1*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@c9, -1) IN ( -1, 0) THEN -2 ELSE @c9 END,
		CASE WHEN /*hdColloid_2*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@c10, -1) IN ( -1, 0) THEN -2 ELSE @c10 END,
		CASE WHEN /*hdColloid_3*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 AND IsNull(@c11, -1) IN ( -1, 0) THEN -2 ELSE @c11 END,
		CASE WHEN /*hdColloid_4*/ SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@c12, -1) IN ( -1, 0) THEN -2 ELSE @c12 END,
		CASE WHEN /*hdColloid_List*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 AND IsNull(@c13, '') = '' THEN 'ILB' ELSE @c13 END,
		CASE WHEN /*hdCrystalloid_1*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 AND IsNull(@c14, -1) IN ( -1, 0) THEN -2 ELSE @c14 END,
		CASE WHEN /*hdCrystalloid_2*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@c15, -1) IN ( -1, 0) THEN -2 ELSE @c15 END,
		CASE WHEN /*hdCrystalloid_3*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 AND IsNull(@c16, -1) IN ( -1, 0) THEN -2 ELSE @c16 END,
		CASE WHEN /*hdCrystalloid_4*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 AND IsNull(@c17, -1) IN ( -1, 0) THEN -2 ELSE @c17 END,
		CASE WHEN /*hdCrystalloid_List*/ SUBSTRING(@bitmap, 3, 1) & 2 = 2 AND IsNull(@c18, '') = '' THEN 'ILB' ELSE @c18 END,
		CASE WHEN /*hdQuest1_1*/ SUBSTRING(@bitmap, 3, 1) & 4 = 4 AND IsNull(@c19, -1) IN ( -1, 0) THEN -2 ELSE @c19 END,
		CASE WHEN /*hdQuest2_1*/ SUBSTRING(@bitmap, 3, 1) & 8 = 8 AND IsNull(@c20, -1) IN ( -1, 0) THEN -2 ELSE @c20 END,
		CASE WHEN /*hdQuest2_2*/ SUBSTRING(@bitmap, 3, 1) & 16 = 16 AND IsNull(@c21, -1) IN ( -1, 0) THEN -2 ELSE @c21 END,
		CASE WHEN /*hdQuest2_3*/ SUBSTRING(@bitmap, 3, 1) & 32 = 32 AND IsNull(@c22, -1) IN ( -1, 0) THEN -2 ELSE @c22 END,
		CASE WHEN /*hdQuest2_4*/ SUBSTRING(@bitmap, 3, 1) & 64 = 64 AND IsNull(@c23, -1) IN ( -1, 0) THEN -2 ELSE @c23 END,
		CASE WHEN /*hdQuest3_1*/ SUBSTRING(@bitmap, 3, 1) & 128 = 128 AND IsNull(@c24, -1) IN ( -1, 0) THEN -2 ELSE @c24 END,
		CASE WHEN /*hdQuest3_2*/ SUBSTRING(@bitmap, 4, 1) & 1 = 1 AND IsNull(@c25, -1) IN ( -1, 0) THEN -2 ELSE @c25 END,
		CASE WHEN /*hdQuest3_3*/ SUBSTRING(@bitmap, 4, 1) & 2 = 2 AND IsNull(@c26, -1) IN ( -1, 0) THEN -2 ELSE @c26 END,
		CASE WHEN /*hdQuest3_4*/ SUBSTRING(@bitmap, 4, 1) & 4 = 4 AND IsNull(@c27, -1) IN ( -1, 0) THEN -2 ELSE @c27 END,
		CASE WHEN /*fscUserID*/ SUBSTRING(@bitmap, 4, 1) & 8 = 8 AND IsNull(@c28, -1) IN ( -1, 0) THEN -2 ELSE @c28 END,
		CASE WHEN /*hdLastModified*/ SUBSTRING(@bitmap, 4, 1) & 16 = 16 AND IsNull(@c29, '') = '' THEN '01/01/1900' ELSE @c29 END,
		CASE WHEN /*hdQuest3_2a*/ SUBSTRING(@bitmap, 4, 1) & 32 = 32 AND IsNull(@c30, '') = '' THEN 'ILB' ELSE @c30 END,
		CASE WHEN /*hdQuest3_3a*/ SUBSTRING(@bitmap, 4, 1) & 64 = 64 AND IsNull(@c31, '') = '' THEN 'ILB' ELSE @c31 END,
		CASE WHEN /*hdQuest3_4a*/ SUBSTRING(@bitmap, 4, 1) & 128 = 128 AND IsNull(@c32, '') = '' THEN 'ILB' ELSE @c32 END,
		ISNULL(@c33, @LastStatEmployeeID),
		@auditLogTypeID
	)

END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

