SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_LifeBreach]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_LifeBreach]
GO


CREATE PROCEDURE SPI_LifeBreach
	@ReportGroupMaster	int,
	@OrganizationName	varchar(255),
	@OrganizationID	int,
	@PersonName		varchar(255),
	@PersonID		int,
	@EmailAddress		varchar(255)
	
	


 AS

Insert into LifeBreachEmail
	(ReportGroupMaster,OrganizationName,OrganizationID,PersonName,PersonID,EmailAddress)
	Values (@ReportGroupMaster,@OrganizationName,@OrganizationID,@PersonName,@PersonID,@EmailAddress)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

