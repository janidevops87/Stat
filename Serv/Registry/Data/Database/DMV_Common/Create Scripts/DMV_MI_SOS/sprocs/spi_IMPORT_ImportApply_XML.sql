IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spi_IMPORT_ImportApply_XML]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spi_IMPORT_ImportApply_XML];
END
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE  PROCEDURE spi_IMPORT_ImportApply_XML AS

DECLARE @ImportLogID int
SELECT @ImportLogID = (SELECT MAX(ID) FROM IMPORTLOG WHERE RunStatus = 'LOADING')

/******************************************************************************
**		File: spi_IMPORT_ImportApply_XML.sql
**		Name: spi_IMPORT_ImportApply_XML
**		Desc: Move data into Import_A for data clean-up. Also check for extended zip code and
**		   add '-' if required. All records from SOS are donors.
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Chris Carroll	
**		Date: 01/29/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**		01/29/2007		Chris Carroll			initial release
**		05/28/2014		Moonray Schepart		Include Branch Number and Enrollment Date fields
**		09/08/2015		mmaitan					Adding comment to force the script generator to pick up this script
*******************************************************************************/

INSERT IMPORT_A(IMPORTLOGID, AADDR1, ACITY, ASTATE, AZIP, DOB, DONOR, FULLNAME, enrollmentdate, branchnumber)
SELECT	@ImportLogID,
	address,
	city,
	state,
	zipcode + CASE WHEN zipcode_extension IS NOT NULL THEN '-' ELSE '' END + ISNULL(zipcode_extension,'') AS zipcode,
	Birthdate,
	'Y',
	name, 
	enrollmentdate, 
	branchnumber

FROM  Import_XML;


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spi_IMPORT_ImportApply_XML create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spi_IMPORT_ImportApply_XML Created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/


