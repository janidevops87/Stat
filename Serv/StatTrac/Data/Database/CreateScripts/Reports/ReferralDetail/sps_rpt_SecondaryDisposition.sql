if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_SecondaryDisposition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_SecondaryDisposition'
		DROP  Procedure  sps_rpt_SecondaryDisposition
	END

GO

PRINT 'Creating Procedure: sps_rpt_SecondaryDisposition'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_SecondaryDisposition
     @CallID             int          = null

AS
/******************************************************************************
**		File: sps_rpt_SecondaryDisposition.sql
**		Name: sps_rpt_SecondaryDisposition
**		Desc: This stored procedure returns a list of (secondary) dispositions for
**			  given CallID and is an option for display in ReferralDetail
**
**              
**		Return values:
** 
**		Called by: ReferralDetail_Secondary.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@CallID
**
**		Auth: christopher carroll  
**		Date: 06/13/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**      6/20/2007		ccarroll				Initial release
**		05/07/2008		ccarroll				Added Triage Appropriate values Per StatTrac view
**		05/08/2008		ccarroll				Added Sub_Precedence for displaying Case Order sequence
**		10/02/2008		ccarroll				Added selection for Archive data
**      10/09/2009      jth                     Now call sps_rpt_SecondaryDisposition_Select1
**		12/03/2012		James Gerberich			Archive database is being turned off, so
**												this sproc is modified to eliminate
**												the database selection
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */

--	/* Is CallID in production db? */
--	IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
--		BEGIN /* Production database */
--			SET @Source_DB = 1
--		END
--	ELSE
--		BEGIN /* Archive database */
--			SET @Source_DB = 2
--		END


--	/* Database Selection */
--	IF @Source_DB = 2
--				BEGIN
--					/* run in Archive database only */	
--						EXEC _ReferralProdArchive..sps_rpt_SecondaryDisposition_Select1 @CallID
--				END

--	IF @Source_DB = 1
--			BEGIN	/* run in production database only */
						EXEC sps_rpt_SecondaryDisposition_Select1 @CallID
			--END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
