IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetReferralInfo]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetReferralInfo]
	PRINT 'Dropping Procedure: GetReferralInfo'
END
	PRINT 'Creating Procedure: GetReferralInfo'
GO

CREATE PROCEDURE [dbo].[GetReferralInfo]
(
	@CallID int = NULL,
	@WebReportGroupID int = null
)
/******************************************************************************
**		File: GetReferralInfo.sql
**		Name: GetReferralInfo
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/2009		jth			initial
**	   04/2010		bret			updating to include in release
**      04/10       jth          if report group id is 37, accept all
**	   04/16/2012	ccarroll	Fixed issue not returning Message/Import Call Types
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
	 

	SELECT	Call.CallDateTime,
			SourceCode.SourceCodeName,
			Call.CallID,
			CallType.CallTypeName,
            ISNULL(MessageType.MessageTypeID, Referral.ReferralTypeID) AS ReferralTypeID1,
			ISNULL(MessageType.MessageTypeName, ReferralType.ReferralTypeName) AS ReferralTypeName
	FROM        
			Call
			JOIN CallType ON CallType.CallTypeID = Call.CallTypeID
			JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
			LEFT JOIN Referral ON Referral.CallID = Call.CallID
			LEFT JOIN ReferralType ON Referral.ReferralTypeID =  ReferralType.ReferralTypeID
			LEFT JOIN [Message] ON [Message].CallID = Call.CallID
			LEFT JOIN MessageType ON [Message].MessageTypeID = MessageType.MessageTypeID				 
	WHERE 
		Call.CallID = @CallID 

	RETURN @@Error
GO


  