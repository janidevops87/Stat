USE DMV_CT
GO
  
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_RegistryStatisticsReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_RegistryStatisticsReport'
	drop procedure [dbo].[sps_RegistryStatisticsReport]
END
GO


PRINT 'Creating Procedure: sps_RegistryStatisticsReport'
GO

CREATE PROCEDURE sps_RegistryStatisticsReport
	@StateDisplayName varchar(50) = NULL
AS
/******************************************************************************
**		File: sps_RegistryStatisticsReport.sql
**		Name: sps_RegistryStatisticsReport
**		Desc: Uses Common registry (CT)
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**	   See above
**
**		Auth: christopher carroll
**		Date: 05/21/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      05/21/2009		ccarroll				initial
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @WebCount int
DECLARE @StateCount int
DECLARE @TotalCount int

DECLARE @WebPercent varchar(50)
DECLARE @StatePercent varchar(50)


DECLARE @CountTable TABLE
	(
		StateDisplayName		varchar(50) Null,
		RegistrySource			varchar(50) Null,
		Totals					int Null,
		TotalPercent			varchar(50) Null,
		GrandTotal				int
	)



SET @WebCount = 
				(SELECT	Count(Donor)
				 FROM		DMV_Common..Registry AS Registry
				 JOIN		DMV_Common..RegistryAddr AS RegistryAddr ON Registry.RegistryID = RegistryAddr.RegistryID AND (RegistryAddr.AddrTypeID =1)
				 WHERE		RegistryAddr.State = 'CT'
							AND IsNull(Registry.Donor, 0) = 1
							AND IsNull(Registry.DonorConfirmed, 0) = 1
				)
				
SET @StateCount =
				(SELECT Count(Donor)
	 			 FROM		DMV
	 			 WHERE		IsNull(Donor, 0) = 1
				)


SET @TotalCount = (@WebCount + @StateCount)

/* Add donor count and percent for Registry*/
	INSERT @CountTable (StateDisplayName, RegistrySource, Totals, TotalPercent, GrandTotal)
			VALUES (@StateDisplayName, 'Web Registry', @WebCount, 
					CASE WHEN @WebCount > 0
						 THEN
							CASE WHEN @TotalCount <= @WebCount THEN '100 %' ELSE
									CAST(CAST((CAST(@WebCount AS Decimal) / CAST(@TotalCount AS Decimal)* 100) AS Numeric(4,1)) AS varchar(50)) + ' %'
									END
							ELSE '-'
					 END,
					 0 --GrandTotal
					)

/* Add donor count and Percent for State*/
	INSERT @CountTable (StateDisplayName, RegistrySource, Totals, TotalPercent, GrandTotal)
			VALUES (@StateDisplayName, 'State Registry', @StateCount,
					CASE WHEN @StateCount > 0
							THEN
								CASE WHEN @TotalCount <= @StateCount THEN '100 %' ELSE
									CAST(CAST((CAST(@StateCount AS Decimal) / CAST(@TotalCount AS Decimal)* 100) AS Numeric(4,1)) AS varchar(50)) + ' %'
									END
							ELSE '-'
					 END,
					 0 --GrandTotal
					)

	INSERT @CountTable (StateDisplayName, RegistrySource, Totals, TotalPercent, GrandTotal)
			VALUES (@StateDisplayName, 'Total Registrants', @TotalCount, '', @TotalCount)


			
SELECT * FROM @CountTable

