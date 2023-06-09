SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_SetOnlineMailerDate    Script Date: 5/14/2007 10:02:45 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SetOnlineMailerDate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_SetOnlineMailerDate]
GO





CREATE PROCEDURE spu_SetOnlineMailerDate
	@Donor 		CHAR(1)		=NULL,
	@StartDate 	SMALLDATETIME 	=NULL,
	@EndDate	SMALLDATETIME 	=NULL
AS
/*

Desigened AND Developed 02/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 

Paramameters
	Donor 		- Flag indicating a Donors wishes 0 is Not Yes, 1 is Yes and NULL is either
	StartDate	- Start of OnlineRegDate to query
	EndDate		- End of OnlineRegDate to query
*/

UPDATE 	Registry
SET	MailerDate = GETDATE()
-- SELECT * FROM Registry
WHERE	(Donor		= @Donor	OR ISNULL(@Donor,	'')='')
AND 	DonorConfirmed = 0
AND 	(OnlineRegDate  >= @StartDate	OR ISNULL(@StartDate,	'')='')
AND 	(OnlineRegDate  <= @EndDate	OR ISNULL(@EndDate,	'')='')







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

