if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_MessageDetail_EventLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_MessageDetail_EventLog'
		DROP  Procedure  sps_rpt_MessageDetail_EventLog
	END

GO

PRINT 'Creating Procedure sps_rpt_MessageDetail_EventLog'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_MessageDetail_EventLog
     @CallID            int          = null,
     @DisplayMT			int			 = null
AS
/******************************************************************************
**		File: sps_rpt_MessageDetail_EventLog.sql
**		Name: sps_rpt_MessageDetail_EventLog
**		Desc: This sproc returns log event notes for ReferralDetail report
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		10/01/2008	ccarroll			Added selection for Archive data
**		12/03/2012	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */  

--/*Null out dates if call id is populated */
--IF ISNULL(@CallID,0) <> 0
--    BEGIN

--		/* determine if CallID is in Production db */
--		IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
--			BEGIN /* production database */
--				SET @Source_DB = 1
--			END
--		ELSE
--			BEGIN /* Archive database */
--				SET @Source_DB = 2
--			END
--END


--	IF @Source_DB = 2
--				BEGIN
--					/* run in Archive database only */	
--						EXEC _ReferralProdArchive..sps_rpt_MessageDetail_EventLog_Select @CallID, @DisplayMT
--				END

--	IF @Source_DB = 1
--			BEGIN	/* run in production database only */
				EXEC sps_rpt_MessageDetail_EventLog_Select @CallID, @DisplayMT
			--END

 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 