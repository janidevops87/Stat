

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeInsert')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeInsert'
		DROP Procedure SourceCodeInsert
	END
GO

PRINT 'Creating Procedure SourceCodeInsert'
GO
CREATE Procedure SourceCodeInsert
(
		@SourceCodeID int = null output,
		@SourceCodeName varchar(10) = null,
		@SourceCodeDescription varchar(200) = null,
		@LastModified datetime = null,
		@SourceCodeType int = null,
		@SourceCodeDefaultAlert nvarchar(max) = null,
		@SourceCodeLineCheckInstruc varchar(255) = null,
		@SourceCodeLineCheckInterval int = null,
		@SourceCode1Start varchar(5) = null,
		@SourceCode1End varchar(5) = null,
		@SourceCode2Start varchar(5) = null,
		@SourceCode2End varchar(5) = null,
		@SourceCode3Start varchar(5) = null,
		@SourceCode3End varchar(5) = null,
		@SourceCode4Start varchar(5) = null,
		@SourceCode4End varchar(5) = null,
		@SourceCode5Start varchar(5) = null,
		@SourceCode5End varchar(5) = null,
		@SourceCode6Start varchar(5) = null,
		@SourceCode6End varchar(5) = null,
		@SourceCode7Start varchar(5) = null,
		@SourceCode7End varchar(5) = null,
		@SourceCodeDisabledInterval smallint = null,
		@SourceCodeNameUnAbbrev varchar(100) = null,
		@SourceCodeRotationActive smallint = null,
		@SourcecodeRotationAlias varchar(50) = null,
		@SourcecodeRotationTrue smallint = null,
		@SourcecodeDonorTracClient smallint = null,
		@SourceCodeDefault bit = null,
		@Inactive bit = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@SourceCodeOrgID int = null,
		@SourceCodeCallTypeID int = null
							
)
AS
/******************************************************************************
**	File: SourceCodeInsert.sql
**	Name: SourceCodeInsert
**	Desc: Inserts SourceCode Based on Id field 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
**  06/16/2011      jth					added if sourcecodelinecheckinterval is null, replace with 0
*******************************************************************************/

INSERT	SourceCode
	(
		SourceCodeName,
		SourceCodeDescription,
		LastModified,
		SourceCodeType,
		SourceCodeDefaultAlert,
		SourceCodeLineCheckInstruc,
		SourceCodeLineCheckInterval,
		SourceCode1Start,
		SourceCode1End,
		SourceCode2Start,
		SourceCode2End,
		SourceCode3Start,
		SourceCode3End,
		SourceCode4Start,
		SourceCode4End,
		SourceCode5Start,
		SourceCode5End,
		SourceCode6Start,
		SourceCode6End,
		SourceCode7Start,
		SourceCode7End,
		SourceCodeDisabledInterval,
		SourceCodeNameUnAbbrev,
		SourceCodeRotationActive,
		SourcecodeRotationAlias,
		SourcecodeRotationTrue,
		SourcecodeDonorTracClient,
		SourceCodeDefault,
		Inactive,
		LastStatEmployeeID,
		AuditLogTypeID,
		SourceCodeOrgID,
		SourceCodeCallTypeID
	)
VALUES
	(
		@SourceCodeName,
		@SourceCodeDescription,
		@LastModified,
		@SourceCodeType,
		@SourceCodeDefaultAlert,
		@SourceCodeLineCheckInstruc,
		ISNULL(@SourceCodeLineCheckInterval, 0),
		@SourceCode1Start,
		@SourceCode1End,
		@SourceCode2Start,
		@SourceCode2End,
		@SourceCode3Start,
		@SourceCode3End,
		@SourceCode4Start,
		@SourceCode4End,
		@SourceCode5Start,
		@SourceCode5End,
		@SourceCode6Start,
		@SourceCode6End,
		@SourceCode7Start,
		@SourceCode7End,
		@SourceCodeDisabledInterval,
		@SourceCodeNameUnAbbrev,
		@SourceCodeRotationActive,
		@SourcecodeRotationAlias,
		@SourcecodeRotationTrue,
		@SourcecodeDonorTracClient,
		@SourceCodeDefault,
		@Inactive,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1), /* insert */
		@SourceCodeOrgID,
		@SourceCodeCallTypeID
	)

SET @SourceCodeID = SCOPE_IDENTITY()

EXEC SourceCodeSelect @SourceCodeID

GO

GRANT EXEC ON SourceCodeInsert TO PUBLIC
GO
