if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DMVIMPORT_A_DataCleanupDuplicateLicense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spu_DMVIMPORT_A_DataCleanupDuplicateLicense'
	drop procedure [dbo].[spu_DMVIMPORT_A_DataCleanupDuplicateLicense]
End
GO

	PRINT 'Creating spu_DMVIMPORT_A_DataCleanupDuplicateLicense'
GO



CREATE   PROCEDURE spu_DMVIMPORT_A_DataCleanupDuplicateLicense AS
/******************************************************************************
**		File: spu_DMVIMPORT_A_DataCleanupDuplicateLicense.sql
**		Name: spu_DMVIMPORT_A_DataCleanupDuplicateLicense
**		Desc: Looks for duplicate license and removes suspect records to DMVSuspense_A
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
select @suspect = 'Duplicate License Number in DMVIMPORT_A File'
begin transaction DMVIMPORT_A
  insert DMVSUSPENSE_A
  select i.*, 0, @suspect
  from DMVIMPORT_A i, (select LICENSE
                  from DMVIMPORT_A
                  where LICENSE IS NOT NULL
                  group by LICENSE
                  having count(ID) > 1) d
  where i.LICENSE = d.LICENSE
  update DMVIMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from DMVIMPORT_A
  from DMVIMPORT_A i, (select LICENSE
                  from DMVIMPORT_A
                  where LICENSE IS NOT NULL 
                  group by LICENSE
                  having count(ID) > 1) d
  where i.LICENSE = d.LICENSE
commit transaction DMVIMPORT_A

CHECKPOINT 

GO


