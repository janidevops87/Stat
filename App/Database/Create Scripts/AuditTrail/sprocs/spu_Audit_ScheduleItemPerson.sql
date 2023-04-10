SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_ScheduleItemPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_ScheduleItemPerson';
		DROP PROCEDURE [dbo].[spu_Audit_ScheduleItemPerson];
	END
GO

	PRINT 'Creating Procedure spu_Audit_ScheduleItemPerson';
GO

CREATE PROCEDURE [dbo].[spu_Audit_ScheduleItemPerson]
	@ScheduleItemPersonID	int,
	@ScheduleItemID			int,
	@PersonID				int,
	@Priority				int,
	@LastModified			datetime,
	@LastWebPersonID		int,
	@AuditLogTypeID			int,
	@pkc1					int,
	@bitmap					binary(3)

AS

/******************************************************************************
**		File: 
**		Name: spu_Audit_ScheduleItemPerson
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
**		03/23/2021	James Gerberich		copied for ScheduleItemPerson table
*******************************************************************************/

IF (
		SUBSTRING(@bitmap, 1, 1) & 1 = 1	-- ScheduleItemPersonID
	OR	SUBSTRING(@bitmap, 1, 1) & 2 = 2	-- ScheduleItemID
	OR	SUBSTRING(@bitmap, 1, 1) & 4 = 4	-- PersonID
	OR	SUBSTRING(@bitmap, 1, 1) & 8 = 8	-- Priority
		--IGNORE OR SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- LastModified
	OR	SUBSTRING(@bitmap, 1, 1) & 32 = 32	-- LastWebPersonID
	OR	SUBSTRING(@bitmap, 1, 1) & 64 = 64	-- AuditLogTypeID
	)
BEGIN
	-- get the basic values if they do not exists
	SELECT TOP 1
		@ScheduleItemID		= ISNULL(@ScheduleItemID, ScheduleItemID),
		@Priority			= ISNULL(@Priority, [Priority]),
		@LastModified		= ISNULL(@LastModified, GETDATE()),
		@LastWebPersonID	= ISNULL(@LastWebPersonID, LastWebPersonID),
		@AuditLogTypeID		= ISNULL(@AuditLogTypeID, AuditLogTypeID)
	FROM
		ScheduleItemPerson
	WHERE 
		ScheduleItemPersonID = @pkc1
	ORDER BY
		LastModified DESC

	INSERT
		ScheduleItemPerson
		(
			ScheduleItemPersonID,
			ScheduleItemID,
			PersonID,
			[Priority],
			LastModified,
			LastWebPersonID,
			AuditLogTypeID
		)
	VALUES
		(
			@pkc1, -- ScheduleItemPersonID
			@ScheduleItemID,
			CASE WHEN SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@PersonID, -1) IN ( -1, 0) THEN -2 ELSE @PersonID END,
			@Priority,
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
