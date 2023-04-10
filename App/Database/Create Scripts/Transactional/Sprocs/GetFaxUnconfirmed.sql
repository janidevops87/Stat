IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetFaxUnconfirmed]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetFaxUnconfirmed]
	PRINT 'Dropping Procedure: GetFaxUnconfirmed'
END
	PRINT 'Creating Procedure: GetFaxUnconfirmed'
GO

CREATE PROCEDURE [dbo].[GetFaxUnconfirmed]
/******************************************************************************
**		File: GetFaxUnconfirmed.sql
**		Name: GetFaxUnconfirmed
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

	SELECT * FROM FaxQueue WHERE FaxQueueConfirmedDate is null
AND FaxQueueJobId >0
ORDER BY FaxQueueSubmitDate ASC
	


	RETURN @@Error
GO


   