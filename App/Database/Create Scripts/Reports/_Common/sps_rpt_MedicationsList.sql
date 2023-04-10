IF EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = object_id(N'[dbo].[sps_rpt_MedicationsList]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_MedicationsList';
		DROP  PROCEDURE  sps_rpt_MedicationsList;
	END;
GO

PRINT 'Creating Procedure: sps_rpt_MedicationsList';
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

CREATE PROCEDURE [dbo].[sps_rpt_MedicationsList]
(
	@CallID	int	= NULL
)
AS
/******************************************************************************
**	File: sps_rpt_MedicationsList.sql
**	Name: sps_rpt_MedicationsList
**	Desc: This stored procedure returns a list of (secondary) medications for
**			the given CallID (See usage example below.)
**	
**	Return values:
**	
**	Called by: Sub report: ReferralDetail_Medications.rdl
**	Parent Report: ReferralDetail_Secondary.rdl
**	
**	Parameters:
**	Input			Output
**	----------		-----------
**	@CallID int
**	
**	Auth: christopher carroll
**	Date: 03/22/2007
**	Usage example: sps_rpt_MedicationsList 58111035
**	
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		-------------------------------------------
**	6/20/2007	ccarroll		Inital release
**	10/02/2008	ccarroll		Added select sproc for Archive and Production db
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT MedicationName AS 'MedicationsList'
FROM
	Medication
	JOIN SecondaryMedication ON SecondaryMedication.MedicationID = Medication.MedicationID
WHERE SecondaryMedication.CallID = @CallID;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
