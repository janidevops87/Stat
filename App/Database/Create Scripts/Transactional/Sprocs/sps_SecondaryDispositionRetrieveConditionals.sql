SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryDispositionRetrieveConditionals]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryDispositionRetrieveConditionals]
GO


CREATE PROCEDURE sps_SecondaryDispositionRetrieveConditionals @SubCriteriaID INT AS

SELECT cro.ProcessorCriteria_ConditionalROID, fsc.FSConditionName, fsi.FSIndicationName, fsa.FSAppropriateName, cro.FSIndicationID, cro.FSConditionID, cro.FSAppropriateID, cro.SubCriteriaID
FROM ProcessorCriteria_ConditionalRO cro 
LEFT OUTER JOIN FSIndication fsi ON cro.FSIndicationID = fsi.FSIndicationID 
LEFT OUTER JOIN FSCondition fsc ON cro.FSConditionID = fsc.FSConditionID 
LEFT OUTER JOIN FSAppropriate fsa ON cro.FSAppropriateID = fsa.FSAppropriateID
WHERE cro.FSConditionID <> 0
AND   cro.SubCriteriaID =  @SubCriteriaID
ORDER BY fsi.FSIndicationName, fsa.FSAppropriateName, fsc.FSConditionName

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

