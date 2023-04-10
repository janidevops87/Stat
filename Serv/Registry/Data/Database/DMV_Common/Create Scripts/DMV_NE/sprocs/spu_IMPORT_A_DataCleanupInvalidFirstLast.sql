 
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupInvalidFirstLast]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: spu_IMPORT_A_DataCleanupInvalidFirstLast'
	drop procedure [dbo].[spu_IMPORT_A_DataCleanupInvalidFirstLast]
END
GO

/****** Object:  StoredProcedure [dbo].[spu_IMPORT_A_DataCleanupInvalidFirstLast]    Script Date: 12/15/2016 7:41:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**		File: spu_IMPORT_A_DataCleanupInvalidFirstLast.sql
**		Name: spu_IMPORT_A_DataCleanupInvalidFirstLast
**		Desc:  
**
**		Called by:  
**              
**
**		Auth: mmaitan
**		Date: 12/15/2016
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		12/15/2016	Michael Maitan		Added a variable to assign the current IMPORTLOGID to fix suspend reports
*******************************************************************************/
CREATE PROCEDURE [dbo].[spu_IMPORT_A_DataCleanupInvalidFirstLast] AS

declare @suspect varchar(255),
        @IMPORTLOGID int;

select @suspect = 'Invalid First or Last Name IMPORT_A'

select @IMPORTLOGID = ID
from IMPORTLOG
where upper(RunStatus) = 'LOADING'

begin transaction IMPORT_A
  insert SUSPENSE_A
  SELECT ID, @IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, 
	DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE, 
	0, @suspect from IMPORT_A
  where isnull(FIRST,'') = ''
 OR isnull(LAST,'') = ''
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_A
  where isnull(FIRST,'') = ''
 OR isnull(LAST,'') = ''
commit transaction IMPORT_A
GO


