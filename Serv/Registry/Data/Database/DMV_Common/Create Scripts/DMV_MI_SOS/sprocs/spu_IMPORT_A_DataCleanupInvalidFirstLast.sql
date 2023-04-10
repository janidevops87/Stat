IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupInvalidFirstLast]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spu_IMPORT_A_DataCleanupInvalidFirstLast];
END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE spu_IMPORT_A_DataCleanupInvalidFirstLast AS
/******************************************************************************
**		File: spu_IMPORT_A_DataCleanupInvalidFirstLast.sql
**		Name: spu_IMPORT_A_DataCleanupInvalidFirstLast
**		Desc: 
**
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
**		Auth: Moonray Schepart
**		Date: 05/28/2014
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------	--------				--------------------------------------
**		05/28/2014  Moonray Schepart		initial 
**		05/28/2014	Moonray Schepart		Include Branch Number and Enrollment Date fields
**		09/08/2015		mmaitan				Adding comment to force the script generator to pick up this script
*******************************************************************************/
DECLARE @suspect varchar(255);

SELECT @suspect = 'Invalid First or Last Name IMPORT_A';

BEGIN TRANSACTION IMPORT_A
  INSERT SUSPENSE_A
  SELECT IMPORTLOGID,LAST,FIRST,MIDDLE,SUFFIX,AADDR1,ACITY,ASTATE,AZIP,BADDR1,BCITY,BSTATE,BZIP,DOB,GENDER,LICENSE,DONOR,RENEWALDATE,DECEASEDDATE,CSORSTATE,CSORLICENSE,FULLNAME, 0, @suspect, enrollmentdate, branchnumber
  FROM IMPORT_A
  WHERE COALESCE(FIRST,'') = ''
 OR COALESCE(LAST,'') = '';

  UPDATE IMPORTLOG
  SET RecordsSuspended = RecordsSuspended + @@rowcount
  WHERE RunStatus = 'LOADING';

  DELETE FROM IMPORT_A
  WHERE COALESCE(FIRST,'') = ''
  OR COALESCE(LAST,'') = '';

COMMIT TRANSACTION IMPORT_A;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spu_IMPORT_A_DataCleanupInvalidFirstLast create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spu_IMPORT_A_DataCleanupInvalidFirstLast Created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/

