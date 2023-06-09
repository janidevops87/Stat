SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReconcileInvoice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReconcileInvoice]
GO

CREATE PROCEDURE sps_ReconcileInvoice 
	@pvStartDate as smalldatetime,
	@pvEndDate as smalldatetime

AS 

-- change end date

select @pvEndDate = @pvEndDate + ' 23:59'

SET NOCOUNT ON

SELECT 	'MM/YYYY' AS 'InvoiceDate', 
	'InvoiceSourceCodeName' AS 'SourceCodeName', 
	0 AS ReferralCount,
	0 AS MessageCount
INTO	#COUNTTABLE
WHERE	0 <>0

SELECT 	0 AS 'ReferralCount', 
	'SourceCodeName' AS 'SourceCodeName'
INTO	#ReferralCountTable
WHERE 	0 <> 0

SELECT 	0 AS 'MessageCount', 
	'SourceCodeName' AS 'SourceCodeName'
INTO	#MessageCountTable
WHERE 	0 <> 0



INSERT #COUNTTABLE
(InvoiceDate, SourceCodeName,ReferralCount,MessageCount)

SELECT DISTINCT 
CAST(Month(@pvStartDate) AS varchar(2))+ '/' + CAST(Year(@pvStartDate) AS varchar(4)), 
ISNULL(SourceCodeName,'UNDEFINED'),
0,
0
FROM SourceCode

INSERT #ReferralCountTable
(ReferralCount, SourceCodeName)
Select Count(CallTypeID), ISNULL(SourceCodeName,'UNDEFINED')
FROM  Call 
JOIN  Referral ON Referral.CallID = Call.CallID
LEFT JOIN  SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
WHERE CallTypeID = 1
AND  CallDateTime >= @pvStartDate AND CallDateTime <= @pvEndDate 
GROUP BY SourceCodeName, CAST(Month(CallDateTime) AS varchar(2))+ '/' + CAST(Year(CallDateTime) AS varchar(4)) 
ORDER BY CAST(Month(CallDateTime) AS varchar(2))+ '/' + CAST(Year(CallDateTime) AS varchar(4)) , SourceCodeName


INSERT #MessageCountTable
(MessageCount, SourceCodeName)
 SELECT Count(CallTypeID) ,
 	ISNULL(SourceCodeName,'UNDEFINED')
  FROM  Call 
  JOIN  Message ON Message.CallID = Call.CallID
  LEFT JOIN  SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
  WHERE CallTypeID = 2
  AND  CallDateTime >= @pvStartDate AND CallDateTime <= @pvEndDate 
  GROUP BY SourceCodeName, CAST(Year(CallDateTime) AS varchar(4)) + '-' + CAST(Month(CallDateTime) AS varchar(2))
  ORDER BY CAST(Year(CallDateTime) AS varchar(4)) + '-' + CAST(Month(CallDateTime) AS varchar(2)), SourceCodeName

UPDATE #COUNTTABLE
SET #COUNTTABLE.ReferralCount = #ReferralCountTable.ReferralCount
FROM #ReferralCountTable
WHERE #ReferralCountTable.SourceCodeName = #COUNTTABLE.SourceCodeName

UPDATE #COUNTTABLE
SET #COUNTTABLE.MessageCount = #MessageCountTable.MessageCount
FROM #MessageCountTable
WHERE #MessageCountTable.SourceCodeName = #COUNTTABLE.SourceCodeName


SELECT * FROM #COUNTTABLE

DROP TABLE #COUNTTABLE
DROP TABLE #MessageCountTable
DROP TABLE #ReferralCountTable



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

