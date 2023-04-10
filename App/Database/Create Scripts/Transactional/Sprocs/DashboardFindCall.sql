IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardFindCall')
	BEGIN
		PRINT 'Dropping Procedure DashboardFindCall'
		DROP Procedure DashboardFindCall
	END
GO
PRINT 'Creating Procedure DashboardFindCall'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: DashboardFindCall.sql
**	Name: DashboardFindCall
**	Desc: finds what tab a call # should be in
**	Auth: jth
**	Date: April 2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
*******************************************************************************/

CREATE PROCEDURE DashboardFindCall
	-- Add the parameters for the stored procedure here
	@callNumber			VARCHAR(11) = NULL,
	@userOrganizationID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
select top 1 call.CallID,
--referral
(SELECT COUNT (Call.CallID)
FROM CALL	 
JOIN Referral ON Call.CallID = Referral.CallID 
where call.callid = @callNumber AND
	CallActive <> 0 ) as IsReferral,
--message
(SELECT COUNT(Call.CallID)FROM 	Call 
JOIN Message ON Call.CallID = Message.CallID 
where call.callid = @callNumber AND
	CallActive <> 0 ) as IsMessage,
--no call
(SELECT COUNT (Call.CallID)
FROM NoCall LEFT JOIN Call ON NoCall.CallID = Call.CallID 
where call.callid = @callNumber) as IsNocall,
--recycled call
(SELECT COUNT (Call.CallID)
FROM Referral LEFT JOIN	CallRecycle Call  ON Call.CallID = Referral.CallID
where call.callid = @callNumber) as IsRecycledCall, 
--recycled message
(SELECT COUNT (Call.CallID)
FROM Message LEFT JOIN CallRecycle Call ON Call.CallID = Message.CallID
where call.callid = @callNumber) as IsRecycledMsg,
--recycled oasis
(SELECT COUNT (troi.CallId)
FROM dbo.TcssDonor td
	INNER JOIN TcssDonorToRecipient tdr ON td.TcssDonorId = tdr.TcssDonorId
	INNER JOIN TcssRecipient tr ON tr.TcssRecipientId = tdr.TcssRecipientId
	INNER JOIN TcssRecipientOfferInformation troi ON troi.TcssRecipientId = tr.TcssRecipientId
	INNER JOIN TcssRecipientOfferStatusInformation RecentOfferStatusInformation ON 
		(
			RecentOfferStatusInformation.TcssRecipientId = tr.TcssRecipientId
			AND RecentOfferStatusInformation.LastUpdateDate = (Select Max(LastUpdateDate) From TcssRecipientOfferStatusInformation Where TcssRecipientId = tr.TcssRecipientId)
		)
	LEFT JOIN TcssDonorContactInformation trdi ON trdi.TcssDonorId = td.TcssDonorId
	LEFT JOIN dbo.Call c ON troi.CallId = c.CallId
	LEFT JOIN dbo.Referral r ON troi.CallId = r.CallId
where c.callid = @callNumber AND 	CallActive = 0 ) as IsRecycleOasis,
--Update
(SELECT COUNT (Call.CallID)
FROM LogEvent JOIN [Call] ON [Call].CallID = LogEvent.CallID AND LogEvent.LogEventTypeID IN (7, 8, 24)
LEFT JOIN	Referral ON Referral.CallID = [Call].CallID
where call.callid = @callNumber and LogEvent.LogEventTypeID IN (7, 8, 24)) as IsUpdate,
--fs active cases
(SELECT COUNT (c.CallID)
FROM dbo.Referral r INNER JOIN dbo.Call c ON r.CallId = c.CallId
INNER JOIN dbo.SourceCode sc ON c.SourceCodeId = sc.SourceCodeId
INNER JOIN FsbCaseStatus recentFcs ON 
(
	recentFcs.CallId = c.CallId
	AND recentFcs.LastModified = (Select Max(LastModified) From FsbCaseStatus Where CallId = c.CallId)
)
where c.callid = @callNumber ) as IsFSActive,
--OASIS
(SELECT COUNT (troi.CallId)
FROM dbo.TcssDonor td
	INNER JOIN TcssDonorToRecipient tdr ON td.TcssDonorId = tdr.TcssDonorId
	INNER JOIN TcssRecipient tr ON tr.TcssRecipientId = tdr.TcssRecipientId
	INNER JOIN TcssRecipientOfferInformation troi ON troi.TcssRecipientId = tr.TcssRecipientId
	INNER JOIN TcssRecipientOfferStatusInformation RecentOfferStatusInformation ON 
		(
			RecentOfferStatusInformation.TcssRecipientId = tr.TcssRecipientId
			AND RecentOfferStatusInformation.LastUpdateDate = (Select Max(LastUpdateDate) From TcssRecipientOfferStatusInformation Where TcssRecipientId = tr.TcssRecipientId)
		)
	LEFT JOIN TcssDonorContactInformation trdi ON trdi.TcssDonorId = td.TcssDonorId
	LEFT JOIN dbo.Call c ON troi.CallId = c.CallId
	LEFT JOIN dbo.Referral r ON troi.CallId = r.CallId
where c.callid = @callNumber AND 	CallActive = 1) as IsOasis
from call  

end
go