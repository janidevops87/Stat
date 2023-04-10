SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_AddScheduleGroupOrganization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_AddScheduleGroupOrganization]
GO







CREATE PROCEDURE SPI_AddScheduleGroupOrganization
--T.T 12/20/2004  to add ScheduleGroups
	@ScheduleGroupID as int,
	@OrganizationID as int
	


 AS

--INSERT INTO ScheduleGroupOrganization (ScheduleGroupID, OrganizationID) VALUES (123,3532) 

INSERT INTO ScheduleGroupOrganization (ScheduleGroupID, OrganizationID) VALUES (@ScheduleGroupID,@OrganizationID)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

