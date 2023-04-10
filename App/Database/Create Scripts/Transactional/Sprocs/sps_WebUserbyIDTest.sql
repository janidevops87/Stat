SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserbyID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserbyID]
GO


CREATE PROCEDURE sps_WebUserbyID
		@WebUserID 		INT	= 0
AS
SET NOCOUNT ON
If @WebUserID <> 0
BEGIN

	SELECT * FROM WebPerson, Person
	WHERE WebPersonID=@WebUserID
	AND WebPerson.PersonID = Person.PersonID

END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

