 /******************************************************************************************
**		File: DeleteDuplicateDMVRecords.sql
**		Descr: Removes duplicate DMV records which are already in the archive.  This will
**             prevent errors when new records are imported.
**
**		Auth: mmaitan
**		Date: 12/16/2016 
**
**		CCRST243 for DMV_MA, DMV_ME databases
**		TEST SCRIPTS:
**		begin tran;
**      
**      select * from DMV d
**      inner join DMVARCHIVE da
**      on d.ID = da.ID
**      
**      delete d from DMV d
**      inner join DMVARCHIVE da
**      on d.ID = da.ID
**      
**      select * from DMV d
**      inner join DMVARCHIVE da
**      on d.ID = da.ID
**      
**      rollback tran;
*******************************************************************************************/

delete d
from DMV d
inner join DMVARCHIVE da
on d.ID = da.ID

