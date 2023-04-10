SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_ScheduleItemPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spi_Audit_ScheduleItemPerson';
		DROP PROCEDURE [dbo].[spi_Audit_ScheduleItemPerson];
	END
GO

	PRINT 'Creating Procedure spi_Audit_ScheduleItemPerson';
GO

CREATE PROCEDURE [dbo].[spi_Audit_ScheduleItemPerson]
	@ScheduleItemPersonID	int,
	@ScheduleItemID			int,
	@PersonID				varchar(10),
	@Priority				int,
	@LastModified			datetime,
	@LastWebPersonID		int,
	@AuditLogTypeID			int

AS

/******************************************************************************
**		File: 
**		Name: spi_Audit_ScheduleItemPerson
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
		@ScheduleItemPersonID,
		@ScheduleItemID,
		@PersonID,
		@Priority,
		@LastModified,
		@LastWebPersonID,
		@AuditLogTypeID
	);
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
