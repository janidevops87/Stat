SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_Person]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_Person]
GO






/****** Object:  Stored Procedure dbo.sps_Person    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_Person

		@vOrgID	int		= null,
		@vPersonID	int		= 0,
		@vActiveStatus	int		= 0

AS

IF @vPersonID = 0
	BEGIN

	IF @vActiveStatus = 0
		
		/*  Get all active and inactive  */

		SELECT	PersonID, PersonFirst, PersonLast
		FROM		Person
		WHERE 	OrganizationID = @vOrgID
		ORDER BY	PersonFirst

	IF @vActiveStatus = 1

		/*  Get only active  */

		SELECT	PersonID, PersonFirst, PersonLast
		FROM		Person
		WHERE 	OrganizationID = @vOrgID
		AND		Inactive <> 1
		ORDER BY	PersonFirst

	IF @vActiveStatus = 2

		/*  Get only inactive  */

		SELECT	PersonID, PersonFirst, PersonLast
		FROM		Person
		WHERE 	OrganizationID = @vOrgID
		AND		Inactive = 1
		ORDER BY	PersonFirst
	END
ELSE

	SELECT	PersonID, PersonFirst, PersonLast
	FROM		Person
	WHERE 	PersonID = @vPersonID







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

