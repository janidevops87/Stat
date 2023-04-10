if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_MedicationOtherList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_MedicationOtherList'
		DROP  Procedure  sps_rpt_MedicationOtherList
	END

GO

PRINT 'Creating Procedure: sps_rpt_MedicationOtherList'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_MedicationOtherList
     @CallID             int          = null,
     @MedicationType	 varchar(100) = null

AS
/******************************************************************************
**		File: sps_rpt_MedicationOtherList.sql
**		Name: sps_rpt_MedicationOtherList
**		Desc: This stored procedure returns a list of either antibiotics, steroids or
**			  all medications for a given callID (See usage examples below.)
**
**              
**		Return values:
** 
**		Called by: Sub Report: ReferralDetail_MedicationsOther.rdl
**				Parent Report: ReferralDetail_Secondary.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**      @CallID         int
**	    @MedicationType	varchar(100)
**
**		Auth: christopher carroll  
**		Date: 03/22/2007
**
**	Usage Examples:
**	1.) sps_rpt_MedicationsList 5810711					-- Returns All
**	2.) sps_rpt_MedicationsList 5810711,'antibiotics' 	-- Returns antibiotics only
**	3.) sps_rpt_MedicationsList 5810711,'steroids'		-- Returns steroids only
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**		10/02/2008		ccarroll			Added selection for Archive data
**		12/03/2012		James Gerberich		Archive database is being turned off, so
**											this sproc is modified to eliminate
**											the database selection
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
--						EXEC _ReferralProdArchive..sps_rpt_MedicationOtherList_Select
--						 @CallID,
--						 @MedicationType
--				END

--	IF @Source_DB = 1
--			BEGIN	/* run in production database only */
						EXEC sps_rpt_MedicationOtherList_Select
						 @CallID,
						 @MedicationType
			--END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

