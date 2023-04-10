SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OrganizationName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OrganizationName]
GO






/****** Object:  Stored Procedure dbo.sps_OrganizationName    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_OrganizationName

	@vOrgID	int		= null

AS

    SELECT OrganizationName
    FROM Organization
    WHERE OrganizationID = @vOrgID




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

