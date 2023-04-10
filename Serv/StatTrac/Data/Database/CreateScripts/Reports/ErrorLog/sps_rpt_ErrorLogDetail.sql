IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ErrorLogDetail')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ErrorLogDetail'
		DROP  Procedure  sps_rpt_ErrorLogDetail
	END

GO

PRINT 'Creating Procedure sps_rpt_ErrorLogDetail'
GO
CREATE Procedure sps_rpt_ErrorLogDetail
	/* Param List */
	@ErrorStartDateTime			DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@ErrorSource				varchar(20) = Null,
	@ErrorComputer				varchar(20) = Null,
	@ErrorDescription			varchar(40) = Null
AS

/******************************************************************************
**		File: sps_rpt_ErrorLogDetail.sql
**		Name: sps_rpt_ErrorLogDetail
**		Desc: 
**
**		Optional WHERE value usage examples:
**
**			AND errordescription like '%Incorrect syntax near%'
**			AND errorcomputer like 'ST-CITRIX-3'
**			AND errorcomputer in('%2266%') --and  errorcomputer = 'asa1' --and errornumber = 438
**			AND errordescription like 'ORGNAME:%'
**			AND errordescription like 'PERSONAME: Lau%'
**			AND errordescription like '%USERID: 949%'
**			AND errorcomputer in('tc2202', 'tc2203', 'tc2215', 'tc2205')
**			AND errordescription like '%deadlock%'
**			AND errordescription like '%referral%'
**			AND errordescription like 'Duration%'
**			AND errorlocation like '%665830%'
**			AND errordescription like '%Failed to save call%'
**			AND errordescription like '%sps_QUpdatedReferralEventsLO%'
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**	@ErrorStartDateTime			DateTime
**	@ErrorEndDateTime			DateTime
**	@ErrorSource				varchar(20)
**	@ErrorComputer				varchar(20)
**	@ErrorDescription			varchar(40)
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/

	SELECT DISTINCT 
			--[ErrorID], 
			[ErrorDateTime], 
			--[ErrorNumber], 
			rtrim([ErrorComputer]) AS ErrorComputer, 
			[ErrorSource], 
			[ErrorLocation], 
			[ErrorDescription]  
	FROM
			error
	WHERE 
			errordatetime BETWEEN @ErrorStartDateTime AND @ErrorEndDateTime
			AND errorsource LIKE IsNull(@ErrorSource, errorsource)
			AND errorcomputer LIKE isNull(@ErrorComputer, errorcomputer)
			AND errordescription LIKE isNull(@ErrorDescription, errordescription)
			ORDER BY errordatetime DESC


GO

