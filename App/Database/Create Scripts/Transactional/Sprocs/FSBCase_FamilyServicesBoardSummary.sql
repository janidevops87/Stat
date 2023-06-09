SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_FamilyServicesBoardSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_FamilyServicesBoardSummary]
GO


Create Procedure [dbo].[FSBCase_FamilyServicesBoardSummary]
As
Begin

Declare @WhatThresholds Int
Set @WhatThresholds = 0 -- use 0 to only display cases with a threshold greater than 0
			-- use -1 to show all

Declare @FSBCaseTypeId Int
Set @FSBCaseTypeId = dbo.FSBCaseTypeId( 'Family Services' )

Declare @FSBFamilyServicesClosedStatusId Int
Set @FSBFamilyServicesClosedStatusId = dbo.FSBStatusId( 'Closed', @FSBCaseTypeId )

-- create a variable table to collect the data
Declare @CountTable Table
	(
		FSBStatusName  nvarchar(50),
		RecordCount	int,
		TheColor       nvarchar(50),
		CreateDate     datetime,
		ThresholdMinutes smallint
	)
Insert @CountTable (FSBStatusName, RecordCount, TheColor,CreateDate, ThresholdMinutes )
( Select
	IsNull( Stat.FSBStatusName, '' ) As FSBStatusName,
	Count(*) As RecordCount,
	Stat.Color,
	min(SL.DateInserted) As CreateDate,	
	Stat.ThresholdMinutes	
From
	FSBCase C With ( NoLock )
	Left Outer Join FSBCaseStatusLog SL With ( NoLock ) On 
	( SL.FSBCaseId = C.FSBCaseId And SL.StatusChangedDateTime = 
	( Select Max( StatusChangedDateTime) From FSBCaseStatusLog With ( NoLock ) Where FSBCaseId = C.FSBCaseId ) )
	Left Outer Join FSBStatus Stat With ( NoLock ) On ( Stat.FSBStatusId = SL.FSBStatusId)
		
Where
	( C.FSBCaseTypeId = @FSBCaseTypeId And Stat.FSBStatusId <> @FSBFamilyServicesClosedStatusId )
And
	( Stat.ThresholdMinutes > @WhatThresholds)
GROUP BY 
	IsNull( Stat.FSBStatusName, '' ), Stat.ThresholdMinutes	 , Stat.Color
)

Select FSBStatusName As FSBStatusName, RecordCount ,
	Case 
		When DateDiff( n, CreateDate, GetDate() ) - ThresholdMinutes >= 0 Then TheColor
		Else 'Black'
	End As TheColor,
	--Convert(integer,DateDiff( n, CreateDate, GetDate() ))- ThresholdMinutes As MinutesOver 
	Convert(integer,DateDiff( n, CreateDate, GetDate() )) As MinutesOver 
From @CountTable
Order By ThresholdMinutes desc, FSBStatusName
End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

