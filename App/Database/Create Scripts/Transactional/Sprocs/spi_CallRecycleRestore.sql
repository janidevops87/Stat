SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_CallRecycleRestore]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	drop procedure [dbo].[spi_CallRecycleRestore]
	PRINT 'Dropping Procedure: spi_CallRecycleRestore'
END
	PRINT 'Creating Procedure: spi_CallRecycleRestore'

GO



CREATE PROCEDURE spi_CallRecycleRestore (
	@callId int,
	@lastStatEmployeeID int)
/*
   
*/
AS
/******************************************************************************
**		File: spi_CallRecycleRestore.sql
**		Name: spi_CallRecycleRestore
**		Desc: 
**		Moves calls previously placed in the CallRecycle table back in the Call table, effectively 
		removing them from the recycle bin.
		Created for StatTrac v. 7.7.4 5/25/05 - Scott Plummer
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Scott Plummer	
**		Date: 5/25/05
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		08/24/2010	jth					replaced lastmodifed in select with getdate function
*******************************************************************************/
SET NOCOUNT ON

-- Allow insertion into the identity field
SET IDENTITY_INSERT Call ON

-- Copy the Call data into CallRecycle
INSERT INTO Call (CallID, CallNumber, CallTypeID, CallDateTime, StatEmployeeID, CallTotalTime, 
		CallTempExclusive, Inactive, CallSeconds, LastModified, CallTemp, SourceCodeID, CallOpenByID, 
		CallTempSavedByID, CallExtension, UpdatedFlag, CallOpenByWebPersonId, RecycleNCFlag, CallActive,
		CallSaveLastByID,
		AuditLogTypeID)
		
	SELECT CallID, CallNumber, CallTypeID, CallDateTime, StatEmployeeID, CallTotalTime, 
		CallTempExclusive, Inactive, CallSeconds, GETDATE(), CallTemp, SourceCodeID, CallOpenByID,
		CallTempSavedByID, CallExtension, UpdatedFlag, CallOpenByWebPersonId, RecycleNCFlag, 
		-1, -- callactive flag to active 
		@lastStatEmployeeID,
		3 -- 3 = Modify
	FROM CallRecycle 
	WHERE CallId = @callId;

-- Disable identity insertion
SET IDENTITY_INSERT Call OFF

-- Now remove the record from CallRecycle
DELETE FROM CallRecycle WHERE CallId = @CallId;

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

