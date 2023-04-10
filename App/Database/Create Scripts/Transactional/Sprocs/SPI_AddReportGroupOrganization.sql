SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_AddReportGroupOrganization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_AddReportGroupOrganization]
GO








CREATE PROCEDURE SPI_AddReportGroupOrganization
--T.T 12/20/2004  to add ReportGroups
	@WebReportGroupID as int,
	@OrganizationID as int
	


 AS

--INSERT INTO SourceCodeOrganization (OrganizationID, SourceCodeID) VALUES (5583,292)

INSERT INTO WebReportGroupOrg (WebReportGroupID, OrganizationID) VALUES (@WebReportGroupID,@OrganizationID)



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

