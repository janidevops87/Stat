 SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetPersonTypesQA]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetPersonTypesQA]
GO
 
 CREATE PROCEDURE sps_GetPersonTypesQA
@OrganizationID		int
/******************************************************************************
**		File: sps_GetPersonTypesQA.sql
**		Name: sps_GetPersonTypesQA
**		Desc:  Used on QA Reports
**
**		Called by:  
**              **
**		Auth: jth
**		Date: 07/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		07/2009		jth			initial
*******************************************************************************/
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

SELECT DISTINCT PersonType.PersonTypeID, PersonType.PersonTypeName
FROM         Person INNER JOIN
                      PersonType ON Person.PersonTypeID = PersonType.PersonTypeID

where OrganizationID = @OrganizationID
ORDER BY PersonType.PersonTypeName

GO