

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'TcssListLabInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssListLabInsert'
		DROP Procedure TcssListLabInsert
	END
GO

PRINT 'Creating Procedure TcssListLabInsert'
GO
CREATE Procedure TcssListLabInsert
(
		@TcssListLabId int = null output,
		@LastUpdateStatEmployeeId int = null,
		@LastUpdateDate datetime = null,
		@SortOrder int = null,
		@IsActive bit = null,
		@FieldValue varchar(100) = null,
		@ConfigVersion bigint = null,
		@IsLiver bit = null,
		@IsKidney bit = null					
)
AS
/******************************************************************************
**	File: TcssListLabInsert.sql
**	Name: TcssListLabInsert
**	Desc: Inserts TcssListLab Based on Id field 
**	Auth: Bret Knoll
**	Date: 12/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/23/2009		Bret Knoll			Initial Sproc Creation
*******************************************************************************/

INSERT	TcssListLab
	(
		LastUpdateStatEmployeeId,
		LastUpdateDate,
		SortOrder,
		IsActive,
		FieldValue,
		ConfigVersion,
		IsLiver,
		IsKidney
	)
VALUES
	(
		@LastUpdateStatEmployeeId,
		@LastUpdateDate,
		@SortOrder,
		@IsActive,
		@FieldValue,
		@ConfigVersion,
		@IsLiver,
		@IsKidney
	)

SET @TcssListLabID = SCOPE_IDENTITY()

EXEC TcssListLabSelect @TcssListLabID

GO

GRANT EXEC ON TcssListLabInsert TO PUBLIC
GO
