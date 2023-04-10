

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'TcssListLabUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssListLabUpdate'
		DROP Procedure TcssListLabUpdate
	END
GO

PRINT 'Creating Procedure TcssListLabUpdate'
GO
CREATE Procedure TcssListLabUpdate
(
		@TcssListLabId int = null output,
		@LastUpdateStatEmployeeId int = null,
		@LastUpdateDate datetime = null,
		@SortOrder int = null,
		@IsActive bit = null,
		@FieldValue varchar(100) = null,
		@ConfigVersion bigint = null,
		@IsLiver bit = null
		)
AS
/******************************************************************************
**	File: TcssListLabUpdate.sql
**	Name: TcssListLabUpdate
**	Desc: Updates TcssListLab Based on Id field 
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

UPDATE
	dbo.TcssListLab 	
SET 
		LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
		LastUpdateDate = @LastUpdateDate,
		SortOrder = @SortOrder,
		IsActive = @IsActive,
		FieldValue = @FieldValue,
		ConfigVersion = @ConfigVersion,
		IsLiver = @IsLiver
WHERE 
	TcssListLabId = @TcssListLabId 				

GO

GRANT EXEC ON TcssListLabUpdate TO PUBLIC
GO
