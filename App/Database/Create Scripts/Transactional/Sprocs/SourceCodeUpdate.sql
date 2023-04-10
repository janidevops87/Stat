

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeUpdate')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeUpdate'
		DROP Procedure SourceCodeUpdate
	END
GO

PRINT 'Creating Procedure SourceCodeUpdate'
GO
CREATE Procedure SourceCodeUpdate
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
**	File: SourceCodeUpdate.sql
**	Name: SourceCodeUpdate
**	Desc: Updates SourceCode Based on Id field 
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

UPDATE
	dbo.SourceCode 	
SET 
		SourceCodeName = @SourceCodeName,
		SourceCodeDescription = @SourceCodeDescription,
		LastModified = GetDate(),
		SourceCodeType = @SourceCodeType,
		SourceCodeDefaultAlert = @SourceCodeDefaultAlert,
		SourceCodeLineCheckInstruc = @SourceCodeLineCheckInstruc,
		SourceCodeLineCheckInterval = @SourceCodeLineCheckInterval,
		SourceCode1Start = @SourceCode1Start,
		SourceCode1End = @SourceCode1End,
		SourceCode2Start = @SourceCode2Start,
		SourceCode2End = @SourceCode2End,
		SourceCode3Start = @SourceCode3Start,
		SourceCode3End = @SourceCode3End,
		SourceCode4Start = @SourceCode4Start,
		SourceCode4End = @SourceCode4End,
		SourceCode5Start = @SourceCode5Start,
		SourceCode5End = @SourceCode5End,
		SourceCode6Start = @SourceCode6Start,
		SourceCode6End = @SourceCode6End,
		SourceCode7Start = @SourceCode7Start,
		SourceCode7End = @SourceCode7End,
		SourceCodeDisabledInterval = @SourceCodeDisabledInterval,
		SourceCodeNameUnAbbrev = @SourceCodeNameUnAbbrev,
		SourceCodeRotationActive = @SourceCodeRotationActive,
		SourcecodeRotationAlias = @SourcecodeRotationAlias,
		SourcecodeRotationTrue = @SourcecodeRotationTrue,
		SourcecodeDonorTracClient = @SourcecodeDonorTracClient,
		SourceCodeDefault = @SourceCodeDefault,
		Inactive = @Inactive,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), /* 3 modified */
		SourceCodeOrgID = @SourceCodeOrgID,
		SourceCodeCallTypeID = @SourceCodeCallTypeID
WHERE 
	SourceCodeID = @SourceCodeID 				

GO

GRANT EXEC ON SourceCodeUpdate TO PUBLIC
GO
