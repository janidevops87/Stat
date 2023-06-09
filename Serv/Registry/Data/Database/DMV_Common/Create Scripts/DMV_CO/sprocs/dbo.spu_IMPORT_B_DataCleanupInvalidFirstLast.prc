SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupInvalidFirstLast    Script Date: 5/14/2007 10:02:44 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_B_DataCleanupInvalidFirstLast]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_B_DataCleanupInvalidFirstLast]
GO





CREATE PROCEDURE spu_IMPORT_B_DataCleanupInvalidFirstLast AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid First or Last Name IMPORT_B'
begin transaction IMPORT_B
  insert SUSPENSE_B
  select *, 0, @suspect from IMPORT_B
  where isnull(FIRST,'') = ''
 OR isnull(LAST,'') = ''
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_B
  where isnull(FIRST,'') = ''
 OR isnull(LAST,'') = ''
commit transaction IMPORT_B
CHECKPOINT -- bjk 07/01/03 add checkpoint
/*
DECLARE @FIRST VARCHAR(10),
 @LAST VARCHAR(10)
SELECT @FIRST = 'BRET'
SELECT @LAST = NULL
SELECT ':' + isnull(@FIRST,'') + isnull(@LAST,'') +  ':', ':' + ':', ': :'
*/





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

