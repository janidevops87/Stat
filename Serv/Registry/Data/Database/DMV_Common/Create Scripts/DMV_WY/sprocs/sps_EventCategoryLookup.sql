IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_EventCategoryLookup')
	BEGIN
		PRINT 'Dropping Procedure sps_EventCategoryLookup'
		DROP  Procedure  sps_EventCategoryLookup
	END

GO

PRINT 'Creating Procedure sps_EventCategoryLookup'
GO
CREATE Procedure sps_EventCategoryLookup
	/* Param List */
AS

/******************************************************************************
**		File: 
**		Name: sps_EventCategoryLookup
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/




GO
