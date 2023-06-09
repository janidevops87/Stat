SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryDispositionContactsRequired]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryDispositionContactsRequired]
GO


CREATE PROCEDURE sps_SecondaryDispositionContactsRequired @CallID INT AS

SELECT t.CallID, t.CriteriaID, t.DonorCategoryID,
       sc.SubCriteriaID, st.SubTypeID, st.SubTypeName, sc.ProcessorID, o.OrganizationName ProcessorName,
sg.ScheduleGroupID, 
       sg.ScheduleGroupName, 
       scsg.SCScheduleGroupOrgan, 
       scsg.SCScheduleGroupBone,
       scsg.SCScheduleGroupTissue, 
       scsg.SCScheduleGroupSkin, 
       scsg.SCScheduleGroupValves, 
       scsg.SCScheduleGroupEyes,  
       scsg.SCScheduleGroupResearch,  
       scsg.SCScheduleNoContactOnDny, 
       scsg.SCScheduleContactOnCnsnt, 
       scsg.SCScheduleContactOnAprch, 
       scsg.SCScheduleContactOnCrnr, 
       scsg.SCScheduleContactOnStatSec, 
       scsg.SCScheduleContactOnStatCnsnt, 
       scsg.SCScheduleContactOnCoronerOnly 
FROM SubCriteria sc 
INNER JOIN Organization o ON sc.ProcessorID = o.OrganizationID 
LEFT OUTER JOIN ScheduleGroup sg
INNER JOIN SCScheduleGroup scsg ON sg.ScheduleGroupID = scsg.ScheduleGroupID ON sc.SubCriteriaID = scsg.SubCriteriaID 
RIGHT OUTER JOIN SubType st 
INNER JOIN CriteriaSubType cst ON st.SubTypeID = cst.SubTypeID ON sc.SubtypeID = cst.SubTypeID AND sc.CriteriaID = cst.CriteriaID 
RIGHT OUTER JOIN (SELECT cc.CallID,
                   CASE dc.DonorCategoryID
                     WHEN 1 THEN cc.OrganCriteriaID
                     WHEN 2 THEN cc.BoneCriteriaID
                     WHEN 3 THEN cc.TissueCriteriaID
                     WHEN 4 THEN cc.SkinCriteriaID
                     WHEN 5 THEN cc.ValvesCriteriaID
                     WHEN 6 THEN cc.EyesCriteriaID
                     WHEN 7 THEN cc.OtherCriteriaID
                     ELSE 0
                   END CriteriaID,
                  dc.DonorCategoryID, cc.ServiceLevelID
            FROM CallCriteria cc, DonorCategory dc, ServiceLevel sl
            WHERE cc.ServiceLevelID = sl.ServiceLevelID
            AND   cc.CallID         = @CallID) t ON sc.CriteriaID = t.CriteriaID AND sc.DonorCategoryID = t.DonorCategoryID
ORDER BY t.CallID, t.DonorCategoryID, cst.SubCriteriaPrecedence, sc.ProcessorPrecedence, sg.ScheduleGroupName

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

