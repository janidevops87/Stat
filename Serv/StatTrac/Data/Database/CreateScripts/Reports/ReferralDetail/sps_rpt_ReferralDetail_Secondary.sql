if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ReferralDetail_Secondary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_ReferralDetail_Secondary'
		DROP  Procedure  sps_rpt_ReferralDetail_Secondary
	END

GO

PRINT 'Creating Procedure: sps_rpt_ReferralDetail_Secondary'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_ReferralDetail_Secondary
     @CallID            int          = null,
     @DisplayMT			int			 = null

AS
/******************************************************************************
**		File: sps_rpt_ReferralDetail_Secondary.sql
**		Name: sps_rpt_ReferralDetail_Secondary
**		Desc:	This stored procedure returns Secondary Information to 
**				ReferralDetail_Secondary report where @CallID and @TZ values are 
**				returned from sps_rpt_ReferralDetail_Triage
**              
**		Return values:
** 
**		Called by: ReferralDetail_Secondary.rdl
**		Parent Report: ReferralDetail.rdl
		Parent Sproc: sps_rpt_ReferralDetail_Triage   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**      @CallID         int
**      @TZ				varchar(2)
**
**		Auth: christopher carroll  
**		Date: 03/27/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		6/20/2007		ccarroll				Initial release  
**		11/14/2007		ccarroll				removed @TZ ref
**		09/30/2008		ccarroll				Added selection for Archive and Production data
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
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralDetail_Secondary_Select
	--						@CallID,
	--						@DisplayMT 
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
						EXEC sps_rpt_ReferralDetail_Secondary_Select
							@CallID,
							@DisplayMT
			--END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

