IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_MessageDetail')
BEGIN
	DROP PROCEDURE sps_rpt_MessageDetail;
	PRINT 'sps_rpt_MessageDetail';
END
GO
PRINT 'Creating Procedure: sps_rpt_MessageDetail';
GO

CREATE PROCEDURE [dbo].[sps_rpt_MessageDetail]
	@UserOrgID      INT  = NULL,
	@ReportGroupID  INT  = NULL,
	@CallID         INT  = NULL,
	@StartDateTime  DATETIME  = NULL,
	@EndDateTime    DATETIME  = NULL,
	@SourceCodeName VARCHAR(50),
	@DisplayMT      INT  = NULL
AS

/******************************************************************************
**		File: sps_rpt_MessageDetail.sql
**		Name: sps_rpt_MessageDetail
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				---------------------------------------
**		10/01/2008	ccarroll			Added selection for Archive data
**		03/15/2010	James Gerberich		Expanded MessageCallerPhone column to 
**										(VarChar(25))accomodate the extension
**										number.  HS #22712
**		06/16/2010	Bret				Modified to Include in Release
**		12/03/12	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */  

/*Null out dates if call id is populated */
IF @CallID IS NOT NULL
    BEGIN
      SET @StartDateTime = NULL
      SET @EndDateTime = NULL

	END



CREATE TABLE #sps_rpt_MessageDetailResults
   (
		[CallID][int] NULL, 
		[MessageTypeName][varchar] (50) NULL,
		[CallNumber][varchar] (15) NULL,
		[OrganizationName] [varchar] (80) NULL,
		[MessageCallerName][varchar] (80) NULL,
		[MessageCallerOrganization] [varchar] (80) NULL,
		[MessageCallerPhone][varchar] (30) NULL,
		[CallDateTime] [smalldatetime] NULL,
		[MessageUrgent] [smallint] NULL,
		[MessageDescription] [varchar] (1000) NULL,
		[MessageForLastName] [varchar] (50) NULL,
		[PersonTypeName] [varchar] (50) NULL,
		[PersonName] [varchar] (150) NULL,
		[ReportCustomCode] [int] NULL,
		[SourceCodeName] [varchar] (50) NULL,
		[TrigageCoord] [varchar] (150) NULL
   )

		INSERT #sps_rpt_MessageDetailResults 
			EXEC sps_rpt_MessageDetail_Select
						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT


/* Display Finial Selection */ 
SELECT * FROM #sps_rpt_MessageDetailResults

DROP TABLE #sps_rpt_MessageDetailResults       



GO
