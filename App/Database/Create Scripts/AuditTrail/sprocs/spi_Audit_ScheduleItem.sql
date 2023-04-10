SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_ScheduleItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spi_Audit_ScheduleItem';
		DROP PROCEDURE [dbo].[spi_Audit_ScheduleItem];
	END
GO

	PRINT 'Creating Procedure spi_Audit_ScheduleItem';
GO

CREATE PROCEDURE [dbo].[spi_Audit_ScheduleItem]
	@ScheduleItemID			int,
	@ScheduleGroupID		int,
	@ScheduleItemName		varchar(10),
	@ScheduleItemStartDate	datetime,
	@ScheduleItemStartTime	varchar(5),
	@ScheduleItemEndDate	datetime,
	@ScheduleItemEndTime	varchar(5),
	@LastModified			datetime,
	@LastWebPersonID		int,
	@AuditLogTypeID			int

AS

/******************************************************************************
**		File: 
**		Name: spi_Audit_ScheduleItem
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
**		03/23/2021	James Gerberich		copied for ScheduleItem table
*******************************************************************************/

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
		@ScheduleItemID,
		@ScheduleGroupID,
		@ScheduleItemName,
		@ScheduleItemStartDate,
		@ScheduleItemStartTime,
		@ScheduleItemEndDate,
		@ScheduleItemEndTime,
		@LastModified,
		@LastWebPersonID,
		@AuditLogTypeID
	);

GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
