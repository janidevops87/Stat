 USE DMV_VT
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ActionableDesignationVolumeCountsEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_ActionableDesignationVolumeCountsEvent'
	drop procedure [dbo].[sps_ActionableDesignationVolumeCountsEvent]
END
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
PRINT 'Creating Procedure: sps_ActionableDesignationVolumeCountsEvent'
GO

CREATE PROCEDURE sps_ActionableDesignationVolumeCountsEvent
	@StartDateTime	SMALLDATETIME = NULL,
	@EndDateTime	SMALLDATETIME = NULL,
	@EventCategoryID int = NULL,
	@EventSubCategoryID int = NULL,
	@SourceCode varchar(255) = NULL
AS
/******************************************************************************
**		File: sps_ActionableDesignationVolumeCountsEvent.sql
**		Name: sps_ActionableDesignationVolumeCountsEvent
**		Desc: 
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
**		Date: 02/29/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      02/29/2008		ccarroll				initial
**		04/24/2008		ccarroll				added SET TRANSACTION ISOLATION LEVEL 
**		01/02/2009		ccarroll				added to WHERE: remove category and sub category 0 values  
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT
		@StartDateTime = ISNULL(
								@StartDateTime, 
								CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@EndDateTime = ISNULL	(
								@EndDateTime, 
								CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
								)


/* SET Category ID's to NULL if All option is selected.
 */
IF @EventCategoryID = 0 
BEGIN
	SET @EventCategoryID = NULL
END

IF @EventSubCategoryID = 0 
BEGIN
	SET @EventSubCategoryID = NULL
END




