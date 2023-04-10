IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'RecycleListCallTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure RecycleListCallTypeSelect'
		DROP Procedure RecycleListCallTypeSelect
	END
GO

PRINT 'Creating Procedure RecycleListCallTypeSelect'
GO

CREATE PROCEDURE dbo.RecycleListCallTypeSelect

AS

/***************************************************************************************************
**	Name: RecycleListCallTypeSelect
**	Desc: Update Data in table RecycleListCallType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	12/05/2010	jth				Initial Sproc Creation 
***************************************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT 
	CallType.CallTypeID AS ListId,
	CallType.CallTypeName AS FieldValue
FROM 
	dbo.CallType 
Where CallTypeID in (1,6)
union
select 
2 as Listid,
'Message/Imports' as FieldValue
ORDER BY 	
	CallType.CallTypeID
GO

GRANT EXEC ON RecycleListCallTypeSelect TO PUBLIC
GO