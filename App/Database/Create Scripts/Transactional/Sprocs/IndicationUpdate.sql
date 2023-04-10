IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'IndicationUpdate')
	BEGIN
		PRINT 'Dropping Procedure IndicationUpdate'
		DROP Procedure IndicationUpdate
	END
GO

PRINT 'Creating Procedure IndicationUpdate'
GO
CREATE Procedure IndicationUpdate
(
		@IndicationID int = null output,
		@IndicationName varchar(80) = null,
		@IndicationNote varchar(255) = null,
		@Verified smallint = null,
		@Inactive smallint = null,
		@LastModified datetime = null,
		@IndicationHighRisk smallint = null,
		@UpdatedFlag smallint = null,
		@IndicationResponseID int = null,
		@IndicationResponseName nvarchar(50) = null,
		@IndicationQuestionAssociatedID int = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: IndicationUpdate.sql
**	Name: IndicationUpdate
**	Desc: Updates Indication Based on Id field 
**	Auth: ccarroll
**	Date: 11/20/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/20/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.Indication 	
SET 
		IndicationName = @IndicationName,
		IndicationNote = @IndicationNote,
		Verified = @Verified,
		Inactive = @Inactive,
		LastModified = GetDate(),
		IndicationHighRisk = @IndicationHighRisk,
		UpdatedFlag = @UpdatedFlag,
		IndicationResponseID = @IndicationResponseID,
		IndicationResponseName = @IndicationResponseName,
		IndicationQuestionAssociatedID = @IndicationQuestionAssociatedID,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	IndicationID = @IndicationID 				

GO

GRANT EXEC ON IndicationUpdate TO PUBLIC
GO
