SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps2_FacilityAssignmentsSC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps2_FacilityAssignmentsSC]
GO


/**********************************************************************************************************************************/
/* Last Change: John Dowling                                                                                                      */
/* Change Date: 3/27/2002                                                                                                         */
/*                                                                                                                                */
/* Created to suppliment sps_FacilityAssignmentsSC to provide a single set of records for web report at location                  */
/* http://whippet/loginstatline/reports/custom/Assignments.sls                                                                    */
/*                                                                                                                                */
/**********************************************************************************************************************************/
CREATE PROCEDURE sps2_FacilityAssignmentsSC @SourceCodeID int AS
DECLARE @@i                      int
DECLARE @@OrganizationID         int
DECLARE @@OrganizationTypeName   varchar(255)
DECLARE @@OrganizationName       varchar(255)
DECLARE @@OrganizationAddress1   varchar(255)
DECLARE @@OrganizationAddress2   varchar(255)
DECLARE @@OrganizationCity       varchar(255)
DECLARE @@CountyName             varchar(255)
DECLARE @@StateAbbrv             varchar(255)
DECLARE @@OrganizationZipCode    varchar(255)
DECLARE @@Phone                  varchar(255)
DECLARE @@Organ                  varchar(255)
DECLARE @@Tissue                 varchar(255)
DECLARE @@Eyes                   varchar(255)
DECLARE @@SumOrgan               varchar(255)
DECLARE @@SumTissue              varchar(255)
DECLARE @@SumEyes                varchar(255)

CREATE TABLE #rollup(ID                    int,
                     OrganizationID        int,
                     OrganizationTypeName  varchar(255),
                     OrganizationName      varchar(255),
                     OrganizationAddress1  varchar(255),
                     OrganizationAddress2  varchar(255),
                     OrganizationCity      varchar(255),
                     CountyName            varchar(255),
                     StateAbbrv            varchar(255),
                     OrganizationZipCode   varchar(255),
                     Phone                 varchar(255),
                     OrganAssigned         varchar(255),
                     TissueAssigned        varchar(255),
                     EyesAssigned          varchar(255))

DECLARE cROLLUP CURSOR FOR 
  SELECT o.OrganizationID,
         o.OrganizationName,
         ot.OrganizationTypeName
  FROM Organization o
  JOIN SourceCodeOrganization sco ON o.OrganizationID     = sco.OrganizationID
  LEFT JOIN OrganizationType ot   ON o.OrganizationTypeID = ot.OrganizationTypeID
  WHERE ot.OrganizationTypeName IS NOT null
  AND   sco.SourceCodeID = @SourceCodeID
  ORDER BY ot.OrganizationTypeName, o.OrganizationName

