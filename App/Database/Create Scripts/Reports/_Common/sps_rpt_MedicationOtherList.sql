IF EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = object_id(N'[dbo].[sps_rpt_MedicationOtherList]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_MedicationOtherList';
		DROP  PROCEDURE  sps_rpt_MedicationOtherList;
	END
GO

PRINT 'Creating Procedure: sps_rpt_MedicationOtherList';
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

CREATE PROCEDURE [dbo].[sps_rpt_MedicationOtherList]
(
     @CallID			int			= NULL,
     @MedicationType	varchar(100)= NULL
)
AS
/******************************************************************************
**	File: sps_rpt_MedicationOtherList.sql
**	Name: sps_rpt_MedicationOtherList
**	Desc: This stored procedure returns a list of either antibiotics, steroids or
**	   all medications for a given callID (See usage examples below.)
**	
**	
**	Return values:
**	
**	Called by: Sub Report: ReferralDetail_MedicationsOther.rdl
**	Parent Report: ReferralDetail_Secondary.rdl
**	
**	Parameters:
**	Input							Output
**	----------						-----------
**	@CallID			int
**	@MedicationType	varchar(100)
**	
**	Auth: christopher carroll
**	Date: 03/22/2007
**	
**	Usage Examples:
**	1.) sps_rpt_MedicationsList 5810711     -- Returns All
**	2.) sps_rpt_MedicationsList 5810711,'antibiotics'  -- Returns antibiotics only
**	3.) sps_rpt_MedicationsList 5810711,'steroids'  -- Returns steroids only
**	
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:				Description:
**	--------	--------			-------------------------------------------
**	06/20/2007	ccarroll			Initial release
**	10/02/2008	ccarroll			Adde select sproc for Archive and Production db
**	08/04/2020	James Gerberich		Refactored. VS 69297
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT
	SecondaryMedicationOtherName AS 'Name',
	SecondaryMedicationOtherTypeUse AS 'Type',
	SecondaryMedicationOtherDose AS 'Dose',
	CONVERT(varchar, SecondaryMedicationOtherStartDate, 101) AS 'StartDate',
	CONVERT(varchar, SecondaryMedicationOtherEndDate, 101) AS 'EndDate'
FROM
   SecondaryMedicationOther
WHERE
	CallID = @CallID
AND	(
		@MedicationType IS NULL
	OR	SecondaryMedicationOtherTypeUse = @MedicationType
	);

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
