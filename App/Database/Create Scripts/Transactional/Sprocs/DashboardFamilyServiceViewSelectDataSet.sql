IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardFamilyServiceViewSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure   DashboardFamilyServiceViewSelectDataSet';
		DROP Procedure   DashboardFamilyServiceViewSelectDataSet;
	END
GO

PRINT 'Creating Procedure   DashboardFamilyServiceViewSelectDataSet';
GO
CREATE Procedure   DashboardFamilyServiceViewSelectDataSet
(
		@DataSetLeaseOrg int = null output,
		@DataSetTimeZone varchar(2) = null,
		@DataSetStatEmployee int = null				
)

AS

/******************************************************************************
**	File:   DashboardFamilyServiceViewSelectDataSet.sql
**	Name:   DashboardFamilyServiceViewSelectDataSet
**	Desc:	Selects Data Set Stattrac dashboard Family Service view  
**	Auth: ccarroll
**	Date: 09/30/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	09/30/2010		ccarroll			Initial Sproc Creation
**  10/15/2018		mberenson			Added Parameter: @DataSetStatEmployee
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	EXEC dbo.DashboardPendingSecondaryActivitySelect @LeaseOrg=@DataSetLeaseOrg,@timeZone=@DataSetTimeZone,@StatEmployee=@DataSetStatEmployee;
	EXEC dbo.DashboardPendingSecondaryAlertSelect @LeaseOrg=@DataSetLeaseOrg,@timeZone=@DataSetTimeZone,@StatEmployee=@DataSetStatEmployee;
	EXEC dbo.DashboardPendingSecondaryWIPSelect @LeaseOrg=@DataSetLeaseOrg,@timeZone=@DataSetTimeZone,@StatEmployee=@DataSetStatEmployee;

GO

GRANT EXEC ON   DashboardFamilyServiceViewSelectDataSet TO PUBLIC;
GO
