  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_IMPORT_ImportApply_A]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spi_IMPORT_ImportApply_A]
	PRINT 'Dropping Procedure: spi_IMPORT_ImportApply_A'
END
	PRINT 'Creating Procedure: spi_IMPORT_ImportApply_A'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spi_IMPORT_ImportApply_A]
/******************************************************************************
**		File: spi_IMPORT_ImportApply_A.sql
**		Name: spi_IMPORT_ImportApply_A
**		Desc:  NEOB DMV_NH Import
**
**		Called by:  DTS
**              
**
**		Auth: ccarroll
**		Date: 06/12/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		06/12/2009	ccarroll	initial 
**		09/28/2009	ccarroll	added LEFT statements for bad Data
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
update IMPORT
set DECEASEDDATE = a.DECEASEDDATE,
    CSORSTATE    = a.CSORSTATE,
    CSORLICENSE  = a.CSORLICENSE
from IMPORT i, IMPORT_A a
where i.LICENSE = a.LICENSE

insert IMPORT(IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE)
select        IMPORTLOGID, LEFT(LAST, 25), LEFT(FIRST, 20), LEFT(MIDDLE, 20), LEFT(SUFFIX, 4), LEFT(AADDR1, 40), LEFT(ACITY, 25), LEFT(ASTATE, 2), LEFT(AZIP, 10), LEFT(BADDR1, 40), LEFT(BCITY, 25), LEFT(BSTATE, 2), LEFT(BZIP, 10), DOB, LEFT(GENDER, 1), LEFT(LICENSE,10), LEFT(DONOR, 1), RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE
from IMPORT_A
where LEFT(LICENSE,10) NOT IN (select LEFT(LICENSE,10)
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
