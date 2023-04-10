SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_ConfirmOnlineRegistrant    Script Date: 5/14/2007 10:02:43 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_ConfirmOnlineRegistrant]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_ConfirmOnlineRegistrant]
GO





CREATE PROCEDURE spu_ConfirmOnlineRegistrant AS

/*

Desigened AND Developed 02/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 

*/
UPDATE	Registry 
SET 	DonorConfirmed = 1
-- select DATEDIFF(D,MailerDate, GETDATE()) ,* from Registry 
WHERE	DonorConfirmed = 0
AND	DATEDIFF(D,MailerDate, GETDATE()) >= 30





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

