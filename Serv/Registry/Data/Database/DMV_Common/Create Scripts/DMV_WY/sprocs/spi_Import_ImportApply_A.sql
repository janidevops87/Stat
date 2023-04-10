 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_Import_ImportApply_A')
	BEGIN
		PRINT 'Dropping Procedure spi_Import_ImportApply_A'
		DROP  Procedure  spi_Import_ImportApply_A
	END

GO

PRINT 'Creating Procedure spi_Import_ImportApply_A'
GO
CREATE Procedure spi_Import_ImportApply_A
	
AS

/******************************************************************************
**		File: 
**		Name: spi_Import_ImportApply_A
**		Desc: This stored procedure moves records from the staging table in Import_A to the Import table
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**      							-----------
**
**
**		Auth: unknown
**		Date: unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		09/05/2007  Thien Ta 			Added code for PreviousDonorStatus	 
**      
*******************************************************************************/
 


update IMPORT
set DECEASEDDATE = a.DECEASEDDATE,
    CSORSTATE    = a.CSORSTATE,
    CSORLICENSE  = a.CSORLICENSE
from IMPORT i, IMPORT_A a
where i.LICENSE = a.LICENSE
insert IMPORT(IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE)
select        IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE
from IMPORT_A
where LICENSE NOT IN (select LICENSE
                      from IMPORT)

--Update the Import table with PreviousDonorState
UPDATE
	Import
SET 
	PreviousDonorState = DMV.Donor
FROM 
	DMV
WHERE 
	DMV.License = Import.License
GO

GO



GRANT EXEC ON spi_Import_ImportApply_A TO PUBLIC

GO
