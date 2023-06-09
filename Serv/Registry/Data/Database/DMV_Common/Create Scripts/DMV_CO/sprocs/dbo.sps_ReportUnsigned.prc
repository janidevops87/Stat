SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_ReportUnsigned    Script Date: 5/14/2007 10:02:42 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportUnsigned]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)

drop procedure [dbo].[sps_ReportUnsigned]
GO


CREATE        PROCEDURE sps_ReportUnsigned
		@StartDate	datetime = Null,
		@EndDate	datetime = Null

AS
/******************************************************************************
**		File: sps_EventCategory.sql
**		Name: sps_EventCategory
**		Desc: This sp is used to return a list of registrants who
**		signed up on-line and do not have a donor card filled out 
**		(donorConfirmed=0).
**
**		Input paramaters
**		@StartDate,
**		@EndDate
**
**		Use Example: sp_ReportUnsigned '01/01/2006', '01/31/2006 23:59'
**		Notes:
**		When SQL server receives a string as input for a datetime,
**		it automatically converts hh:mm to 00:00 (Midnight). That
**		is why it is necessary to append the time of '23:59' to the
**		@EndDate string.
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: ccarroll						12/04/2007
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**     04/25/2006		ccarroll				Initial
*******************************************************************************/
If @StartDate <> '' AND @EndDate <> ''
BEGIN

SELECT  convert(varchar,r.CreateDate,109) AS 'DateEntered',
	r.FirstName,
	r.MiddleName,
	r.LastName,
	convert(varchar,r.DOB,101) AS DOB,
	r.License,
	a.Addr1 AS Address,
	a.City,
	a.State,
	a.Zip

FROM Registry AS r
JOIN REGISTRYADDR AS a ON r.ID = a.RegistryID
WHERE r.CreateDate Between @StartDate AND @EndDate
	AND a.AddrTypeID = 1
	AND IsNull(r.DonorConfirmed, 0) <> 1
ORDER BY r.CreateDate DESC

END







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

