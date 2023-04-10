IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_MessageActivity')
BEGIN
	DROP PROCEDURE sps_rpt_MessageActivity;
	PRINT 'sps_rpt_MessageActivity';
END
GO
PRINT 'Creating Procedure: sps_rpt_MessageActivity';
GO

CREATE PROCEDURE [dbo].[sps_rpt_MessageActivity]
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @MessageStartDateTime  DATETIME  = NULL,
                @MessageEndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_MessageActivity
**		Desc: 
**
**		This template can be customized:
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
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Added selection for Archive data
**      10/21/08    jth                 added  MessageForOrganizationID
**      04/2009     jth                 changed BasedOnDT to BasedOnDT1 to handle sorting in report
**		12/03/2012	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
*******************************************************************************/
  SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  

--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */

  DECLARE  @CustomCode  AS INT,
           @Results     AS INT
           
  IF @MessageCallerOrganization IS NOT Null
	BEGIN
		SET @MessageCallerOrganization = REPLACE(@MessageCallerOrganization,'*','%')
	END


/*Null out dates if call id is populated */
IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @MessageStartDateTime = NULL
      SET @MessageEndDateTime = NULL
      SET @MessageCallerOrganization = NULL
      SET @MessageFor = NULL

		
	END



CREATE TABLE #sps_rpt_MessageActivityResults
   (
	[CallID][int] NULL, 
	[MessageTypeName][varchar] (50) NULL,
	[CallNumber][varchar] (15) NULL,
	[OrganizationName] [varchar] (80) NULL,
	[MessageCallerName][varchar] (80) NULL,
	[MessageCallerOrganization] [varchar] (80) NULL,
	[MessageCallerPhone][varchar] (20) NULL,
	[BasedOnDT1] [smalldatetime] NULL,
	[MessageForLastName] [varchar] (50) NULL,
	[PersonTypeName] [varchar] (50) NULL,
	[PersonName] [varchar] (150) NULL,
	[ReportCustomCode] [int] NULL,
	[AlertGroupName][varchar] (80) NULL,
    [alertid] [int] NULL
   )

	
			INSERT #sps_rpt_MessageActivityResults 
				EXEC sps_rpt_MessageActivity_Select
							@UserOrgID, @ReportGroupID, @CallID, @MessageStartDateTime, @MessageEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT


 
/* Display Finial Selection */ 
SELECT * FROM #sps_rpt_MessageActivityResults

DROP TABLE #sps_rpt_MessageActivityResults       
       
       

GO

