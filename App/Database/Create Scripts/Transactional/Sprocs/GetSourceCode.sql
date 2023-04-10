IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetSourceCode')
	BEGIN
		PRINT 'Dropping Procedure GetSourceCode'
		DROP Procedure GetSourceCode
	END
GO

PRINT 'Creating Procedure GetSourceCode'
GO
CREATE Procedure GetSourceCode
(
		@SourceCodeID int = null,
		@SourceCodeType int = null,
		@SourceCodeName nvarchar(250) =  null
)
AS
/******************************************************************************
**	File: GetSourceCode.sql
**	Name: GetSourceCode
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
**	09/18/2019		mberenson			Replaced ISNULL call in where clause
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
		(@SourceCodeID IS NULL OR SourceCode.SourceCodeID = @SourceCodeID) AND 
		(@SourceCodeType IS NULL OR SourceCode.SourceCodeType = @SourceCodeType) AND
		(@SourceCodeName IS NULL OR SourceCode.SourceCodeName = @SourceCodeName);
		
		
GO

GRANT EXEC ON GetSourceCode TO PUBLIC;
GO
 