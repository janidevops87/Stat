SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_DMVwildcard    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DMVwildcard]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DMVwildcard]
GO





CREATE PROCEDURE sps_DMVwildcard @LastName   varchar(255),
                                 @FirstName  varchar(255),
                                 @MiddleName varchar(255),
                                 @License    varchar(255),
                                 @Day        varchar(255),
                                 @Month      varchar(255),
                                 @Year       varchar(255)  AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	©1996-2003 Statline, LLC. All rights reserved. 

	Statline is a registered trademark of Statline, LLC in the U.S.A. 


	7555 East Hampden Avenue, Ste. 104, 
	Denver, CO 80231. 
	1-888-881-7828. 
*/
IF substring(@Day,1,1)=0   select @Day=substring(@Day,2,255)
IF substring(@Month,1,1)=0 select @Month=substring(@Month,2,255)
select * 
from DMV
where	(License            like @License    or isnull(@License,    '')='')
and	(datepart(mm,DOB)   like @Month      or isnull(@Month,      '')='')
and	(datepart(dd,DOB)   like @Day        or isnull(@Day,        '')='')
and	(datepart(yyyy,DOB) like @Year       or isnull(@Year,       '')='')
and	(FirstName          like @FirstName  or isnull(@FirstName,  '')='')
and	(MiddleName         like @MiddleName or isnull(@MiddleName, '')='')
and	(LastName           like @LastName   or isnull(@LastName,   '')='')






GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

