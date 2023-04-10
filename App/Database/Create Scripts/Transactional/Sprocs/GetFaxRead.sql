IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetFaxRead]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetFaxRead]
	PRINT 'Dropping Procedure: GetFaxRead'
END
	PRINT 'Creating Procedure: GetFaxRead'
GO

CREATE PROCEDURE [dbo].[GetFaxRead]

/******************************************************************************
**		File: GetFaxRead.sql
**		Name: GetFaxRead
**		Desc:  
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 07/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		07/2009		jth     	initial
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT *,(SELECT StatEmployeeFirstName + ' ' + StatEmployeeLastName 
FROM StatEmployee 
where StatEmployeeID = FaxQueue.FaxQueueById) AS 'FaxQueueByName'
--(SELECT drdsnid
--FROM  drdsn
--where FaxQueue.faxqueuedsnid = drdsnid) AS 'stateID'
FROM FaxQueue  WHERE FaxQueueSentDate is null
ORDER BY FaxQueueSubmitDate ASC
	


	RETURN @@Error
GO


    