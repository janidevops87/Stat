SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFileGetFrequencies]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFileGetFrequencies]
GO





CREATE PROCEDURE sps_StatFileGetFrequencies 
		@vUserName as varchar(50),
		@vUserPassword as varchar(50)


AS
declare @vorgID as int
		 
SELECT @vorgID = OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName =@vUserName
    		AND 	WebPersonPassword = @vUserPassword

 

SELECT SFF.FrequencyID, SFF.Quantity, SFF.Units, SFF.Display FROM StatFileFrequency SFF
INNER JOIN StatFileOrgFrequency ON SFF.FrequencyID = StatFileOrgFrequency.FrequencyID
WHERE orgID = @vorgID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