DECLARE @SelectionTable TABLE
	(
		SourceID				int			Null,
		SourceType				varchar(10)	Null,
		Event					varchar(255)Null,
		EventSub				varchar(255)Null,
		SourceCode				varchar(255)Null,
		DonorDesinationStatus	varchar(25)	Null,
		AgeRange				varchar(5)	Null,
		Gender					varchar(1)	Null,
		DonorTotalYes			int Null,
		DonorTotalNo			int Null
	)

	/* Add main donor detail */
	INSERT @SelectionTable 

		SELECT DISTINCT
			 Registry.RegistryID AS 'SourceID',
			'Reg' 	AS 'SourceType',
			EventCategory.EventCategoryName	AS 'Event',
			EventSubCategory.EventSubCategoryName	AS 'EventSub',
			'' AS 'SourceCode',

			/* Correlate donor histoy*/
			CASE 	WHEN PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1) -- New Yes
						THEN 'New Yes'
					WHEN PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1) -- Yes To Yes
						THEN 'Yes To Yes'
					WHEN PreviousDonor = 1 AND (Donor = 0 AND DonorConfirmed = 1) -- Yes To No
						THEN 'Yes To No'
					WHEN PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1) -- No To Yes
						THEN 'No To Yes'
					WHEN PreviousDonor = 0 AND (Donor = 0 AND DonorConfirmed = 1) -- No To No
						THEN 'No To No'
					WHEN PreviousDonorConfirmed Is Null AND (Donor = 0 AND DonorConfirmed = 1) -- New No
						THEN 'New No'
						
						
					ELSE 'Unknown'
			  END AS 'DonorDesignationStatus',

			/* Correlate Donor AgeRange */
			CASE 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) <= 17
				THEN '0-17'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 18 AND 21
				THEN '18-21'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 22 AND 29
				THEN '22-29'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 30 AND 39
				THEN '30-39'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 40 AND 49
				THEN '40-49'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 50 AND 59
				THEN '50-59'
		
			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 60 AND 69
				THEN '60-69'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) >= 70
				THEN '70+'

			  END AS 'AgeRange',

			/* Gender default*/  
			CASE	WHEN Gender = 'M'
				THEN 'M'
				WHEN Gender = 'F'
				THEN 'F'
				ELSE 'U' --Unknown
			END AS 'Gender',
			
			IsNull(Donor, 0)AS 'DonorTotalYes',
			
			CASE WHEN IsNull(Donor, 0) = 0
				THEN 1
				ELSE 0
			END AS 'DonorTotalNo'
			
		FROM DMV_Common..Registry AS Registry
		LEFT JOIN DMV_Common..RegistryADDR AS RegistryADDR ON RegistryADDR.RegistryID = Registry.RegistryID AND (RegistryADDR.AddrTypeID = 1)
		LEFT JOIN DMV_Common..EventRegistry AS EventRegistry ON Registry.RegistryID = EventRegistry.RegistryID
		LEFT JOIN DMV_Common..EventCategory AS EventCategory ON EventRegistry.EventCategoryID = EventCategory.EventCategoryID
		LEFT JOIN DMV_Common..EventSubCategory AS EventSubCategory ON EventRegistry.EventSubCategoryID = EventSubCategory.EventSubCategoryID
		WHERE Registry.LastModified BETWEEN @StartDateTime AND @EndDateTime
			AND  RegistryAddr.State = 'VT'
			AND  DonorConfirmed = 1

			AND isNull(EventRegistry.EventCategoryID, 0) = IsNull(@EventCategoryID, IsNull(EventRegistry.EventCategoryID, 0))
			AND isNull(EventRegistry.EventSubCategoryID, 0) = IsNull(@EventSubCategoryID, IsNull(EventRegistry.EventSubCategoryID, 0))
			AND isNull(EventSubCategory.EventSubCategorySourceCode, 0) = IsNull(@SourceCode, IsNull(EventSubCategory.EventSubCategorySourceCode, 0))
			


	/* Add Total detail */
	INSERT @SelectionTable 

		SELECT DISTINCT
			 Registry.RegistryID AS 'SourceID',
			'Reg' 	AS 'SourceType',
			EventCategory.EventCategoryName	AS 'Event',
			EventSubCategory.EventSubCategoryName	AS 'EventSub',
			'' AS 'SourceCode',

			/* Correlate Total Yes*/
			CASE 	WHEN (PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1)) -- New Yes
						OR	(PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1)) -- Yes To Yes
						OR  (PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1)) -- No To Yes
						THEN 'Total Yes'
						
			  END AS 'DonorDesignationStatus',

			/* Correlate Donor AgeRange */
			CASE 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) <= 17
				THEN '0-17'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 18 AND 21
				THEN '18-21'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 22 AND 29
				THEN '22-29'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 30 AND 39
				THEN '30-39'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 40 AND 49
				THEN '40-49'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 50 AND 59
				THEN '50-59'
		
			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 60 AND 69
				THEN '60-69'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) >= 70
				THEN '70+'

			  END AS 'AgeRange',

			/* Gender default*/  
			CASE	WHEN Gender = 'M'
				THEN 'M'
				WHEN Gender = 'F'
				THEN 'F'
				ELSE 'U' --Unknown
			END AS 'Gender',
			
			Null AS 'DonorTotalYes',	/* Used for total counts. DonorTotalYes and DonorTotalNo are counted*/
			Null AS 'DonorTotalNo'		/* in above selection */
			
		FROM DMV_Common..Registry AS Registry
		LEFT JOIN DMV_Common..RegistryADDR AS RegistryADDR ON RegistryADDR.RegistryID = Registry.RegistryID AND (RegistryADDR.AddrTypeID = 1)
		LEFT JOIN DMV_Common..EventRegistry AS EventRegistry ON Registry.RegistryID = EventRegistry.RegistryID
		LEFT JOIN DMV_Common..EventCategory AS EventCategory ON EventRegistry.EventCategoryID = EventCategory.EventCategoryID
		LEFT JOIN DMV_Common..EventSubCategory AS EventSubCategory ON EventRegistry.EventSubCategoryID = EventSubCategory.EventSubCategoryID
		WHERE Registry.LastModified BETWEEN @StartDateTime AND @EndDateTime
			AND  RegistryAddr.State = 'VT'
			AND  (Registry.Donor = 1  AND Registry.DonorConfirmed = 1)
			  
			AND isNull(EventRegistry.EventCategoryID, 0) = IsNull(@EventCategoryID, IsNull(EventRegistry.EventCategoryID, 0))
			AND isNull(EventRegistry.EventSubCategoryID, 0) = IsNull(@EventSubCategoryID, IsNull(EventRegistry.EventSubCategoryID, 0))
			AND isNull(EventSubCategory.EventSubCategorySourceCode, 0) = IsNull(@SourceCode, IsNull(EventSubCategory.EventSubCategorySourceCode, 0))



SELECT * FROM @SelectionTable
	/* ccarroll 01/02/2009 - exclude the following: */
	WHERE DonorDesinationStatus <> 'No To No'
	AND DonorDesinationStatus <> 'New No'
	AND DonorDesinationStatus <> 'Unknown'

ORDER BY Event, EventSub,DonorDesinationStatus

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO