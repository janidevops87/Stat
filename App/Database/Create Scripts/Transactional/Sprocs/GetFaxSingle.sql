IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetFaxSingle]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetFaxSingle]
	PRINT 'Dropping Procedure: GetFaxSingle'
END
	PRINT 'Creating Procedure: GetFaxSingle'
GO

CREATE PROCEDURE [dbo].[GetFaxSingle]
(
	@JobID varchar(50)
)
/******************************************************************************
**		File: GetFaxSingle.sql
**		Name: GetFaxSingle
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
where StatEmployeeID = FaxQueue.FaxQueueById) AS 'FaxQueueByName',
(SELECT stateid
FROM organization 
where FaxQueue.FaxQueueOrgId = Organization.OrganizationID) AS 'stateID'
FROM FaxQueue
    WHERE FaxQueueJobID= @JobID
	


	RETURN @@Error
GO


  