SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Person_ListAllFSC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Person_ListAllFSC]
GO


Create Procedure [dbo].[Person_ListAllFSC]
As
Begin

Select
            PersonId,
            IsNull( PersonLast, '' ) + ', ' + IsNull( PersonFirst, '' ) + ' ' + IsNull( PersonMI, '' ) As PersonName
From
            Person
Where		(
			PersonTypeID in (60,84) -- FSC or Team Leader
		    Or
			(PersonFirst like 'Any' And PersonLast like 'Coordinator')
			)
And	    InActive = 0 -- Active People
And	    OrganizationID = 194 -- Statline

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

