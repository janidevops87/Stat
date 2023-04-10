SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_AddCriteriaOrganization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_AddCriteriaOrganization]
GO








CREATE PROCEDURE SPI_AddCriteriaOrganization
--T.T 12/20/2004  to add Organizations to criteriaOrganization
	@CriteriaID as int,
	@OrganizationID as int
	


 AS

--INSERT INTO CriteriaOrganization (CriteriaID, OrganizationID) VALUES (16493,6008) 

INSERT INTO CriteriaOrganization (CriteriaID, OrganizationID) VALUES (@CriteriaID,@OrganizationID);





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

