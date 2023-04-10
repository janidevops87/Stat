IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupInvalidDOB]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spu_IMPORT_A_DataCleanupInvalidDOB];
END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


-- sp_helptext IMPORT_DataCleanupInvalidDOB
CREATE PROCEDURE spu_IMPORT_A_DataCleanupInvalidDOB AS
/******************************************************************************
**		File: spu_IMPORT_A_DataCleanupInvalidDOB.sql
**		Name: spu_IMPORT_A_DataCleanupInvalidDOB
**		Desc: Removes records with invallid DOB and puts them in Suspense
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
**		Auth: Christopher Carroll	
**		Date: 01/23/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		01/23/2007		Christopher Carroll		initial release
**		05/28/2014		Moonray Schepart		Include Branch Number and Enrollment Date fields 
**		09/08/2015		mmaitan					Adding comment to force the script generator to pick up this script
*******************************************************************************/

DECLARE @suspect varchar(255);

SELECT @suspect = 'Invalid Date of Birth IMPORT_A'
BEGIN TRANSACTION IMPORT_A
  INSERT SUSPENSE_A
  SELECT IMPORTLOGID,LAST,FIRST,MIDDLE,SUFFIX,AADDR1,ACITY,ASTATE,AZIP,BADDR1,BCITY,BSTATE,BZIP,DOB,GENDER,LICENSE,DONOR,RENEWALDATE,DECEASEDDATE,CSORSTATE,CSORLICENSE,FULLNAME, 0, @suspect, enrollmentdate, branchnumber
  FROM IMPORT_A
  WHERE COALESCE(DOB,'') = '';

  UPDATE IMPORTLOG
  SET RecordsSuspended = RecordsSuspended + @@rowcount
  WHERE RunStatus = 'LOADING';

  DELETE FROM IMPORT_A
  WHERE COALESCE(DOB,'') = '';

COMMIT TRANSACTION IMPORT_A;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spu_IMPORT_A_DataCleanupInvalidDOB create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spu_IMPORT_A_DataCleanupInvalidDOB Created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/

