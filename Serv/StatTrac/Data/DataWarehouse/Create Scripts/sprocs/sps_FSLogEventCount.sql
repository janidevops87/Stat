SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSLogEventCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSLogEventCount]
GO


CREATE PROCEDURE sps_FSLogEventCount( 
	@StartDate SMALLDATETIME,
	@EndDate SMALLDATETIME)
as

CREATE TABLE #FSCountTemp(CallId INT,
                          LogEventId INT)

INSERT INTO #FSCountTemp 
select Distinct t1.callid AS CALLID, 
t2.logeventid AS LOGEVENTID
From call t1, 
logevent t2
where t1.callid = t2.callid
and t2.logeventtypeid = 15
and t1.CallDateTime Between @StartDate and @EndDate


SELECT SourceCode.SourceCodeName, 
       CallType.CallTypeName, 
       COUNT(DISTINCT Call.CallID) AS CallCount, 
       ReferralType.ReferralTypeName, 
       COUNT(DISTINCT Referral.ReferralID) AS ReferralCount, 
       LogEventType.LogEventTypeName AS LogEventType, 
       COUNT(LogEvent.LogEventID) AS LogEventCount,
       0 AS FSLogEventCount,
       CAST(YEAR(Call.CallDateTime) AS varchar(4)) AS YEARDATE,
       CAST(MONTH(Call.CallDateTime) AS varchar(2)) AS MONTHDATE
FROM  Call INNER JOIN CallType ON Call.CallTypeID = CallType.CallTypeID 
           INNER JOIN SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID 
           LEFT OUTER JOIN Referral 
           INNER JOIN ReferralType ON Referral.ReferralTypeID = ReferralType.ReferralTypeID ON Call.CallID = Referral.CallID 
           LEFT OUTER JOIN LogEvent INNER JOIN LogEventType ON LogEvent.LogEventTypeID = LogEventType.LogEventTypeID ON Referral.CallID = LogEvent.CallID
WHERE  Call.CallDateTime BETWEEN @StartDate and @EndDate
GROUP BY SourceCode.SourceCodeName, 
         CallType.CallTypeName, 
         LogEventType.LogEventTypeName, 
         ReferralType.ReferralTypeName,
         CAST(YEAR(Call.CallDateTime) AS varchar(4)) ,
         CAST(MONTH(Call.CallDateTime) AS varchar(2))
UNION
SELECT SourceCode.SourceCodeName, 
       CallType.CallTypeName, 
       0 AS CallCount, 
       ReferralType.ReferralTypeName, 
       0 AS ReferralCount, 
       LogEventType.LogEventTypeName AS LogEventType, 
       0 AS LogEventCount,
       COUNT(DISTINCT LogEvent.LogEventID) AS FSLogEventCount,
       CAST(YEAR(Call.CallDateTime) AS varchar(4)),
       CAST(MONTH(Call.CallDateTime) AS varchar(2))
FROM  Call INNER JOIN CallType ON Call.CallTypeID = CallType.CallTypeID 
           INNER JOIN SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID 
           LEFT OUTER JOIN Referral 
           INNER JOIN ReferralType ON Referral.ReferralTypeID = ReferralType.ReferralTypeID ON Call.CallID = Referral.CallID 
           LEFT OUTER JOIN LogEvent INNER JOIN LogEventType ON LogEvent.LogEventTypeID = LogEventType.LogEventTypeID ON Referral.CallID = LogEvent.CallID
           INNER JOIN #FSCountTemp ON CALL.CALLID = #FSCountTemp.CALLID
WHERE  Call.CallDateTime BETWEEN @StartDate and @EndDate
       AND LogEvent.LogEventID >= #FSCountTemp.LogEventID
GROUP BY SourceCode.SourceCodeName, 
         CallType.CallTypeName, 
         LogEventType.LogEventTypeName, 
         ReferralType.ReferralTypeName,
         CAST(YEAR(Call.CallDateTime) AS varchar(4)),
         CAST(MONTH(Call.CallDateTime) AS varchar(2))

Drop Table #FSCountTemp

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

