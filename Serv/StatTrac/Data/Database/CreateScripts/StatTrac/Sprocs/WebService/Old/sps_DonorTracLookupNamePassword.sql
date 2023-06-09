SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorTracLookupNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorTracLookupNamePassword]
GO


CREATE PROCEDURE sps_DonorTracLookupNamePassword
		@vUserName as varchar(50),
		@vPassword as varchar(50)

 AS

declare
@vOrgID as int

set @vOrgID = 0

SELECT 	@vOrgID =  OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	WebPersonPassword = @vPassword

select @vOrgID as 'OrganizationID'

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

