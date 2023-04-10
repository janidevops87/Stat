IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetInitialApproacherType')
	BEGIN
		PRINT 'Dropping Procedure GetInitialApproacherType'
		DROP  Procedure  GetInitialApproacherType
	END

GO

PRINT 'Creating Procedure GetInitialApproacherType'
GO  

CREATE Procedure GetInitialApproacherType

	
	@OrganizationID	int = Null
	
	
AS
/******************************************************************************
**		File: GetInitialApproacherType.sql
**		Name: GetInitialApproacherType
**		Desc: 
**
**		Called by:   
**              
**
**		Auth: jth
**		Date: 07/2008
*******************************************************************************
**		Change History
*******************************************************************************
**	  Date:		Author:		Description:
**	  --------	--------	-------------------------------------------
**    7/2008	jth			Initial
*******************************************************************************/ 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 


SELECT DISTINCT  ApproachTypeName, ApproachTypeID FROM ApproachType
GO