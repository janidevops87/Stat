IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_sub_ReferralDisposition')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_sub_ReferralDisposition'
		DROP  Procedure  sps_rpt_sub_ReferralDisposition
	END

GO

PRINT 'Creating Procedure sps_rpt_sub_ReferralDisposition'
GO
CREATE Procedure sps_rpt_sub_ReferralDisposition
	@CallID						int = Null,
	@UserOrgID					int = Null
AS
/******************************************************************************
**		File: sps_rpt_sub_ReferralDisposition.sql
**		Name: sps_rpt_sub_ReferralDisposition
**
**		Desc: This is sub-report displays disposition from a referral
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@CallID		int
**		@UserOrgID		int
**
**		Auth: christopher carroll
**		Date: 09/06/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      09/06/2007		ccarroll			Initial release
**		09/30/2008		ccarroll			Added selection for Archive and Production data
**		12/03/2012		James Gerberich		Archive database is being turned off, so
**											this sproc is modified to eliminate
**											the database selection
*******************************************************************************/

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
	--					EXEC _ReferralProdArchive..sps_rpt_sub_ReferralDisposition_Select
	--						@CallID,
	--						@UserOrgID 
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
						EXEC sps_rpt_sub_ReferralDisposition_Select
							@CallID,
							@UserOrgID 
			--END


GO

