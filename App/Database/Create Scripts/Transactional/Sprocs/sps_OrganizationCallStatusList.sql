IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'sps_OrganizationCallStatusList')
BEGIN
	PRINT 'Dropping Procedure sps_OrganizationCallStatusList';
	DROP  Procedure  sps_OrganizationCallStatusList;
END
GO

PRINT 'Creating Procedure sps_OrganizationCallStatusList';
GO
CREATE Procedure sps_OrganizationCallStatusList
	@OrganizationID			INT,
	@OrganizationLOEnabled	INT
AS

/******************************************************************************
**		File: sps_OrganizationCallStatusList.sql
**		Name: sps_OrganizationCallStatusList
**		Desc: Looks up and returns a list of Organizations based on the 
**				combination of OrganizationID and OrganizationLOEnabled
**		
**		Called by:   
**			Statline.StatTrac.Framework.modDataQuery.GetOrganizationCallStatusList   
**
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@OrganizationID						See List
**		@OrganizationLOEnabled
**
**		Auth: Mike Berenson
**		Date: 5/20/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		5/20/2020	Mike Berenson		Initial Creation
********************************************************************************/
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT 
		OrganizationID, 
		OrganizationName,
		OrganizationLO,
		OrganizationLOEnabled, 
		OrganizationLOType,
		OrganizationLOTriageenabled,
		OrganizationLOFSenabled 
	
	FROM 
		Organization 
	
	WHERE 
		OrganizationLO = -1 -- TODO: Add Description
		AND OrganizationLOEnabled = @OrganizationLOEnabled
		AND (@OrganizationID = 0 OR OrganizationID = @OrganizationID);
	   
END
GO

GRANT EXEC ON sps_OrganizationCallStatusList TO PUBLIC;
GO
