IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'WebReportGroupSourceCodeUpdate')
	BEGIN
		PRINT 'Dropping Procedure WebReportGroupSourceCodeUpdate'
		DROP Procedure WebReportGroupSourceCodeUpdate
	END
GO

PRINT 'Creating Procedure WebReportGroupSourceCodeUpdate'
GO
CREATE Procedure WebReportGroupSourceCodeUpdate
(
	@WebReportGroupID INT = NULL, 
	@SourceCodeID  INT = NULL, 
	@LastModified SMALLDATETIME = NULL,
	@AccessOrgans SMALLINT = NULL,
	@AccessBone SMALLINT = NULL,
	@AccessTissue SMALLINT = NULL, 
	@AccessSkin SMALLINT = NULL, 
	@AccessValves SMALLINT = NULL, 
	@AccessEyes SMALLINT = NULL, 
	@AccessResearch SMALLINT = NULL, 
	@AccessOrgansUpdate SMALLINT = NULL, 
	@AccessBoneUpdate SMALLINT = NULL, 
	@AccessTissueUpdate SMALLINT = NULL, 
	@AccessSkinUpdate SMALLINT = NULL, 
	@AccessValvesUpdate SMALLINT = NULL, 
	@AccessEyesUpdate SMALLINT = NULL, 
	@AccessResearchUpdate SMALLINT = NULL, 
	@AccessTypeOTE SMALLINT = NULL, 
	@AccessTypeTE SMALLINT = NULL, 
	@AccessTypeEOnly SMALLINT = NULL, 
	@AccessTypeRuleout SMALLINT = NULL	 			
)
AS
/******************************************************************************
**	File: WebReportGroupSourceCodeUpdate.sql
**	Name: WebReportGroupSourceCodeUpdate
**	Desc: Updates WebReportGroupSourceCode  
**	Auth: Ed Hawkes
**	Date: 6/29/2016
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	6/29/2016		Ed Hawkes				Initial Sproc Creation 
*******************************************************************************/

UPDATE
	dbo.WebReportGroupSourceCode 	
SET 
	WebReportGroupID = @WebReportGroupID,  
	SourceCodeID = @SourceCodeID, 
	LastModified = @LastModified, 
	AccessOrgans = @AccessOrgans,  
	AccessBone	= @AccessBone,  
	AccessTissue = @AccessTissue, 
	AccessSkin = @AccessSkin,  
	AccessValves = @AccessValves,  
	AccessEyes = @AccessEyes, 
	AccessResearch = @AccessResearch,  
	AccessOrgansUpdate = @AccessOrgansUpdate,   
	AccessBoneUpdate = @AccessBoneUpdate, 
	AccessTissueUpdate = @AccessTissueUpdate,  
	AccessSkinUpdate = @AccessSkinUpdate, 
	AccessValvesUpdate = @AccessValvesUpdate,  
	AccessEyesUpdate = @AccessEyesUpdate,  
	AccessResearchUpdate = @AccessResearchUpdate,  
	AccessTypeOTE = @AccessTypeOTE,  
	AccessTypeTE = @AccessTypeTE,  
	AccessTypeEOnly	= @AccessTypeEOnly,  
	AccessTypeRuleout =	@AccessTypeRuleout  	 	
WHERE 
	WebReportGroupID = @WebReportGroupID
	AND SourceCodeID = @SourceCodeID				
GO

GRANT EXEC ON WebReportGroupSourceCodeUpdate TO PUBLIC
GO
