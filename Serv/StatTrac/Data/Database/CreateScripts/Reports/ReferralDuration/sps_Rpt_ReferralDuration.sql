if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_Rpt_ReferralDuration]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralDuration]
GO

SET QUOTED_IDENTIFIER OFF 
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sps_Rpt_ReferralDuration
(
	@StartDate	datetime,
	@EndDate	datetime
)
AS

/******************************************************************************
**		File: sps_Rpt_ReferralDuration.sql
**		Name: sps_Rpt_ReferralDuration
**		Desc: 
**
**		Auth: James Gerberich
**		Date: 06/14/2018
**
**
**	Date:		Author:				Description:
**	--------	--------			-------------------------------------------
**	04/16/2008	James Gerberich		initial version VS 58696
*******************************************************************************/

--DECLARE
--	@StartDate	datetime = '01/01/2018 00:00:00',
--	@EndDate	datetime = '05/31/2018 23:59:59';

----------------------------------------------------------------

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

With Calls AS
(
	Select
		c.CallID,
		sc.SourceCodeName
	From
		[Call] c
		INNER JOIN SourceCode sc ON c.SourceCodeID = sc.SourceCodeID AND sc.SourceCodeName IN ('CTYNKI', 'CTYNLI')
		INNER JOIN CallType ct ON c.CallTypeID = ct.CallTypeID AND ct.CallTypeName = 'Referral'
	Where
		c.CallDateTime >= @StartDate
	AND	c.CallDateTime <= @EndDate
)

--------------------------------

SELECT
	c.SourceCodeName,
	le.CallID,
	MIN(le.LogEventDateTime) AS FirstEvent,
	MAX(le.LogEventDateTIme) AS LastEvent,
	dbo.fn_rpt_ConvertSecondsToTime(DATEDIFF(second, MIN(le.LogEventDateTIme), MAX(le.LogEventDateTime)), 0, 0) AS HoursMinutes
FROM
	LogEvent le
	INNER JOIN Calls c ON le.CallID = c.CallID
GROUP BY
	c.SourceCodeName,
	le.CallID
ORDER BY
	le.CallID;