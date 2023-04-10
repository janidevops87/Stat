IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupInvalidSuffix]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[sps_IMPORT_A_DataCleanupInvalidSuffix];
END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE  PROCEDURE sps_IMPORT_A_DataCleanupInvalidSuffix AS
/******************************************************************************
**		File: sps_IMPORT_A_DataCleanupInvalidSuffix.sql
**		Name: sps_IMPORT_A_DataCleanupInvalidSuffix
**		Desc: 
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
**		Auth: Michael Maitan
**		Date: 12/19/2016
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**		12/19/2016		mmaitan				Initial add.
*******************************************************************************/
DECLARE @suspect varchar(255)
SELECT @suspect = 'Invalid Suffix IMPORT_A'
BEGIN TRANSACTION IMPORT_A
  INSERT SUSPENSE_A
  SELECT IMPORTLOGID,LAST,FIRST,MIDDLE,SUFFIX,AADDR1,ACITY,ASTATE,AZIP,BADDR1,BCITY,BSTATE,BZIP,DOB,GENDER,LICENSE,DONOR,RENEWALDATE,DECEASEDDATE,CSORSTATE,CSORLICENSE,FULLNAME, 0, @suspect , enrollmentdate, branchnumber
  FROM IMPORT_A
  WHERE LEN(SUFFIX) > 15;

  UPDATE IMPORTLOG
  SET RecordsSuspended = RecordsSuspended + @@rowcount
  WHERE RunStatus = 'LOADING';

  DELETE FROM IMPORT_A
  WHERE LEN(SUFFIX) > 15;

COMMIT TRANSACTION IMPORT_A;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - sps_IMPORT_A_DataCleanupInvalidSuffix create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure sps_IMPORT_A_DataCleanupInvalidSuffix created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/

