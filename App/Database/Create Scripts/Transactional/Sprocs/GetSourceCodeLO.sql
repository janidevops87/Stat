 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetSourceCodeLO')
	BEGIN
		PRINT 'Dropping Procedure GetSourceCodeLO'
		DROP Procedure GetSourceCodeLO
	END
GO

PRINT 'Creating Procedure GetSourceCodeLO'
GO
CREATE Procedure GetSourceCodeLO
(
		@SourceCodeID int = null,
		@SourceCodeType int = null,
		@SourceCodeName nvarchar(250) =  null,
		@SourceCodeLeaseOrganizationID int = null
		
)
AS
/******************************************************************************
**	File: GetSourceCodeLO.sql
**	Name: GetSourceCodeLO
**	Desc: Selects SourceCode Based on Id typeID and Name fields
**        Called from FrmReferral 
**	Auth: ccarroll
**	Date: 04/11/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	04/11/2011		ccarroll			Initial
*******************************************************************************/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT DISTINCT
		SourceCode.SourceCodeID,
		SourceCode.SourceCodeName,
		SourceCode.SourceCodeDescription,
		SourceCode.SourceCodeType,
		SourceCode.SourceCodeDefaultAlert,
		SourceCode.SourceCodeLineCheckInstruc,
		SourceCode.SourceCodeLineCheckInterval,
		SourceCode.SourceCode1Start,
		SourceCode.SourceCode2Start,
		SourceCode.SourceCode3Start,
		SourceCode.SourceCode4Start,
		SourceCode.SourceCode5Start,
		SourceCode.SourceCode6Start,
		SourceCode.SourceCode7Start,
		SourceCode.SourceCode1End,
		SourceCode.SourceCode2End,
		SourceCode.SourceCode3End,
		SourceCode.SourceCode4End,
		SourceCode.SourceCode5End,
		SourceCode.SourceCode6End,
		SourceCode.SourceCode7End,
		IsNull(Organization.OrganizationName, SourceCode.SourceCodeNameUnAbbrev) AS SourceCodeNameUnAbbrev
	FROM 
		SourceCode
	LEFT JOIN
		Organization ON SourceCode.SourceCodeOrgID = Organization.OrganizationID	 

	WHERE 
		SourceCode.SourceCodeID = ISNULL(@SourceCodeID, SourceCode.SourceCodeID) AND 
		SourceCode.SourceCodeType = ISNULL(@SourceCodeType, SourceCode.SourceCodeType) AND
		SourceCode.SourceCodeName = ISNULL(@SourceCodeName, SourceCode.SourceCodeName) AND
		SourceCodeName IN (SELECT DISTINCT SourceCode.SourceCodeName FROM SourceCodeOrganization LEFT JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID Where (SourceCodeType = 2 Or SourceCodeType = 4) AND SourceCodeOrganization.OrganizationID = @SourceCodeLeaseOrganizationID);

		
GO

GRANT EXEC ON GetSourceCodeLO TO PUBLIC
GO
 