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
**		Desc:  NEOB DMV_ME Import
**
**		Called by:  DTS
**              
**
**		Auth: ccarroll
**		Date: 06/11/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		06/11/2009	ccarroll	initial
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
UPDATE IMPORT
	SET DECEASEDDATE = a.DECEASEDDATE,
		CSORSTATE    = a.CSORSTATE,
		CSORLICENSE  = a.CSORLICENSE
FROM IMPORT i, IMPORT_A a
WHERE i.LICENSE = a.LICENSE


insert IMPORT(IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE)
select        IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE
from IMPORT_A
where LICENSE NOT IN (select LICENSE from IMPORT)

--Update the Import table with PreviousDonorState
UPDATE
	Import
SET 
	PreviousDonorState = DMV.Donor
FROM 
	DMV
WHERE 
	DMV.License = Import.License
