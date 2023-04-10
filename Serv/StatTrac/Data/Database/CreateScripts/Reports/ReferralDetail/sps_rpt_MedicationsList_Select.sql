if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_MedicationsList_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_MedicationsList_Select'
		DROP  Procedure  sps_rpt_MedicationsList_Select
	END

GO

PRINT 'Creating Procedure: sps_rpt_MedicationsList_Select'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_MedicationsList_Select
     @CallID             int          = null

AS
/******************************************************************************
**		File: sps_rpt_MedicationsList_Select.sql
**		Name: sps_rpt_MedicationsList_Select
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
**		Date:		Author:				Description:
**		--------		--------		-------------------------------------------
**      6/20/2007		ccarroll		Inital release
**		10/02/2008		ccarroll		Added select sproc for Archive and Production db
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

     SELECT
			MedicationName AS 'MedicationsList'
     FROM
			Medication
     JOIN
			SecondaryMedication ON SecondaryMedication.MedicationID = Medication.MedicationID
     WHERE
			SecondaryMedication.CallID = @CallID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

