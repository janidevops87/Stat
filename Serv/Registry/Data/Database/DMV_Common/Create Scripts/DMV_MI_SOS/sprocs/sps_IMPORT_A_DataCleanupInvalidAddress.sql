IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupInvalidAddress]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[sps_IMPORT_A_DataCleanupInvalidAddress];
END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE  PROCEDURE sps_IMPORT_A_DataCleanupInvalidAddress AS
/******************************************************************************
**		File: sps_IMPORT_A_DataCleanupInvalidAddress.sql
**		Name: sps_IMPORT_A_DataCleanupInvalidAddress
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
**		Auth: Moonray Schepart	
**		Date: 05/28/2014
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**		05/28/2014		Moonray Schepart		initial release
**		05/28/2014		Moonray Schepart		Include Branch Number and Enrollment Date fields 
**		09/08/2015		mmaitan					Adding comment to force the script generator to pick up this script
*******************************************************************************/
DECLARE @suspect varchar(255)
SELECT @suspect = 'Invalid Address IMPORT_A'
BEGIN TRANSACTION IMPORT_A
  INSERT SUSPENSE_A
  SELECT IMPORTLOGID,LAST,FIRST,MIDDLE,SUFFIX,AADDR1,ACITY,ASTATE,AZIP,BADDR1,BCITY,BSTATE,BZIP,DOB,GENDER,LICENSE,DONOR,RENEWALDATE,DECEASEDDATE,CSORSTATE,CSORLICENSE,FULLNAME, 0, @suspect , enrollmentdate, branchnumber
  FROM IMPORT_A
  WHERE (
	(COALESCE(AADDR1,'') ='' )
   OR   (COALESCE(ACITY,'') = '' )
   OR 	(COALESCE(ACITY,'') LIKE '%[0-9]%')
   OR   (COALESCE(ASTATE,'') = '')
   OR   (COALESCE(AZIP,'') = '' )
 );

  UPDATE IMPORTLOG
  SET RecordsSuspended = RecordsSuspended + @@rowcount
  WHERE RunStatus = 'LOADING';

  DELETE FROM IMPORT_A
  WHERE ((COALESCE(AADDR1,'') ='' )
   OR    (COALESCE(ACITY,'') = '' )
   OR 	(COALESCE(ACITY,'') LIKE '%[0-9]%')
   OR    (COALESCE(ASTATE,'') = '')
   OR    (COALESCE(AZIP,'') = '' )
 );

COMMIT TRANSACTION IMPORT_A;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - sps_IMPORT_A_DataCleanupInvalidAddress create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure sps_IMPORT_A_DataCleanupInvalidAddress created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/

