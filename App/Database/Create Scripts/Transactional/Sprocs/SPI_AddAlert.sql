SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_AddAlert]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_AddAlert]
GO








CREATE PROCEDURE SPI_AddAlert
--T.T 12/20/2004  to add alerts to alertgroups
	@AlertID as int,
	@OrganizationID as int
	


 AS



INSERT INTO AlertOrganization (AlertID, OrganizationID) VALUES (@AlertID,@OrganizationID);





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

