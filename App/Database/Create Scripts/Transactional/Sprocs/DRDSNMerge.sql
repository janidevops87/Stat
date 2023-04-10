 

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DRDSNMerge')
	BEGIN
		PRINT 'Dropping Procedure DRDSNMerge'
		DROP Procedure DRDSNMerge
	END
GO

PRINT 'Creating Procedure DRDSNMerge'
GO
CREATE Procedure DRDSNMerge
(
		@ServiceLevelDRDSNID int = null,
		@DRDSNID int = null,
		@ServiceLevelID int = null,
		@DRDSNName varchar(50) = null,
		@LastModified datetime = null,
		@CreateDate datetime = null,
		@Hidden BIT = null										
)
AS
/******************************************************************************
**	File: DRDSNMerge.sql
**	Name: DRDSNMerge
**	Desc: Updates DRDSN Based on Id field 
**	Auth: jth
**	Date: 1/5/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/2010			jth			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

MERGE dbo.ServiceLevelDRDSN AS target
USING	(SELECT 
		@ServiceLevelDRDSNID, 
		@DRDSNID,
		@ServiceLevelID,
		@Hidden) AS source 
		(ServiceLevelDRDSNID, 
		DRDSNID, 
		ServiceLevelID,
		Hidden)
ON		(target.ServiceLevelDRDSNID = source.ServiceLevelDRDSNID)
WHEN MATCHED AND source.Hidden = 0  THEN 
	UPDATE		
	SET 
			DRDSNID = @DRDSNID,
			ServiceLevelID = @ServiceLevelID,
			LastModified = GetDate(),
			CreateDate = @CreateDate
			
WHEN MATCHED AND source.Hidden = 1  THEN 
	DELETE 			
WHEN NOT MATCHED AND source.Hidden = 0 THEN
	INSERT	
	(
		DRDSNID,
		ServiceLevelID,
		LastModified,
		CreateDate
	)
	VALUES
	(
		@DRDSNID, 
		@ServiceLevelID,
		GetDate(),
		GetDate()
	);
  