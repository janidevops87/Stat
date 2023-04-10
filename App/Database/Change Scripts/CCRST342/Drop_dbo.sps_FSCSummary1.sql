/******************************************************************************
**		File: Drop_dbo.sps_FSCSummary1.sql
**		Name: Drop dbo.sps_FSCSummary1
**		Desc: Drop the stored procedure sps_FSCSummary1 -
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_FSCSummary1]') AND type = 'P')
BEGIN
	DROP PROCEDURE [dbo].[sps_FSCSummary1];
END
GO