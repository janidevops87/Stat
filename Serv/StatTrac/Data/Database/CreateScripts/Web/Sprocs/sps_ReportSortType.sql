 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportSortType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportSortType]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

 CREATE PROCEDURE sps_ReportSortType
	@ReportID INT = NULL
 AS 
/******************************************************************************
**		File: sps_ReportSortType.sql
**		Name: sps_ReportSortType
**		Desc: Selects records a given reports sort options
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		ReportID
**
**		Auth: Bret Knoll
**		Date: 4/23/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		4/23/2007		Bret Knoll				initial
*******************************************************************************/

 SELECT 
	
	rdt.ReportSortTypeName ,
	rdt.ReportSortTypeDisplayname 

FROM	
	ReportSortTypeConfiguration rdtc
JOIN
	ReportSortType rdt ON rdt.ReportSortTypeID = rdtc.ReportSortTypeID
WHERE
	rdtc.Reportid = ISNULL(@ReportID, 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

	