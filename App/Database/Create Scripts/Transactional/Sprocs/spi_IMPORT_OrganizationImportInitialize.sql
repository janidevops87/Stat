SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_IMPORT_OrganizationImportInitialize]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_IMPORT_OrganizationImportInitialize]
GO

CREATE PROCEDURE spi_IMPORT_OrganizationImportInitialize AS
/*
	Desigened AND Developed 01/2003
	Legal Information...
	 c1996-2003 Statline, LLC. All rights reserved. 
	 Statline is a registered trademark of Statline, LLC in the U.S.A. 
	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
insert Import_Organization_Log(RecordsTotal) values(0)
return @@IDENTITY

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

