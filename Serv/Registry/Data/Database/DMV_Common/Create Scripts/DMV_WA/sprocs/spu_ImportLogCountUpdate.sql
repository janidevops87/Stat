IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spu_ImportLogCountUpdate')
	BEGIN
		PRINT 'Dropping Procedure spu_ImportLogCountUpdate'
		DROP  Procedure  spu_ImportLogCountUpdate
	END

GO

PRINT 'Creating Procedure spu_ImportLogCountUpdate'
GO
CREATE Procedure spu_ImportLogCountUpdate

AS

/******************************************************************************
**		File: 
**		Name: spu_ImportLogCountUpdate
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: ccarroll
**		Date: 02/06/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		02/06/2008		ccarroll	
*******************************************************************************/
DECLARE @ImportLogID int,
		@RemovedNoDonors int,
		@NewUpdate int,
		@NewAdd int,
		@OldUpdate int,
		@OldAdd int

SET @ImportLogID = 0

SELECT	@ImportLogID = ID,
		@OldAdd = RecordsAdded, 
		@OldUpdate = RecordsUpdated

FROM	(SELECT 
			ID,
			RecordsAdded,
			RecordsUpdated
		 FROM ImportLog
		 WHERE RunStatus = 'LOADING'
			--WHERE ID = 1447 -- Use to correct old incorrect counts 
		 )i
		 
SET @RemovedNoDonors = (SELECT Count(*)FROM DMVArchive WHERE DisplacedBy = @ImportLogID AND RecordType=5)

SET @NewAdd = (@OldAdd - @RemovedNoDonors)
SET @NewUpdate = (@OldUpdate + @RemovedNoDonors)

/* Debug *
Print @ImportLogID
Print @OldAdd
Print @OldUpdate
Print @NewAdd
Print @NewUpdate
*/
--/*
UPDATE ImportLog
		SET	RecordsAdded = @NewAdd,
			RecordsUpdated = @NewUpdate
WHERE ID = @ImportLogID 
--*/

GO
