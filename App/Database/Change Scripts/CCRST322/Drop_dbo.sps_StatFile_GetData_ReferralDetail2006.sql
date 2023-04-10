/******************************************************************************
**		File: Drop_dbo.sps_StatFile_GetData_ReferralDetail2006.sql
**		Name: Drop dbo.sps_StatFile_GetData_ReferralDetail2006
**		Desc: Drop the stored procedure sps_StatFile_GetData_ReferralDetail2006 -
**				because we're not using it anymore
**
**		Auth: Mike Berenson
**		Date: 5/18/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      05/18/2020	Mike Berenson		initial
*******************************************************************************/

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_StatFile_GetData_ReferralDetail2006]') AND type = 'P')
BEGIN
	DROP PROCEDURE [dbo].[sps_StatFile_GetData_ReferralDetail2006];
END
GO