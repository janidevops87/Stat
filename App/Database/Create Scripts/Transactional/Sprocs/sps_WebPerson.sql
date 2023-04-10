SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebPerson]
GO




CREATE PROCEDURE sps_WebPerson

		@vWebPersonID	int	= null


AS

	SELECT	WebPerson.PersonID, PersonFirst, PersonLast, Person.PersonID
	FROM		Person
	JOIN		WebPerson ON WebPerson.PersonID = Person.PersonID
	WHERE 	WebPersonID = @vWebPersonID





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

