if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_MedicationOtherList_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_MedicationOtherList_Select'
		DROP  Procedure  sps_rpt_MedicationOtherList_Select
	END

GO

PRINT 'Creating Procedure: sps_rpt_MedicationOtherList_Select'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_MedicationOtherList_Select
     @CallID             int          = null,
     @MedicationType	 varchar(100) = null

AS
/******************************************************************************
**		File: sps_rpt_MedicationOtherList_Select.sql
**		Name: sps_rpt_MedicationOtherList_Select
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
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		6/20/2007		ccarroll				Initial release 
**		10/02/2008		ccarroll				Adde select sproc for Archive and Production db    
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

     SELECT
			SecondaryMedicationOtherName AS 'Name',
			SecondaryMedicationOtherTypeUse AS 'Type',
			SecondaryMedicationOtherDose AS 'Dose',
			convert(varchar, SecondaryMedicationOtherStartDate, 101) AS 'StartDate',
			convert(varchar, SecondaryMedicationOtherEndDate, 101) AS 'EndDate'

     FROM
			SecondaryMedicationOther
     WHERE
			CallID = @CallID
     AND
			SecondaryMedicationOtherTypeUse = ISNULL(@MedicationType, SecondaryMedicationOtherTypeUse)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

