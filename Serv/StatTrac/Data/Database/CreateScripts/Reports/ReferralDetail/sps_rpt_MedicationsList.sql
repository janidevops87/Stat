if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_MedicationsList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_MedicationsList'
		DROP  Procedure  sps_rpt_MedicationsList
	END

GO

PRINT 'Creating Procedure: sps_rpt_MedicationsList'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_MedicationsList
     @CallID             int          = null

AS
/******************************************************************************
**		File: sps_rpt_MedicationsList.sql
**		Name: sps_rpt_MedicationsList
**		Desc: This stored procedure returns a list of (secondary) medications for
**			  the given CallID (See usage example below.) 
**
**		Return values:
** 
**		Called by: Sub report: ReferralDetail_Medications.rdl
**		Parent Report: ReferralDetail_Secondary.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@CallID int,
**
**		Auth: christopher carroll  
**		Date: 03/22/2007
**		Usage example:
**		sps_rpt_MedicationsList 58111035

**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      6/20/2007		ccarroll			Inital release
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
--						EXEC _ReferralProdArchive..sps_rpt_MedicationsList_Select @CallID
--				END

--	IF @Source_DB = 1
--			BEGIN	/* run in production database only */
						EXEC sps_rpt_MedicationsList_Select @CallID
			--END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

