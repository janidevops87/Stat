    

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CallCriteriaMerge')
	BEGIN
		PRINT 'Dropping Procedure CallCriteriaMerge'
		DROP Procedure CallCriteriaMerge
	END
GO

PRINT 'Creating Procedure CallCriteriaMerge'
GO
CREATE Procedure CallCriteriaMerge
(
		@CallID int = null,
		@OrganCriteriaID int = null,
		@BoneCriteriaID int = null,
		@TissueCriteriaID int = null,
		@SkinCriteriaID int = null,
		@ValvesCriteriaID int = null,
		@EyesCriteriaID int = null,
		@OtherCriteriaID int = null,
		@ServiceLevelID int = null
)
AS
/******************************************************************************
**	File: CallCriteriaMerge.sql
**	Name: CallCriteriaMerge
**	Desc: Updates CallCriteria Based on Id field 
**	Note: 
**	Auth: ccarroll	
**	Date: 08/22/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	08/22/2010		ccarroll				Initial Sproc Creation
*******************************************************************************/

MERGE dbo.CallCriteria AS target
USING	(SELECT 
			@CallID, 
			@ServiceLevelID
		) AS source 
		(
			CallID, 
			ServiceLevelID
		)ON	(target.CallID = source.CallID)
WHEN MATCHED THEN 
	UPDATE		
	SET 
			OrganCriteriaID = @OrganCriteriaID,
			BoneCriteriaID = @BoneCriteriaID,
			TissueCriteriaID = @TissueCriteriaID,
			SkinCriteriaID = @SkinCriteriaID,
			ValvesCriteriaID = @ValvesCriteriaID,
			EyesCriteriaID = @EyesCriteriaID,
			OtherCriteriaID = @OtherCriteriaID
			
WHEN NOT MATCHED THEN
	INSERT	
	(
			CallID,
			OrganCriteriaID,
			BoneCriteriaID,
			TissueCriteriaID,
			SkinCriteriaID,
			ValvesCriteriaID,
			EyesCriteriaID,
			OtherCriteriaID,
			ServiceLevelID
	)
	VALUES
	(
			@CallID,
			@OrganCriteriaID,
			@BoneCriteriaID,
			@TissueCriteriaID,
			@SkinCriteriaID,
			@ValvesCriteriaID,
			@EyesCriteriaID,
			@OtherCriteriaID,
			@ServiceLevelID
	);
  