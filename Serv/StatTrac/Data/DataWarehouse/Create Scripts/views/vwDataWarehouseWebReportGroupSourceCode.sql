IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE NAME = 'vwDataWarehouseWebReportGroupSourceCode' AND TYPE = 'V')
BEGIN
	PRINT 'Dropping View: vwDataWarehouseWebReportGroupSourceCode';
	DROP VIEW [dbo].[vwDataWarehouseWebReportGroupSourceCode];
END
GO

SET QUOTED_IDENTIFIER ON; 
GO
SET ANSI_NULLS ON; 
PRINT 'Creating View: vwDataWarehouseWebReportGroupSourceCode';
GO


CREATE VIEW [dbo].[vwDataWarehouseWebReportGroupSourceCode]
      
AS
      /******************************************************************************
      **          File: 
      **          Name: vwDataWarehouseWebReportGroupSourceCode
      **          Desc: view used to query data from Replicated Reporting DB
      **
      **              
      **          Return values: Table WebReportGroupSourceCode
      ** 
      **          Called by:   AuditTrail Reports
      **              
      **
      **          Auth: Bret Knoll
      **          Date: Aug  4 2011 11:56AM
      *******************************************************************************
      **          Change History
      *******************************************************************************
      **          Date:       Author:                       Description:
      **          --------    --------                -------------------------------------------
      **          10/15/2008  Bret Knoll              Create View
      **          10/28/2010  bret j knoll            fix to use new server/db names
      *******************************************************************************/    
      select * from _ReferralProdReport..[WebReportGroupSourceCode]
      
GO


