IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeSelect')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeSelect'
		DROP Procedure SourceCodeSelect
	END
GO

PRINT 'Creating Procedure SourceCodeSelect'
GO
CREATE Procedure SourceCodeSelect
(
		@SourceCodeID int = null output
)
AS
/******************************************************************************
**	File: SourceCodeSelect.sql
**	Name: SourceCodeSelect
**	Desc: Selects multiple rows of SourceCode Based on Id  fields 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	--IF @SourceCodeID =0
	--	BEGIN
	--		/* Display All  */
	--		SET @SourceCodeID =null
	--	END
	
	SELECT
		SourceCode.SourceCodeID,
		SourceCode.SourceCodeName,
		SourceCode.SourceCodeDescription,
		SourceCode.LastModified,
		SourceCode.SourceCodeType,
		SourceCode.SourceCodeDefaultAlert,
		SourceCode.SourceCodeLineCheckInstruc,
		SourceCode.SourceCodeLineCheckInterval,
		SourceCode.SourceCode1Start,
		SourceCode.SourceCode1End,
		SourceCode.SourceCode2Start,
		SourceCode.SourceCode2End,
		SourceCode.SourceCode3Start,
		SourceCode.SourceCode3End,
		SourceCode.SourceCode4Start,
		SourceCode.SourceCode4End,
		SourceCode.SourceCode5Start,
		SourceCode.SourceCode5End,
		SourceCode.SourceCode6Start,
		SourceCode.SourceCode6End,
		SourceCode.SourceCode7Start,
		SourceCode.SourceCode7End,
		SourceCode.SourceCodeDisabledInterval,
		SourceCode.SourceCodeNameUnAbbrev,
		SourceCode.SourceCodeRotationActive,
		SourceCode.SourcecodeRotationAlias,
		SourceCode.SourcecodeRotationTrue,
		COALESCE(SourceCode.SourcecodeDonorTracClient, 0) AS SourcecodeDonorTracClient,
		SourceCode.SourceCodeDefault,
		COALESCE(SourceCode.Inactive, 0) AS Inactive,
		SourceCode.LastStatEmployeeID,
		SourceCode.AuditLogTypeID,
		SourceCode.SourceCodeOrgID,
		SourceCode.SourceCodeCallTypeID
	FROM 
		dbo.SourceCode 

	WHERE 
		SourceCode.SourceCodeID = ISNULL(@SourceCodeID, SourceCode.SourceCodeID)
	ORDER BY 2 -- SourceCodeName
GO

GRANT EXEC ON SourceCodeSelect TO PUBLIC
GO
