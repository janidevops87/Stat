
GO
/****** Object:  StoredProcedure [dbo].[sps_rpt_FSConversionRate]    Script Date: 11/20/2008 11:00:35 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE name = 'sps_rpt_FSConversionRate' AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROPPING PROCEDURE [dbo].[sps_rpt_FSConversionRate]'
	DROP PROCEDURE [dbo].[sps_rpt_FSConversionRate]

END

	PRINT 'CREATING PROCEDURE [dbo].[sps_rpt_FSConversionRate]'

GO
/****** Object:  StoredProcedure [dbo].[sps_rpt_FSConversionRate]    Script Date: 11/20/2008 10:59:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sps_rpt_FSConversionRate]
	/* Report selection criteria */
	@BoneSkinOnly		int		= NULL,

	/* Sproc input data */
	@StartDateTime		datetime	= NULL ,
	@EndDateTime		datetime  	= NULL ,
	@ReportGroupID		int	= NULL , 
	@OrganizationID		int		= NULL ,
	@SourceCodeName		varchar (10)	= NULL ,
	@ApproachPersonID	int		= NULL 

AS

/******************************************************************************
**		File: sps_rpt_FSConversionRate.sql
**		Name: sps_rpt_FSConversionRate
**		Desc: This stored procedure determines which FSConversionRate report to run based on  
**		parameters passed by the report criteria selection.
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   FS Conversion Rate.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@BoneSkinOnly
**		@StartDateTime						@StartDateTime
**		@EndDateTime						@EndDateTime
**		@ReportGroupID						@ReportGroupID
**		@OrganizationID						@OrganizationID
**		@SourceCodeName						@SourceCodeName
**		@ApproachPersonID					@ApproachPersonID
**
**
**
**		Auth: Christopher Carroll
**		Date: 04/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      04/10/2007		Christopher Carroll		Initial release
****************************************************************************/


IF @BoneSkinOnly = 1
	BEGIN
	/* Run the FSConversionRate report for Bone and Skin Only */
		exec sps_rpt_FSConversionRateBoneSkin @StartDateTime, @EndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @ApproachPersonID
	END

  ELSE

	BEGIN
	/* Run the FSConversionRate report for All category */
		exec sps_rpt_FSConversionRateAll @StartDateTime, @EndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @ApproachPersonID
	END

  

