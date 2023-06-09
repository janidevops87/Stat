SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_CriteriaGroups_Assignments_ByState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_CriteriaGroups_Assignments_ByState]
GO


CREATE PROCEDURE CONTRACTS_CriteriaGroups_Assignments_ByState @StateID INT AS
SET NOCOUNT ON
DECLARE @@i                    INT
DECLARE @@v                    VARCHAR(255)
DECLARE @@OrganizationID       INT
DECLARE @@OrganizationName     VARCHAR(255)
DECLARE @@OrganizationTypeName VARCHAR(255)
DECLARE @@Organs               VARCHAR(255)
DECLARE @@Bone                 VARCHAR(255)
DECLARE @@Tissue               VARCHAR(255)
DECLARE @@Skin                 VARCHAR(255)
DECLARE @@Valves               VARCHAR(255)
DECLARE @@Eyes                 VARCHAR(255)
DECLARE @@Other                VARCHAR(255)
DECLARE @CriteriaStatusID 	INT
SELECT 	@CriteriaStatusID = 0

CREATE TABLE #rollup(ID                    INT PRIMARY KEY,
                     OrganizationID        INT,
                     OrganizationName      VARCHAR(255),
                     OrganizationTypeName  VARCHAR(255),
                     Organs                VARCHAR(255),
                     Bone                  VARCHAR(255),
                     Tissue                VARCHAR(255),
                     Skin                  VARCHAR(255),
                     Valves                VARCHAR(255),
                     Eyes                  VARCHAR(255),
                     Other                 VARCHAR(255))
DECLARE cORG cursor for 
  SELECT o.OrganizationID, o.OrganizationName, ot.OrganizationTypeName
  FROM Organization      o,
       OrganizationType  ot
  WHERE o.OrganizationTypeID = ot.OrganizationTypeID
  AND   o.StateID            = @StateID
--  AND   o.OrganizationID in (582, 88, 427)
  ORDER BY o.OrganizationName
OPEN cORG
SELECT @@i = 1
FETCH NEXT FROM cORG INTo @@OrganizationID, @@OrganizationName, @@OrganizationTypeName
WHILE @@fetch_status = 0
  BEGIN
/* ORGANS ******************************************************************************************************************************/
    DECLARE cORGANS cursor for 
      SELECT c.CriteriaGroupName
      FROM Criteria             c,
           CriteriaOrganization co
      WHERE co.CriteriaID        = c.CriteriaID
      AND   co.OrganizationID    = @@OrganizationID
      AND   c.DonorCategoryID    = 1
      AND   c.CriteriaStatus = @CriteriaStatusID
    SELECT @@v = ''
    OPEN cORGANS
    FETCH NEXT FROM cORGANS INTo @@v
    SELECT @@Organs = @@v
    WHILE @@fetch_status = 0
    BEGIN
      FETCH NEXT FROM cORGANS INTo @@v
      if @@fetch_status = 0 SELECT @@Organs = @@Organs + ' ' + @@v
    END
    CLOSE cORGANS
    DEALLOCATE cORGANS
/* BONE ******************************************************************************************************************************/
    DECLARE cBONE cursor for 
      SELECT c.CriteriaGroupName
      FROM Criteria             c,
           CriteriaOrganization co
      WHERE co.CriteriaID        = c.CriteriaID
      AND   co.OrganizationID    = @@OrganizationID
      AND   c.DonorCategoryID    = 2
      AND   c.CriteriaStatus = @CriteriaStatusID
    SELECT @@v = ''
    OPEN cBONE
    FETCH NEXT FROM cBONE INTo @@v
    SELECT @@Bone = @@v
    WHILE @@fetch_status = 0
    BEGIN
      FETCH NEXT FROM cBONE INTo @@v
      if @@fetch_status = 0 SELECT @@Bone = @@Bone + ' ' + @@v
    END
    CLOSE cBONE
    DEALLOCATE cBONE
/* TISSUE ******************************************************************************************************************************/
    DECLARE cTISSUE cursor for 
      SELECT c.CriteriaGroupName
      FROM Criteria             c,
           CriteriaOrganization co
      WHERE co.CriteriaID        = c.CriteriaID
      AND   co.OrganizationID    = @@OrganizationID
      AND   c.DonorCategoryID    = 3
      AND   c.CriteriaStatus = @CriteriaStatusID
    SELECT @@v = ''
    OPEN cTISSUE
    FETCH NEXT FROM cTISSUE INTo @@v
    SELECT @@Tissue = @@v
    WHILE @@fetch_status = 0
    BEGIN
      FETCH NEXT FROM cTISSUE INTo @@v
      if @@fetch_status = 0 SELECT @@Tissue = @@Tissue + ' ' + @@v
    END
    CLOSE cTISSUE
    DEALLOCATE cTISSUE
