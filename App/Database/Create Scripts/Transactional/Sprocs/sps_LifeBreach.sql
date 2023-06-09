SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_LifeBreach]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_LifeBreach]
GO

CREATE PROCEDURE sps_LifeBreach 
	 (@OrgID int = NULL)

/*
   Sproc returns list of LifeBreachEmail notifications for
   Modified to sort by OrganizationName, added default value for @OrgId 5/6/05 - SAP
*/
AS

SET NOCOUNT ON

SELECT * 
	FROM LifeBreachEmail 
	WHERE ReportGroupMaster = @OrgID 
	ORDER BY OrganizationName, PersonName;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

