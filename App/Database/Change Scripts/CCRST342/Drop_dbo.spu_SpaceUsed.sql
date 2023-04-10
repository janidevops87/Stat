/******************************************************************************
**		File: Drop_dbo.spu_SpaceUsed.sql
**		Name: Drop dbo.spu_SpaceUsed
**		Desc: Drop the stored procedure spu_SpaceUsed -
**				because we're not using it anymore
**
**		Auth: Mike Berenson
**		Date: 04/16/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      04/16/2021	Mike Berenson		initial
*******************************************************************************/

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spu_SpaceUsed]') AND type = 'P')
BEGIN
	DROP PROCEDURE [dbo].[spu_SpaceUsed];
END
GO