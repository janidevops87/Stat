IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetCallInformation')
	BEGIN
		PRINT 'Dropping Procedure GetCallInformation'
		DROP  Procedure  GetCallInformation
	END

GO

PRINT 'Creating Procedure GetCallInformation'
GO
CREATE Procedure GetCallInformation
	@CallID int = 0
AS

/******************************************************************************
**		File: GetCallInformation
**		Name: GetCallInformation.sql
**		Desc: This sproc returns basic information about the Call, i.e., 
**			  existance of CallID and person who has the call open. 
**
**              
**		Return values:
** 
**		Called by modStatRefQuery.RefQueryCall from the following modules/functions:
**		1.  FrmOpenAll.CmdRestoreReferral_Click()
**		2.  FrmOpenAll.CmdRestoreMessage_Click()
**		3.  FrmOpenAll.LstViewCallouts_DblClick()
**		4.  FrmOpenAll.LstViewIncompletes_DblClick()
**		5.  FrmOpenAll.LstViewOpenReferral_DblClick()
**		6.  FrmOpenAll.LstViewSecondary_DblClick()
**		7.  FrmOpenAll.LstViewSecondaryAlert_DblClick()
**		8.  ModStatSave.SaveCall()
**		9.  FrmReferralView.CmdCancel_Click()
**		10. FrmReferral.Form_unload
**		11. modControl.CheckCallOpen(pvForm)
**		12. FrmMessage.Form_Unload
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: ccarroll
**		Date: 02/22/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		02/22/2008		ccarroll			initial
*******************************************************************************/

	SELECT 
			Call.CallID,
			Call.CallNumber,
			Call.CallTypeID,
			Call.StatEmployeeID,
			Call.RecycleNCFlag,
			Call.CallOpenByID
	FROM	Call

	WHERE	Call.CallID = @CallID


GO

GRANT EXEC ON GetCallInformation TO PUBLIC

GO
