SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spf_IMPORT_ALL_CheckRecordCounts    Script Date: 5/14/2007 10:02:39 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_IMPORT_ALL_CheckRecordCounts]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_IMPORT_ALL_CheckRecordCounts]
GO





CREATE PROCEDURE spf_IMPORT_ALL_CheckRecordCounts AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
-- check the record counts -- compare file counts to what was imported
 SET NOCOUNT ON
 DECLARE @ErrorMessage VARCHAR(250)
 UPDATE IMPORT_D 
 SET TableCount = (SELECT COUNT(*) FROM IMPORT_A)
 WHERE ImportFile = 'a'
 UPDATE IMPORT_D 
 SET TableCount = (SELECT COUNT(*) FROM IMPORT_B)
 WHERE ImportFile = 'b'
 UPDATE IMPORT_D 
 SET TableCount = (SELECT COUNT(*) FROM IMPORT_C)
 WHERE  ImportFile = 'c'
 SELECT @ErrorMessage = COUNT(*) FROM IMPORT_D WHERE (ImportFileSize -  TableCount) <> 0
 IF (@ErrorMessage > 0)
 BEGIN
  SET @ErrorMessage = @ErrorMessage + ' table counts and the values in donor-d.txt file are not equal.'
  RAISERROR (@ErrorMessage,11,1)with LOG
  RETURN 1
 END
 
 RETURN 0
-- end check the record counts -- compare file counts to what was imported





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

