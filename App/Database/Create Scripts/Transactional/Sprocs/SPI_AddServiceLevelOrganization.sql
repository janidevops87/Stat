SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_AddServiceLevelOrganization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_AddServiceLevelOrganization]
GO









CREATE PROCEDURE SPI_AddServiceLevelOrganization
--T.T 12/20/2004  to add Organizations to serviceLevelOrganization
	@ServiceLeveLID as int,
	@OrganizationID as int
	

	 AS
	Declare
	@ServiceLevelIDcheck as int,
	@Check as int
	 


  --check for Organization already added
	--SELECT DISTINCT @ServiceLevelIDcheck = ServiceLevelID FROM ServiceLevel30Organization WHERE OrganizationID = @OrganizationID AND ServiceLevelID = @ServiceLevelID

	--select @check = ISNULL(@ServiceLevelIDcheck,100)  
	--if @check = 100 	
	 	--Begin
			print 'servicelevel'
			print @ServiceLeveLID
			print @OrganizationID
			INSERT INTO ServiceLevel30Organization (ServiceLeveLID, OrganizationID) VALUES (@ServiceLeveLID,@OrganizationID);
			exec SPU_SaveServiceLevelWorking  @ServiceLevelID
			
		--End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

