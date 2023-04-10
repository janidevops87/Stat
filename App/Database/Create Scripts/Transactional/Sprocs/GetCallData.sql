IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetCallData')
	BEGIN
		PRINT 'Dropping Procedure GetCallData'
		DROP  Procedure  GetCallData
	END

GO

PRINT 'Creating Procedure GetCallData'
GO
CREATE Procedure GetCallData
	@CallID INT

AS

/******************************************************************************
**		File: GetCallData.sql
**		Name: GetCallData
**		Desc: Gets Call data
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: ccarroll	
**		Date: 11/01/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/01/2008	ccarroll	
**      03/09       jth                 add code to get if call is asp...0 if not
**		05/18/2011  ccarroll			Fixed Ambiguous column issue from prev revision
**		06/21/2011	ccarroll			Fixed issues caused by table join to ASPSourceCodeMap	
*******************************************************************************/

SELECT
	CallID,
	CallNumber,
	CallTypeID,
	CallDateTime,
	StatEmployeeID,
	CallTotalTime,
	CallTempExclusive,
	Inactive,
	CallSeconds,
	Call.LastModified,
	CallTemp,
	Call.SourceCodeID,
	CallOpenByID,
	CallTempSavedByID,
	CallExtension,
	UpdatedFlag,
	CallOpenByWebPersonId,
	RecycleNCFlag,
	CallActive,
	CallSaveLastByID,
	Call.AuditLogTypeID, 
    MIN(ISNULL(AspSourceCodeMap.AspSourceCodeID, 0)) AS ASP
FROM  Call LEFT OUTER JOIN
      AspSourceCodeMap ON Call.SourceCodeID = AspSourceCodeMap.SourceCodeID
WHERE 
	Call.CallID = @CallID
GROUP BY
	CallID,
	CallNumber,
	CallTypeID,
	CallDateTime,
	StatEmployeeID,
	CallTotalTime,
	CallTempExclusive,
	Inactive,
	CallSeconds,
	Call.LastModified,
	CallTemp,
	Call.SourceCodeID,
	CallOpenByID,
	CallTempSavedByID,
	CallExtension,
	UpdatedFlag,
	CallOpenByWebPersonId,
	RecycleNCFlag,
	CallActive,
	CallSaveLastByID,
	Call.AuditLogTypeID
GO

