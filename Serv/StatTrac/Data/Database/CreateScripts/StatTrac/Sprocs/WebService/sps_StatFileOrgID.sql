SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFileOrgID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFileOrgID]
GO




CREATE PROCEDURE sps_StatFileOrgID
		@vUserName as varchar(20),
		@vPassword as varchar(20)


 AS

		declare
		@vOrgID as int

Select @vOrgID = 0

SELECT 	@vOrgID = OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	WebPersonPassword = @vPassword


 if @vOrgID = 0 
	Begin
		select @vOrgID as 'OrgID'
	end

 if @vOrgID > 0 
	Begin
		select @vOrgID as 'OrgID'
	end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

