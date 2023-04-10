if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetPersonListByOrganizationId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetPersonListByOrganizationId]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE GetPersonListByOrganizationId
	@OrganizationId	INT = NULL,
	@Inactive		INT = NULL
AS
/******************************************************************************
**		File: GetPersonListByOrganizationId.sql
**		Name: GetPersonListByOrganizationId
**		Desc: Returns a list of People by OrganizationID
**
** 
**		Called by:   CustomParamsMessageImport.ascx
**              
**
**		Auth: Bret Knoll
**		Date: 06/09/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		06/09/2008	Bret Knoll			initial
*******************************************************************************/

SELECT     
	PersonID, 
	ISNULL(PersonLast, '') + ', ' + ISNUll(PersonFirst, '') + ' ' + ISNULL(PersonMI, '') PersonName
FROM         
	Person
WHERE     
	(OrganizationID = ISNULL(@OrganizationId, 0)) 
AND 
	(Inactive = ISNULL(@Inactive, 0))
	
	

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

