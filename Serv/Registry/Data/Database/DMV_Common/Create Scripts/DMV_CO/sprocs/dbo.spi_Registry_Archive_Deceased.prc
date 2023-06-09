SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_Registry_Archive_Deceased    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Registry_Archive_Deceased]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Registry_Archive_Deceased]
GO





CREATE PROCEDURE spi_Registry_Archive_Deceased 
	@ArchiveReason INT = 2
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
 
 
 begin transaction ARCHIVE
 insert REGISTRYARCHIVE
    select REGISTRY.*, @ArchiveReason 
  from REGISTRY
    where ISNULL(REGISTRY.DeceasedDate, '')<> ''
  
   insert REGISTRYARCHIVEADDR
    select REGISTRYADDR.* from REGISTRY, REGISTRYADDR
    where REGISTRY.ID = REGISTRYADDR.REGISTRYID
    and   ISNULL(REGISTRY.DeceasedDate, '')<> ''
 
    /*insert REGISTRYARCHIVEORGAN
    select REGISTRYORGAN.* from REGISTRY, REGISTRYORGAN
    where REGISTRY.ID = REGISTRYORGAN.REGISTRYID
    and   ISNULL(REGISTRY.DeceasedDate, '')<> ''
    
   delete from REGISTRYORGAN
    from REGISTRY, REGISTRYORGAN
    where REGISTRY.ID = REGISTRYORGAN.REGISTRYID
    and   ISNULL(REGISTRY.DeceasedDate, '')<> ''
    */
   delete from REGISTRYADDR
    from REGISTRY, REGISTRYADDR
    where REGISTRY.ID = REGISTRYADDR.REGISTRYID
    and   ISNULL(REGISTRY.DeceasedDate, '')<> ''
   delete from REGISTRY
    from REGISTRY
    where ISNULL(REGISTRY.DeceasedDate, '')<> ''
 commit transaction ARCHIVE
CHECKPOINT










GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

