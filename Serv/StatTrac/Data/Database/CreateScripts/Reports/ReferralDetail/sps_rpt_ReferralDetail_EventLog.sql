if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ReferralDetail_EventLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_ReferralDetail_EventLog'
		DROP  Procedure  sps_rpt_ReferralDetail_EventLog
	END

GO

PRINT 'Creating Procedure: sps_rpt_ReferralDetail_EventLog'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_ReferralDetail_EventLog
     @CallID            int          = null,
     @DisplayMT			int			 = null

AS

/******************************************************************************
**		File: sps_rpt_ReferralDetail_EventLog.sql
**		Name: sps_rpt_ReferralDetail_EventLog
**		Desc: This sproc returns log event notes for ReferralDetail report
**
**              
**		Return values:
** 
**		Called by: ReferralDetail.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@CallID		int
**		@DisplayMT	int

**
**		Auth: christopher carroll  
**		Date: 06/14/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      6/20/2007		ccarroll				Initial release
**		6/21/2007		ccarroll				StatTrac 8.4 release, deleted events
**		11/14/2007		ccarroll				updates for converting date/time
**		10/02/2008		ccarroll				Added selection for Archive data
**		12/03/2012		James Gerberich			Archive database is being turned off, so
**												this sproc is modified to eliminate
**												the database selection
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */

	--/* Is CallID in production db? */
	--IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
	--	BEGIN /* Production database */
	--		SET @Source_DB = 1
	--	END
	--ELSE
	--	BEGIN /* Archive database */
	--		SET @Source_DB = 2
	--	END


	--/* Database Selection */
	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */	
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralDetail_EventLog_Select
	--					 @CallID,
	--					 @DisplayMT
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
						EXEC sps_rpt_ReferralDetail_EventLog_Select
						 @CallID,
						 @DisplayMT
			--END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

