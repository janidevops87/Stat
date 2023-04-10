IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_Common_ActionableDesignationVolumeCountsEvent')
	BEGIN
		PRINT 'Dropping Procedure sps_Common_ActionableDesignationVolumeCountsEvent'
		DROP  Procedure  sps_Common_ActionableDesignationVolumeCountsEvent
	END

GO

PRINT 'Creating Procedure sps_Common_ActionableDesignationVolumeCountsEvent'
GO
CREATE Procedure sps_Common_ActionableDesignationVolumeCountsEvent
	@State			varchar(25) = NULL,
	@StartDateTime	SmallDateTime = NULL,
	@EndDateTime	SmallDateTime = NULL,
	@EventCategoryID int = NULL,
	@EventSubCategoryID int = NULL,
	@SourceCode varchar(255) = NULL
AS

DECLARE @StateDSN varchar(25)
DECLARE @SQLString varchar(500)

IF @SourceCode Is Null 
BEGIN
SET @SourceCode = 'Null'
END 

/******************************************************************************
**		File: sps_Common_ActionableDesignationVolumeCountsEvent.sql
**		Name: sps_Common_ActionableDesignationVolumeCountsEvent
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll	
**		Date: 03/28/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		03/28/2008		ccarroll				initial release
*******************************************************************************/

/* Get StateDSN */
SET @StateDSN = (SELECT DSN FROM StateDSNLookup WHERE State = @State)

SET @SQLString = 'sps_ActionableDesignationVolumeCountsEvent ''' +  
						 CONVERT(varchar,@StartDateTime, 101) + ''', ''' +
						 CONVERT(varchar,@EndDateTime, 101) + ''', ' +
						 CAST(@EventCategoryID AS varchar) + ', ' +
						 CAST(@EventSubCategoryID AS varchar) + ', ' +
						 CASE @SourceCode WHEN 'Null' THEN 'Null' ELSE Char(39) + @SourceCode + Char(39) END + ';'


--SET @SQLString = N'' + @StateDSN + '..sps_ActionableDesignationVolumeCountsEvent'
--PRINT @SQLString
--EXECUTE sp_executesql @SQLString, N'@StartDateTime SmallDateTime, @EndDateTime SmallDateTime, @EventCategoryID int, @EventSubCategoryID int, @SourceCode varchar(255)', 
--								 @StartDateTime, @EndDateTime, @EventCategoryID, @EventSubCategoryID, @SourceCode

-- PRINT @SQLString
EXEC (@StateDSN + '..' + @SQLString)


GO
