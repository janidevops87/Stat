SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS OFF;
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AlphaPagerDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AlphaPagerDetail];
GO


CREATE PROCEDURE sps_AlphaPagerDetail (
	@alphaPageId Int = NULL)
AS

/***************************************************************************************
**	Name: sps_AlphaPagerDetail
**	Returns information on a specific Alpha Page sent by StatTrac in the specified time.
**	Created 5/4/05 by Scott Plummer
**
**	Updates
**	Date			Developer			Notes
**	------			----------			--------
**	10/16/2020		James Gerberich		Eliminated unused fields. TFS 70399
***************************************************************************************/

SET NOCOUNT ON;

SELECT
	AP.AlphaPageId,
	AP.CallId,
	AP.AlphaPageRecipient,
	AP.AlphaPageSender,
	AP.AlphaPageSubject,
	AP.AlphaPageBody,
	AP.AlphaPageCreated, 
	AP.AlphaPageSent,
	AP.AlphaPageComplete,
	DateDiff(ss, AlphaPageCreated, AlphaPageSent) AS AlphaPageDelay,
	LE.LogEventDateTime,
	LT.LogEventTypeName,
	LE.LogEventName,
	LE.LogEventOrg,
	IsNull(SE.StatEmployeeFirstName,'') + ' ' + IsNull(SE.StatEmployeeLastName,'') AS StatEmployeeName
FROM
	AlphaPage AP
	LEFT JOIN LogEvent LE ON AP.CallId = LE.CallId
	LEFT JOIN LogEventType LT ON LE.LogEventTypeId = LT.LogEventTypeId
	LEFT JOIN StatEmployee SE ON LE.StatEmployeeId = SE.StatEmployeeId
WHERE AP.AlphaPageId = @alphaPageId
ORDER BY
	LE.LogEventDateTime,
	LE.LogEventTypeId;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO