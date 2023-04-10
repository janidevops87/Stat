IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCallTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCallTypeSelect'
		DROP Procedure TcssListCallTypeSelect
	END
GO

PRINT 'Creating Procedure TcssListCallTypeSelect'
GO

CREATE PROCEDURE dbo.TcssListCallTypeSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListCallTypeSelect
**	Desc: Update Data in table TcssListCallType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
**  12/15/2009	Bret Knoll		pointing type to CallType
***************************************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT 
	CallType.CallTypeID AS ListId,
	CallType.CallTypeName AS FieldValue
FROM 
	dbo.CallType 
WHERE
	(@ListId IS NULL OR CallType.CallTypeID = @ListId)
AND 
	(@FieldValue IS NULL OR CallType.CallTypeName = @FieldValue)	

ORDER BY 	
	CallType.CallTypeName
GO

GRANT EXEC ON TcssListCallTypeSelect TO PUBLIC
GO