CREATE PROCEDURE spu_IMPORT_All_ImportLog2 AS
/*
	Desigened AND Developed 01/2003
	Legal Information...
	 c1996-2003 Statline, LLC. All rights reserved. 
	 Statline is a registered trademark of Statline, LLC in the U.S.A. 
	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @@RecordsUpdated             int
declare @@RecordsAdded               int
select @@RecordsUpdated = count(IMPORT.ID)
from IMPORT, DMV
where IMPORT.LICENSE = DMV.LICENSE
select @@RecordsAdded = count(IMPORT.ID)
from IMPORT
where not exists(select IMPORT.LICENSE
                 from DMV where IMPORT.LICENSE = DMV.LICENSE)
update IMPORTLOG
set RecordsUpdated            = @@RecordsUpdated,
    RecordsAdded              = @@RecordsAdded
where RunStatus = 'LOADING'

GO
