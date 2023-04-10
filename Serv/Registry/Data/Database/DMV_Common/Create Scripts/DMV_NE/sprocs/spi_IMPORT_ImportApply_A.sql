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
/******************************************************************************
**		File: spi_IMPORT_ImportApply_A.sql
**		Name: spi_IMPORT_ImportApply_A
**		Desc:  
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 09/16/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		09/16/2009	ccarroll			initial
**		10/28/2009	ccarroll			applied field limitations because of DMV data received
**		07/29/2014	Moonray Schepart	Added FullName
**		12/15/2016	Michael Maitan		Added a variable to assign the current IMPORTLOGID to fix suspend reports
*******************************************************************************/
CREATE PROCEDURE [dbo].[spi_IMPORT_ImportApply_A] AS

declare @IMPORTLOGID int

select @IMPORTLOGID = ID
from IMPORTLOG
where upper(RunStatus) = 'LOADING'

UPDATE IMPORT
SET DECEASEDDATE = a.DECEASEDDATE,
    CSORSTATE    = a.CSORSTATE,
    CSORLICENSE  = a.CSORLICENSE
FROM IMPORT i, IMPORT_A a
WHERE i.LICENSE = a.LICENSE;

INSERT IMPORT(IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSETYPE, LICENSE, DONOR, ISSUEDATE, RENEWALDATE, CSORSTATE, CSORLICENSE, RaceDMVCode, SendInfoFlag, LAST_Display, FIRST_Display, MIDDLE_Display)
SELECT        @IMPORTLOGID, LEFT(LAST, 25), LEFT(FIRST, 20), LEFT(MIDDLE, 20), LEFT(SUFFIX, 4), AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSETYPE, LICENSE, DONOR, CONVERT(varchar,ISSUEDATE, 101), CONVERT(varchar,EXPIRATIONDATE, 101), CSORSTATE, CSORLICENSE, RaceDMVCode, CASE WHEN LEFT(SendInfoFlag, 1) = 'Y' THEN 1 ELSE 0 END, LAST_Display, FIRST_Display, MIDDLE_Display
FROM IMPORT_A
/*where LICENSE NOT IN (select LICENSE
                      from IMPORT)
*/
