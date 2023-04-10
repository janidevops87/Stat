IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'OrganizationSearchSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationSearchSelect'
		DROP Procedure OrganizationSearchSelect
	END
GO

PRINT 'Creating Procedure: OrganizationSearchSelect'
GO
 
CREATE PROCEDURE [dbo].[OrganizationSearchSelect]
(
	@OrganizationId int = NULL, 
	@SourceCodeId int = NULL, 
	@OrganizationName varchar(80) = NULL, 
	@StateId int = NULL, 
	@OrganizationTypeId int = NULL, 
	@ContractedStatlineClient bit = NULL, 
	@DisplayAllOrganizations bit = 0, 
	@AdministrationGroupFieldValue nvarchar(125)= NULL,
	@CountyID int = NULL,
	@userOrganizationID int = NULL,
	@organizationAliasName varchar(80) = NULL 
)
/******************************************************************************
**		File: OrganizationSearchSelect.sql
**		Name: OrganizationSearchSelect
**		Desc:  Used on Organization Search StatTrac .net
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 6/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		6/19/2009	bret	initial
**      10/15/09    jth     added countyid and stateid for dupe grid and to facilitate filter
**							also changed physical address code to test for null(not returning values when some fields were null
**                          and added sourcecodeid for delete screen and related orgs   
**		11/12/2010	bret	Removed Organization limitation by SourceCode, Cleaned up and addressed performance. 
**		11/15/2010	bret	Placed GetOrganizationsByAdministrationGroup into a Left Join 
**		04/13/2011  ccarroll Removed SoundEx (WHERE DIFFERENCE) causing issues with wildcard(*) searches.	
**		06/24/2011	Bret	Fixed Query
*******************************************************************************/
AS
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

-- check params and modify if necessary
IF (@UserOrganizationId = 194)
	SET @UserOrganizationId = 0
SELECT 
	DISTINCT 	
	Organization.OrganizationID, 
	Organization.OrganizationName, 
	Organization.OrganizationCity, 
	State.StateAbbrv, 	 
	OrganizationType.OrganizationTypeName, 
	vwOrganizationSourceCode.SourceCodeList AS AssociatedSourceCodes, 
	County.CountyName, 
	COALESCE(Organization.OrganizationAddress1, '')
	+ ', ' 
	+ COALESCE(Organization.OrganizationAddress2, '') 
    + ' ' 
    + COALESCE(Organization.OrganizationCity, '')
    + ', ' 
    + COALESCE(State.StateAbbrv, '') 
    + ' ' 
    + COALESCE(Organization.OrganizationZipCode, '') AS PhysicalAddress,
	
	CASE 
		WHEN COALESCE(Organization.OrganizationStatusID, 1) = 3 THEN 1 -- 1 is Active / Not Verified
		ELSE   0
	END AS Inactive,
	Organization.CountyID,
	Organization.StateID 
FROM         
	Organization 
LEFT JOIN
	OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID 
LEFT JOIN
	State ON Organization.StateID = State.StateID
LEFT JOIN
	County ON Organization.CountyID = County.CountyID
LEFT JOIN
	SourceCodeOrganization ON Organization.OrganizationID = SourceCodeOrganization.OrganizationID		
LEFT JOIN 
	vwOrganizationSourceCode ON Organization.OrganizationID = vwOrganizationSourceCode.OrganizationID		
LEFT JOIN
	GetOrganizationsByAdministrationGroup(@AdministrationGroupFieldValue) AdministrationGroup ON Organization.OrganizationID = AdministrationGroup.OrganizationID		
LEFT JOIN
	SourceCode ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID	
LEFT JOIN
	OrganizationAlias ON Organization.OrganizationID = OrganizationAlias.OrganizationID
-- Limits ASP Users
-- UserOrganizatinId
-- Note 1: The JOIN and where statement with he same Note 1: is used to limit ASP to their sourceCode Organization
LEFT OUTER JOIN
	(	
		SELECT 
			SourceCode.SourceCodeName, SourceCode.SourceCodeId
		FROM
			SourceCodeOrganization
		JOIN
			SourceCode ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID
			AND SourceCodeOrganization.OrganizationID = @UserOrganizationId	
			AND (SourceCode.SourceCodeType = 2 OR SourceCode.SourceCodeType = 4)	
			-- 2 = Message, 4 = Import
	) 	ASPSourceCodeOrganization ON SourceCode.SourceCodeName = ASPSourceCodeOrganization.SourceCodeName
	
WHERE   
-- Limits ASP Users  
-- UserOrganizatinId
-- Note 1: The JOIN and where statement with he same Note 1: is used to limit ASP to their sourceCode Organization
	(	--UserOrganizationId is set to 0 if 194 Statline
		@UserOrganizationId = 0
	OR
		(
		ASPSourceCodeOrganization.SourceCodeID IS NOT NULL				
		)
	)
-- SourceCodeID
AND
	(
		COALESCE(@SourceCodeID, 0) = 0
	OR
		SourceCodeOrganization.SourceCodeID = @SourceCodeID
	)
-- OrganizationName
AND	
	(
		COALESCE(@OrganizationName, '') = ''
	OR	( -- OrganizationName		
			( 
				PATINDEX(REPLACE(@OrganizationName, '*', '%'), Organization.OrganizationName ) > 0 
			)
			
	OR  ( -- Organization Alias
			(
				PATINDEX(REPLACE(@organizationAliasName, '*', '%'), OrganizationAlias.OrganizationAliasName ) > 0 
			)					
		)	
	)
	)
-- State
AND (
		COALESCE(@StateId, 0) = 0
	OR
		COALESCE(Organization.StateID, 0) = @StateId 
	)
-- Organization Type
AND	(
		COALESCE(@OrganizationTypeId,0) = 0
	OR
		COALESCE(Organization.OrganizationTypeID, 0) = @OrganizationTypeId
	)
-- Contracted StatlineClient
AND (	
		COALESCE(@ContractedStatlineClient, -1 ) = -1
		OR
		COALESCE(Organization.ContractedStatlineClient, 0) = @ContractedStatlineClient
	)
-- Display All Organizations
AND (
		@DisplayAllOrganizations = 1
	OR
		COALESCE(Organization.OrganizationStatusID , 1) <> 3
	)
-- Administrative Group
AND ( 
		COALESCE(@AdministrationGroupFieldValue, '') = ''  
	OR
		AdministrationGroup.OrganizationID IS NOT NULL
	)
-- CountyID
AND (
		COALESCE(@CountyID, 0) = 0
	OR
		COALESCE(Organization.CountyID, 0) = @CountyID
	)
-- OrganizationId
AND (
		COALESCE(@OrganizationId, 0) = 0
		OR
		Organization.OrganizationID = @OrganizationId
	)
ORDER BY Organization.OrganizationName, State.StateAbbrv, Organization.OrganizationCity
	RETURN @@Error
GO
