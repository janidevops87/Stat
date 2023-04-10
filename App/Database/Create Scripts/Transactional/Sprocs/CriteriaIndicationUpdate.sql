  IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaIndicationUpdate')
	BEGIN
		PRINT 'Dropping Procedure CriteriaIndicationUpdate'
		DROP Procedure CriteriaIndicationUpdate
	END
GO

PRINT 'Creating Procedure CriteriaIndicationUpdate'
GO
CREATE Procedure CriteriaIndicationUpdate
(
		@CriteriaIndicationID int = null output,
		@CriteriaID int = null,
		@IndicationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: CriteriaIndicationUpdate.sql
**	Name: CriteriaIndicationUpdate
**	Desc: Updates CriteriaIndication Based on Id field 
**	Auth: ccarroll
**	Date: 12/22/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/22/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.CriteriaIndication 	
SET 
		CriteriaID = @CriteriaID,
		IndicationID = @IndicationID,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	CriteriaIndicationID = @CriteriaIndicationID 				

GO

GRANT EXEC ON CriteriaIndicationUpdate TO PUBLIC
GO
