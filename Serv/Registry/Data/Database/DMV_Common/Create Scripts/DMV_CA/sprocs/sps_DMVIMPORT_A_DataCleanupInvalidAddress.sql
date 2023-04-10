if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DMVIMPORT_A_DataCleanupInvalidAddress]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping sps_DMVIMPORT_A_DataCleanupInvalidAddress'
	drop procedure [dbo].[sps_DMVIMPORT_A_DataCleanupInvalidAddress]
End
GO

	PRINT 'Creating sps_DMVIMPORT_A_DataCleanupInvalidAddress'
GO


CREATE PROCEDURE sps_DMVIMPORT_A_DataCleanupInvalidAddress AS
/******************************************************************************
**		File: sps_DMVIMPORT_A_DataCleanupInvalidAddress.sql
**		Name: sps_DMVIMPORT_A_DataCleanupInvalidAddress
**		Desc:	This sp removes invalid records and puts them in the DMVSuspense_A holding table.
**				The import log table is updated.
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

declare @suspect varchar(255)
select @suspect = 'Invalid Address IMPORT_A'
begin transaction DMVIMPORT_A
  insert DMVSUSPENSE_A
  select *, 0, @suspect from DMVIMPORT_A
  where ((isnull(AADDR1,'') ='' AND isnull(BADDR1,'') ='')
   or    (isnull(ACITY,'') = '' AND isnull(BCITY,'') = '')
   or    (isnull(ASTATE,'') = '' AND isnull(BSTATE,'') = '')
   or    (isnull(AZIP,'') = '' AND isnull(BZIP,'') = '')
 )
  update DMVIMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from DMVIMPORT_A
  where ((isnull(AADDR1,'') ='' AND isnull(BADDR1,'') ='')
   or    (isnull(ACITY,'') = '' AND isnull(BCITY,'') = '')
   or    (isnull(ASTATE,'') = '' AND isnull(BSTATE,'') = '')
   or    (isnull(AZIP,'') = '' AND isnull(BZIP,'') = '')
 )
commit transaction DMVIMPORT_A

CHECKPOINT


GO


