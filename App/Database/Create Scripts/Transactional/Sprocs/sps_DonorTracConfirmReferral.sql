 SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorTracConfirmReferral]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		drop procedure [dbo].[sps_DonorTracConfirmReferral]
		PRINT 'Dropping sps_DonorTracConfirmReferral' 
	END
PRINT 'Creating sps_DonorTracConfirmReferral' 
GO


CREATE PROCEDURE sps_DonorTracConfirmReferral
		@vUserName AS VARCHAR(50),
		@vPassWord AS VARCHAR(50),
		@CallID AS VARCHAR(20)
AS
/******************************************************************************
**		File: sps_DonorTracConfirmReferral.sql
**		Name: sps_DonorTracConfirmReferral
**		Desc: 
**			Confirms DonorTrac Received a Referral
**
**              
**		Returns: 1 if sucessful
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@vUserName as varchar(50),
**		@vPassWord as varchar(50),
**		@CallID as 
**  
**		Auth: Bret Knoll
**		Date: 2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**		03/29/10	Bret Knoll			Confirm DT received a referral
**      09/2011     jth					added lsa d/t fields
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
DECLARE 
	@returnValue int,
	@DTSTATUSERID int = 1553,
	@MODIFYID int = 3,
	@RECEIVEDBYDT int = 1;

set @returnValue = 0;
-- confirm the user has access to the Referral
IF(EXISTS(
	select Call.CallID
	FROM Call 
	JOIN Referral ON Call.CallID = Referral.CallID
	JOIN (SELECT 		
			SourceCodeID, 
			OrgID
		FROM dbo.fn_GetStatInfoReportWebGroups 
		(
		@vUserName)) fn ON fn.sourcecodeid =Call.sourcecodeid and fn.orgid = ReferralCallerOrganizationID
	WHERE Call.CallID = @CallID )
	)
BEGIN
	
	--update that donortrac received it		
	UPDATE dbo.Referral
	set UnusedField1 = @RECEIVEDBYDT,
		UnusedField3 = @RECEIVEDBYDT,
		LastStatEmployeeID = @DTSTATUSERID,
		AuditLogTypeID = @MODIFYID,
		LastModified = getDate()
	WHERE CallId = @CallId;	

	SET @returnValue = 1;
END

RETURN @returnValue;




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

