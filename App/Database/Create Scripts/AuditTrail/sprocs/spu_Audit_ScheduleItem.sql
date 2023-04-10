SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_ScheduleItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_ScheduleItem';
		DROP PROCEDURE [dbo].[spu_Audit_ScheduleItem];
	END
GO

	PRINT 'Creating Procedure spu_Audit_ScheduleItem';
GO

CREATE PROCEDURE [dbo].[spu_Audit_ScheduleItem]
	@ScheduleItemID			int,
	@ScheduleGroupID		int,
	@ScheduleItemName		varchar(10),
	@ScheduleItemStartDate	datetime,
	@ScheduleItemStartTime	varchar(5),
	@ScheduleItemEndDate	datetime,
	@ScheduleItemEndTime	varchar(5),
	@LastModified			datetime,
	@LastWebPersonID		int,
	@AuditLogTypeID			int,
	@pkc1					int,
	@bitmap					binary(3)

AS

/******************************************************************************
**		File: 
**		Name: spu_Audit_ScheduleItem
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
**		03/23/2021	JamesGerberich		copied for ScheduleItem table
*******************************************************************************/

IF (
		SUBSTRING(@bitmap, 1, 1) & 1 = 1	-- ScheduleItemID
	OR	SUBSTRING(@bitmap, 1, 1) & 2 = 2	-- ScheduleGroupID
	OR	SUBSTRING(@bitmap, 1, 1) & 4 = 4	-- ScheduleItemName
	OR	SUBSTRING(@bitmap, 1, 1) & 8 = 8	-- ScheduleItemStartDate
	OR	SUBSTRING(@bitmap, 1, 1) & 16 = 16	-- ScheduleItemStartTime
	OR	SUBSTRING(@bitmap, 1, 1) & 32 = 32	-- ScheduleItemEndDate
	OR	SUBSTRING(@bitmap, 1, 1) & 64 = 64	-- ScheduleItemEndTime
	-- IGNORE OR SUBSTRING(@bitmap, 1, 1) & 128 = 128 -- LastModified
	OR	SUBSTRING(@bitmap, 2, 1) & 1 = 1	-- LastWebPersonID
	OR	SUBSTRING(@bitmap, 2, 1) & 2 = 2	-- AuditLogTypeID
	)
BEGIN
	-- get the basic values if they do not exists
	SELECT TOP 1
		@ScheduleGroupID	= ISNULL(@ScheduleGroupID, ScheduleGroupID),
		@LastModified		= ISNULL(@LastModified, GetDate()),
		@LastWebPersonID	= ISNULL(@LastWebPersonID, LastWebPersonID),
		@AuditLogTypeID		= ISNULL(@AuditLogTypeID, AuditLogTypeID)
	FROM
		ScheduleItem
	WHERE
		ScheduleItemID = @pkc1
	ORDER BY
		LastModified DESC
	
	INSERT
		ScheduleItem 
		( 
			ScheduleItemID,
			ScheduleGroupID,
			ScheduleItemName,
			ScheduleItemStartDate,
			ScheduleItemStartTime,
			ScheduleItemEndDate,
			ScheduleItemEndTime,
			LastModified,
			LastWebPersonID,
			AuditLogTypeID
		) 
	VALUES 
		( 
			@pkc1, -- ScheduleItemID
			@ScheduleGroupID,
			CASE WHEN SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND ISNULL(@ScheduleItemName, '') = '' THEN 'ILB' ELSE @ScheduleItemName END,
			CASE WHEN SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND ISNULL(@ScheduleItemStartDate, '') = '' THEN '01/01/1900' ELSE @ScheduleItemStartDate END,
			CASE WHEN SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND ISNULL(@ScheduleItemStartTime, '') = '' THEN 'ILB' ELSE @ScheduleItemStartTime END,
			CASE WHEN SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND ISNULL(@ScheduleItemEndDate, '') = '' THEN '01/01/1900' ELSE @ScheduleItemEndDate END,
			CASE WHEN SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND ISNULL(@ScheduleItemEndTime, '') = '' THEN 'ILB' ELSE @ScheduleItemEndTime END,
			@LastModified,
			@LastWebPersonID,
			@AuditLogTypeID
		)
END;
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
