
IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AspSourceCodeMapMerge')
	BEGIN
		PRINT 'Dropping Procedure AspSourceCodeMapMerge'
		DROP Procedure AspSourceCodeMapMerge
	END
GO

PRINT 'Creating Procedure AspSourceCodeMapMerge'
GO
CREATE Procedure AspSourceCodeMapMerge
(
		@AspSourceCodeMapID int = null output,
		@SourceCodeID int = null,
		@AspSourceCodeID int = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@AspSourceCodeName varchar(10) = null					
)
AS
/******************************************************************************
**	File: AspSourceCodeMapMerge.sql
**	Name: AspSourceCodeMapMerge
**	Desc: Merges AspSourceCodeMap Based on Id field
**  Note: When an alternate SourceCode is added, it must be created (inserted) twice to 
**		  effectively show linkage from both sourcecode perspectives. The alternate ID is
**		  used to insert this record. 
**	Auth: ccarroll
**	Date: 08/17/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	08/17/2010		ccarroll			Initial Sproc Creation
*******************************************************************************/
DECLARE @SourceCodeName varchar(10) = (SELECT SourceCodeName FROM SourceCode WHERE SourceCodeID = @SourceCodeID)
DECLARE @AspSourceCodeMapAlternateID int


IF IsNull(@AspSourceCodeMapID, -1) > 0
/* This is an update. Get The Alternate ID*/
BEGIN
	DECLARE @OldAspSourceCodeID int
	SET @OldAspSourceCodeID = (SELECT AspSourceCodeID FROM AspSourceCodeMap WHERE AspSourceCodeMapID = @AspSourceCodeMapID)
	SET @AspSourceCodeMapAlternateID = (SELECT TOP 1 AspSourceCodeMapID FROM AspSourceCodeMap 
										WHERE AspSourceCodeID = @SourceCodeID AND
											  SourceCodeID =  @OldAspSourceCodeID)
END

IF @AspSourceCodeName is Null
BEGIN
	SET @AspSourceCodeName = (SELECT SourceCodeName FROM SourceCode WHERE SourceCodeID = @ASPSourceCodeID) 
END


MERGE dbo.AspSourceCodeMap AS target
USING	(SELECT
		@AspSourceCodeMapID,
		@SourceCodeID,
		@AspSourceCodeID,
		@AspSourceCodeName) AS source
		(AspSourceCodeMapID,
		SourceCodeID,
		AspSourceCodeID,
		AspSourceCodeName)
ON (target.AspSourceCodeMapID = source.AspSourceCodeMapID)
 
WHEN MATCHED THEN

	UPDATE  
		SET /* Pirmary record */
			SourceCodeID = @SourceCodeId,
			AspSourceCodeID = @AspSourceCodeID,
			AspSourceCodeName = @AspSourceCodeName,
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = IsNull(@AuditLogTypeID, 3)-- Modify

WHEN NOT MATCHED THEN
	INSERT	
		(	/* primary record */
			SourceCodeID,
			AspSourceCodeID,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID,
			AspSourceCodeName
		)
	VALUES
		(
			@SourceCodeID,
			@AspSourceCodeID,
			GetDate(), --@LastModified,
			@LastStatEmployeeID,
			ISNULL(@AuditLogTypeID, 1), -- Create
			@AspSourceCodeName
		);

/* SET Primary record identity */
SET @AspSourceCodeMapID = SCOPE_IDENTITY()
EXEC AspSourceCodeMapSelect @AspSourceCodeMapID;

/* Add Alternate record */
MERGE dbo.AspSourceCodeMap AS target
USING	(SELECT
		@AspSourceCodeMapAlternateID,
		@AspSourceCodeID,
		@SourceCodeID,
		@SourceCodeName) AS source
		(AspSourceCodeMapID,
		SourceCodeID,
		AspSourceCodeID,
		AspSourceCodeName)
ON (target.AspSourceCodeMapID = source.AspSourceCodeMapID)
 
WHEN MATCHED THEN

	UPDATE  
		SET /* Alternate record */
			SourceCodeID = @AspSourceCodeId,
			AspSourceCodeID = @SourceCodeID,
			AspSourceCodeName = @SourceCodeName,
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = IsNull(@AuditLogTypeID, 3)-- Modify

WHEN NOT MATCHED THEN
	INSERT	
		(	/* primary record */
			SourceCodeID,
			AspSourceCodeID,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID,
			AspSourceCodeName
		)
	VALUES
		(
			@AspSourceCodeID,
			@SourceCodeID,
			GetDate(), --@LastModified,
			@LastStatEmployeeID,
			ISNULL(@AuditLogTypeID, 1), -- Create
			@SourceCodeName
		);


GRANT EXEC ON AspSourceCodeMapMerge TO PUBLIC
GO
