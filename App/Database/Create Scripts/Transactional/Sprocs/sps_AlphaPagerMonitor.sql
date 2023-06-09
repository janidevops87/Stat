SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS OFF;
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AlphaPagerMonitor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AlphaPagerMonitor];
GO


CREATE PROCEDURE sps_AlphaPagerMonitor (
	@hoursBack Int = 3)
AS

/***************************************************************************************
**	Name: sps_AlphaPagerMonitor
**	Returns information on a specific Alpha Page sent by StatTrac in the specified time.
**	Created 5/4/05 by Scott Plummer
**
**	Updates
**	Date			Developer			Notes
**	------			----------			--------
**	10/16/2020		James Gerberich		Eliminated unused fields. TFS 70399
***************************************************************************************/

SET NOCOUNT ON;

DECLARE
	@startDate datetime,
	@endDate datetime

SET @hoursBack = @hoursBack * -1

SET @endDate = GetDate()
SET @startDate = DateAdd(hh, @hoursBack, @endDate)

SELECT
	AlphaPageId,
	CallId,
	AlphaPageRecipient,
	AlphaPageSender,
	AlphaPageSubject,
	AlphaPageCreated, 
	AlphaPageSent,
	AlphaPageComplete,
	DateDiff(ss, AlphaPageCreated, AlphaPageSent) AS AlphaPageDelay
FROM AlphaPage 
WHERE
	AlphaPageCreated >= @startDate
AND	AlphaPageCreated <= @endDate
ORDER BY AlphaPageId DESC;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO