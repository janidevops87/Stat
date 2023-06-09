SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatWebPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatWebPerson]
GO



CREATE PROCEDURE sps_StatWebPerson

		@vStatWebPersonID	int	= null


AS

SELECT	WebPerson.PersonID,
	Person.PersonID,
	Person.PersonFirst,
	Person.PersonLast,
	StatEmployee.PersonID,
	StatEmployee.AllowMaintainAccess
FROM Person 
JOIN WebPerson ON WebPerson.PersonID = Person.PersonID 
JOIN StatEmployee ON Person.PersonID = StatEmployee.PersonID

WHERE WebPersonID = @vStatWebPersonID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

