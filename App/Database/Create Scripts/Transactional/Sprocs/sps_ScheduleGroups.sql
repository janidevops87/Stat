SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ScheduleGroups]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ScheduleGroups]
GO


CREATE Procedure sps_ScheduleGroups

     @OrgID int     =null
AS
/******************************************************************************
**		File: sps_ScheduleGroups.sql
**		Name: sps_ScheduleGroups
**		Desc: List of Schedule setup groups by Organizationid
**
**		Called by:   
**			Called from Schedule Update and Schdule Lookup Report Params
**              
**
**		Auth: Unknown
**		Date: Uknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		7/19/08		Bret Knoll			Add header, Transaction Level
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT	ScheduleGroupID,
		ScheduleGroupName
FROM    ScheduleGroup
WHERE   OrganizationID = @OrgID
ORDER BY
        ScheduleGroupName



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

