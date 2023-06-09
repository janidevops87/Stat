SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_CriteriaImportLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_CriteriaImportLog]
GO

CREATE PROCEDURE spu_IMPORT_CriteriaImportLog AS
/*
	Desigened AND Developed 01/2003
	Legal Information...
	 c1996-2003 Statline, LLC. All rights reserved. 
	 Statline is a registered trademark of Statline, LLC in the U.S.A. 
	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @@RecordsTotal               int
select @@RecordsTotal = count(Import_Criteria.ID)
from Import_Criteria
update Import_Criteria_Log
set RecordsTotal              = @@RecordsTotal
where RunStatus = 'LOADING'

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

