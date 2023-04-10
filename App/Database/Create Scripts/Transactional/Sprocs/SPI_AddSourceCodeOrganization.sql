SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_AddSourceCodeOrganization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_AddSourceCodeOrganization]
GO








CREATE PROCEDURE SPI_AddSourceCodeOrganization
--T.T 12/20/2004  to add Organizations to criteriaOrganization
	@sourceCodeID as int,
	@OrganizationID as int
	


 AS

--INSERT INTO SourceCodeOrganization (OrganizationID, SourceCodeID) VALUES (5583,292)

INSERT INTO SourceCodeOrganization (OrganizationID, SourceCodeID) VALUES (@OrganizationID,@SourceCodeID)




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

