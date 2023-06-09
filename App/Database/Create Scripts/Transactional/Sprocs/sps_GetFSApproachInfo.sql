SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetFSApproachInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetFSApproachInfo]
GO




CREATE PROCEDURE sps_GetFSApproachInfo

@CallID Int = null 

AS

/* ccarroll 09/11/2006
sp to Get FS information for Referral form. */


SELECT (p.PersonFirst + ' ' + p.PersonLast) AS Approacher,
 fs.FSApproachTypeName,
 CASE sa.SecondaryApproachOutcome
  WHEN 1 THEN 'Yes-Verbal'
  WHEN 2 THEN 'Yes-Written'
  WHEN 3 THEN 'No'
  WHEN 4 THEN 'Undecided'
 END  AS ApproachOutcome

FROM SecondaryApproach sa
LEFT JOIN Person p ON  sa.SecondaryApproachedBy = p.PersonID
LEFT JOIN FSApproachType fs ON sa.SecondaryApproachType = fs.FSApproachTypeID
WHERE CallID = @CallId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

