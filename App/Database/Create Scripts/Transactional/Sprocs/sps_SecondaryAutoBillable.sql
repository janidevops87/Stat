SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryAutoBillable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_SecondaryAutoBillable]
End
go


CREATE    PROCEDURE sps_SecondaryAutoBillable
		@CallID		int

AS

/******************************************************************************
**		File: sps_SecondaryAutoBillable.sql
**		Name: sps_SecondaryAutoBillable
**		Desc: This procedure looks for Secendary Pending event and returns 1 if exists and
**		zero if it does not.
**              
**		Return values: 
**		
**		Called by:
**              
**		Parameters:
**		Input							Output
**		----------						-----------
**		@CallID int
**
**		Auth: Christopher Carroll
**		Date: 05/22/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------

*******************************************************************************/


DECLARE @Billable int

SET @Billable =  (SELECT Count (LogEvent.LogEventTypeID)
		 FROM  LogEvent
		 WHERE LogEvent.CallID = @CallID AND
		 LogEvent.LogEventTypeID = 15) -- Secondary Pending


If @Billable <> 1 
BEGIN
	SET @Billable = 0
END


SELECT  @Billable AS 'SPExists'

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - sps_SecondaryAutoBillable create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - sps_SecondaryAutoBillable procedure created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/




