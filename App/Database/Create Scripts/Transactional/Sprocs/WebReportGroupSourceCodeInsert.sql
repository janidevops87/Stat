IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'WebReportGroupSourceCodeInsert')
	BEGIN
		PRINT 'Dropping Procedure WebReportGroupSourceCodeInsert'
		DROP Procedure WebReportGroupSourceCodeInsert
	END
GO

PRINT 'Creating Procedure WebReportGroupSourceCodeInsert'
GO
CREATE Procedure WebReportGroupSourceCodeInsert
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
**	File: WebReportGroupSourceCodeInsert.sql
**	Name: WebReportGroupSourceCodeInsert
**	Desc: Inserts WebReportGroupSourceCode 
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

IF
(
	SELECT COUNT(*) FROM WebReportGroupSourceCode 
	WHERE
		WebReportGroupID = @WebReportGroupID
		AND SourceCodeID = @SourceCodeID	
) = 0

BEGIN
	INSERT INTO WebReportGroupSourceCode 
	(
		WebReportGroupID, 
		SourceCodeID, 
		LastModified,
		AccessOrgans, 
		AccessBone, 
		AccessTissue, 
		AccessSkin, 
		AccessValves, 
		AccessEyes, 
		AccessResearch, 
		AccessOrgansUpdate, 
		AccessBoneUpdate, 
		AccessTissueUpdate, 
		AccessSkinUpdate, 
		AccessValvesUpdate, 
		AccessEyesUpdate, 
		AccessResearchUpdate, 
		AccessTypeOTE, 
		AccessTypeTE, 
		AccessTypeEOnly, 
		AccessTypeRuleout
	)
	VALUES
	(
		@WebReportGroupID, 
		@SourceCodeID,
		@LastModified, 
		@AccessOrgans, 
		@AccessBone, 
		@AccessTissue, 
		@AccessSkin, 
		@AccessValves, 
		@AccessEyes, 
		@AccessResearch, 
		@AccessOrgansUpdate, 
		@AccessBoneUpdate, 
		@AccessTissueUpdate, 
		@AccessSkinUpdate, 
		@AccessValvesUpdate, 
		@AccessEyesUpdate, 
		@AccessResearchUpdate, 
		@AccessTypeOTE, 
		@AccessTypeTE, 
		@AccessTypeEOnly, 
		@AccessTypeRuleout
	)
END 

GO

GRANT EXEC ON WebReportGroupSourceCodeInsert TO PUBLIC
GO
