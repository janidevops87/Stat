SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_AddWebReportGroupOrganization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_AddWebReportGroupOrganization]
GO








CREATE PROCEDURE SPI_AddWebReportGroupOrganization
--T.T 12/20/2004  to add WebReportGroups
	@RotationGroupID as int,
	@RotationID as int,
	@WebReportGroupID as int,
	@AccessStartDate as datetime,
	@AccessEndDate as datetime
	


 AS
 

INSERT INTO WebReportGroupAccessDate (WebReportGroupID, AccessStartDate, AccessEndDate) VALUES (@WebReportGroupID,@AccessStartDate,@AccessEndDate)



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