/* SKIN ******************************************************************************************************************************/
    DECLARE cSKIN cursor for 
      SELECT c.CriteriaGroupName
      FROM Criteria             c,
           CriteriaOrganization co
      WHERE co.CriteriaID        = c.CriteriaID
      AND   co.OrganizationID    = @@OrganizationID
      AND   c.DonorCategoryID    = 4
      AND   c.CriteriaStatus = @CriteriaStatusID
    SELECT @@v = ''
    OPEN cSKIN
    FETCH NEXT FROM cSKIN INTo @@v
    SELECT @@Skin = @@v
    WHILE @@fetch_status = 0
    BEGIN
      FETCH NEXT FROM cSKIN INTo @@v
      if @@fetch_status = 0 SELECT @@Skin = @@Skin + ' ' + @@v
    END
    CLOSE cSKIN
    DEALLOCATE cSKIN
/* VALVES ******************************************************************************************************************************/
    DECLARE cVALVES cursor for 
      SELECT c.CriteriaGroupName
      FROM Criteria             c,
           CriteriaOrganization co
      WHERE co.CriteriaID        = c.CriteriaID
      AND   co.OrganizationID    = @@OrganizationID
      AND   c.DonorCategoryID    = 5
      AND   c.CriteriaStatus = @CriteriaStatusID
    SELECT @@v = ''
    OPEN cVALVES
    FETCH NEXT FROM cVALVES INTo @@v
    SELECT @@Valves = @@v
    WHILE @@fetch_status = 0
    BEGIN
      FETCH NEXT FROM cVALVES INTo @@v
      if @@fetch_status = 0 SELECT @@Valves = @@Valves + ' ' + @@v
    END
    CLOSE cVALVES
    DEALLOCATE cVALVES
/* EYES ******************************************************************************************************************************/
    DECLARE cEYES cursor for 
      SELECT c.CriteriaGroupName
      FROM Criteria             c,
           CriteriaOrganization co
      WHERE co.CriteriaID        = c.CriteriaID
      AND   co.OrganizationID    = @@OrganizationID
      AND   c.DonorCategoryID    = 6
      AND   c.CriteriaStatus = @CriteriaStatusID
    SELECT @@v = ''
    OPEN cEYES
    FETCH NEXT FROM cEYES INTo @@v
    SELECT @@Eyes = @@v
    WHILE @@fetch_status = 0
    BEGIN
      FETCH NEXT FROM cEYES INTo @@v
      if @@fetch_status = 0 SELECT @@Eyes = @@Eyes + ', ' + @@v
    END
    CLOSE cEYES
    DEALLOCATE cEYES
/* OTHER ******************************************************************************************************************************/
    DECLARE cOTHER cursor for 
      SELECT c.CriteriaGroupName
      FROM Criteria             c,
           CriteriaOrganization co
      WHERE co.CriteriaID        = c.CriteriaID
      AND   co.OrganizationID    = @@OrganizationID
      AND   c.DonorCategoryID    = 7
      AND   c.CriteriaStatus = @CriteriaStatusID
    SELECT @@v = ''
    OPEN cOTHER
    FETCH NEXT FROM cOTHER INTo @@v
    SELECT @@Other = @@v
    WHILE @@fetch_status = 0
    BEGIN
      FETCH NEXT FROM cOTHER INTo @@v
      if @@fetch_status = 0 SELECT @@Other = @@Other + ', ' + @@v
    END
    CLOSE cOTHER
    DEALLOCATE cOTHER
/* ROLLUP ******************************************************************************************************************************/
    INSERT #rollup(ID,    OrganizationID,   OrganizationName,   OrganizationTypeName,   Organs,   Bone,   Tissue,   Skin,   Valves,   Eyes,   Other) 
    VALUES        (@@i, @@OrganizationID, @@OrganizationName, @@OrganizationTypeName, @@Organs, @@Bone, @@Tissue, @@Skin, @@Valves, @@Eyes, @@Other)
    FETCH NEXT FROM cORG INTo @@OrganizationID, @@OrganizationName, @@OrganizationTypeName
    SELECT @@i=@@i+1
  END
CLOSE cORG
DEALLOCATE cORG
SELECT *
FROM #rollup
DROP TABLE #rollup


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

