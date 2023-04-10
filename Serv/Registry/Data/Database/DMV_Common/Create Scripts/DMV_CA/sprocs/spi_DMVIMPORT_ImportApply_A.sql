if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_DMVIMPORT_ImportApply_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spi_DMVIMPORT_ImportApply_A'
	drop procedure [dbo].[spi_DMVIMPORT_ImportApply_A]
End
GO

	PRINT 'Creating spi_DMVIMPORT_ImportApply_A'
GO


CREATE      PROCEDURE spi_DMVIMPORT_ImportApply_A AS
/******************************************************************************
**		File: spi_DMVIMPORT_ImportApply_A.sql
**		Name: spi_DMVIMPORT_ImportApply_A
**		Desc: Used to update new records
**             
**		Return values:
**
**		Called by:  
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**
**		Auth: christopher carroll
**		Date: 10/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/10/2007  ccarroll			initial
*******************************************************************************/
UPDATE DMVIMPORT
SET DECEASEDDATE = a.DECEASEDDATE,
    CSORSTATE    = a.CSORSTATE,
    CSORLICENSE  = a.CSORLICENSE

FROM DMVIMPORT i, DMVIMPORT_A a
WHERE i.LICENSE = a.LICENSE
INSERT  DMVIMPORT(
		DMVIMPORTLOGID,
		CAID,
		LAST,
		FIRST,
		MIDDLE,
		SUFFIX,
		FULLNAME,
		AADDR1,
		ACITY,
		ASTATE,
		AZIP,
		BADDR1,
		BCITY,
		BSTATE,
		BZIP,
		DOB,
		GENDER,
		LICENSE,
		DONOR,
		COUNTYCODE,
		IMPORTDATE,
		DECEASEDDATE,
		CSORSTATE,
		CSORLICENSE,
		CREATEDATE)

SELECT		DMVIMPORTLOGID,
		CAID,
		LAST,
		FIRST,
		MIDDLE,
		SUFFIX,
		FULLNAME,
		AADDR1,
		ACITY,
		ASTATE,
		AZIP,
		BADDR1,
		BCITY,
		BSTATE,
		BZIP,
		DOB,
		GENDER,
		LEFT(LICENSE, 9),
		DONOR,
		COUNTY_CODE,
		IMPORTDATE,
		DECEASEDDATE,
		CSORSTATE,
		CSORLICENSE,
		NULL
FROM DMVIMPORT_A
WHERE LEFT(LICENSE,9) NOT IN (SELECT LICENSE FROM DMVIMPORT)


GO