OPEN cROLLUP
SELECT @@i = 1
FETCH NEXT FROM cROLLUP INTO @@OrganizationID, @@OrganizationName, @@OrganizationTypeName
WHILE @@fetch_status = 0
  BEGIN

    /* ORGAN ******************************************************************************************************************************/
    DECLARE cORGAN CURSOR FOR 
      SELECT DISTINCT OrganizationAssigned.OrganizationUserCode
      FROM Organization o
      JOIN ScheduleGroupOrganization            ON ScheduleGroupOrganization.OrganizationID = o.OrganizationID 
      JOIN ScheduleGroup                        ON  ScheduleGroup.ScheduleGroupID           = ScheduleGroupOrganization.ScheduleGroupID 
      JOIN Organization AS OrganizationAssigned ON  OrganizationAssigned.OrganizationID     = ScheduleGroup.OrganizationID 
      JOIN CriteriaScheduleGroup                ON CriteriaScheduleGroup.ScheduleGroupID    = ScheduleGroup.ScheduleGroupID 
      JOIN CriteriaOrganization                 ON CriteriaOrganization.CriteriaID          = CriteriaScheduleGroup.CriteriaID
      JOIN Criteria                             ON Criteria.CriteriaID                      = CriteriaScheduleGroup.CriteriaID 
      AND                                          ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
      WHERE o.OrganizationID         = @@OrganizationID
      AND   Criteria.DonorCategoryID = 1
      ORDER BY OrganizationAssigned.OrganizationUserCode

    OPEN cORGAN
    FETCH NEXT FROM cORGAN INTO @@Organ
    SELECT @@SumOrgan = @@Organ
    WHILE @@fetch_status = 0
    BEGIN
      FETCH NEXT FROM cORGAN INTO @@Organ
      IF @@fetch_status = 0 SELECT @@SumOrgan = @@SumOrgan + ', ' + @@Organ
    END

    CLOSE cORGAN
    DEALLOCATE cORGAN

    /* TISSUE ******************************************************************************************************************************/
    DECLARE cTISSUE CURSOR FOR 
      SELECT DISTINCT OrganizationAssigned.OrganizationUserCode
      FROM Organization o
      JOIN ScheduleGroupOrganization            ON ScheduleGroupOrganization.OrganizationID = o.OrganizationID 
      JOIN ScheduleGroup                        ON  ScheduleGroup.ScheduleGroupID           = ScheduleGroupOrganization.ScheduleGroupID 
      JOIN Organization AS OrganizationAssigned ON  OrganizationAssigned.OrganizationID     = ScheduleGroup.OrganizationID 
      JOIN CriteriaScheduleGroup                ON CriteriaScheduleGroup.ScheduleGroupID    = ScheduleGroup.ScheduleGroupID 
      JOIN CriteriaOrganization                 ON CriteriaOrganization.CriteriaID          = CriteriaScheduleGroup.CriteriaID
      JOIN Criteria                             ON Criteria.CriteriaID                      = CriteriaScheduleGroup.CriteriaID 
      AND                                          ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
      WHERE o.OrganizationID         = @@OrganizationID
      AND   Criteria.DonorCategoryID = 3
      ORDER BY OrganizationAssigned.OrganizationUserCode

    OPEN cTISSUE
    FETCH NEXT FROM cTISSUE INTO @@Tissue
    SELECT @@SumTissue = @@Tissue
    WHILE @@fetch_status = 0
    BEGIN
      FETCH NEXT FROM cTISSUE INTO @@Tissue
      IF @@fetch_status = 0 SELECT @@SumTissue = @@SumTissue + ', ' + @@Tissue
    END

    CLOSE cTISSUE
    DEALLOCATE cTISSUE

    /* EYES ******************************************************************************************************************************/
    DECLARE cEYES CURSOR FOR 
      SELECT DISTINCT OrganizationAssigned.OrganizationUserCode
      FROM Organization o
      JOIN ScheduleGroupOrganization            ON ScheduleGroupOrganization.OrganizationID = o.OrganizationID 
      JOIN ScheduleGroup                        ON  ScheduleGroup.ScheduleGroupID           = ScheduleGroupOrganization.ScheduleGroupID 
      JOIN Organization AS OrganizationAssigned ON  OrganizationAssigned.OrganizationID     = ScheduleGroup.OrganizationID 
      JOIN CriteriaScheduleGroup                ON CriteriaScheduleGroup.ScheduleGroupID    = ScheduleGroup.ScheduleGroupID 
      JOIN CriteriaOrganization                 ON CriteriaOrganization.CriteriaID          = CriteriaScheduleGroup.CriteriaID
      JOIN Criteria                             ON Criteria.CriteriaID                      = CriteriaScheduleGroup.CriteriaID 
      AND                                          ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
      WHERE o.OrganizationID         = @@OrganizationID
      AND   Criteria.DonorCategoryID = 6
      ORDER BY OrganizationAssigned.OrganizationUserCode

    OPEN cEYES
    FETCH NEXT FROM cEYES INTO @@Eyes
    SELECT @@SumEyes = @@Eyes
    WHILE @@fetch_status = 0
    BEGIN
      FETCH NEXT FROM cEYES INTO @@Eyes
      IF @@fetch_status = 0 SELECT @@SumEyes = @@SumEyes + ', ' + @@Eyes
    END

    CLOSE cEYES
    DEALLOCATE cEYES

    /* ORG Address ************************************************************************************************************************/
    SELECT @@Phone                = '('+ isnull(PhoneAreaCode,'') +') '+ isnull(PhonePrefix,'') +'-'+ isnull(PhoneNumber,''),
           @@OrganizationAddress1 = OrganizationAddress1,
           @@OrganizationAddress2 = OrganizationAddress2, 
           @@OrganizationCity     = OrganizationCity, 
           @@CountyName           = CountyName, 
           @@StateAbbrv           = StateAbbrv, 
           @@OrganizationZipCode  = OrganizationZipCode
    FROM Organization
    LEFT JOIN County on Organization.CountyID = County.CountyID 
    LEFT JOIN State  on Organization.StateID  = State.StateID 
    LEFT JOIN Phone  on Organization.PhoneID  = Phone.PhoneID
    WHERE OrganizationID = @@OrganizationID

    INSERT #rollup(ID,    OrganizationID,   OrganizationTypeName,   OrganizationName,    OrganizationAddress1,  OrganizationAddress2,   OrganizationCity,   CountyName,   StateAbbrv,   OrganizationZipCode,   Phone, OrganAssigned, TissueAssigned, EyesAssigned)
    VALUES        (@@i, @@OrganizationID, @@OrganizationTypeName, @@OrganizationName, @@OrganizationAddress1, @@OrganizationAddress2, @@OrganizationCity, @@CountyName, @@StateAbbrv, @@OrganizationZipCode, @@Phone, @@SumOrgan,    @@SumTissue,    @@SumEyes)

    FETCH NEXT FROM cROLLUP INTO @@OrganizationID, @@OrganizationName, @@OrganizationTypeName
    SELECT @@i=@@i+1
  END
CLOSE cROLLUP
DEALLOCATE cROLLUP

SELECT *
FROM #rollup

DROP TABLE #rollup






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

