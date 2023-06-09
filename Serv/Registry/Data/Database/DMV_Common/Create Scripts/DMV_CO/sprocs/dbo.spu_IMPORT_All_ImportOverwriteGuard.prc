SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportOverwriteGuard    Script Date: 5/14/2007 10:02:43 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_All_ImportOverwriteGuard]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_All_ImportOverwriteGuard]
GO





CREATE PROCEDURE spu_IMPORT_All_ImportOverwriteGuard AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
update IMPORT
set LAST  = case isnull(ii.LAST,'')
               when '' then d.LastName
               else ii.LAST
             end,
    FIRST  = case isnull(ii.FIRST,'')
               when '' then d.FirstName
               else ii.FIRST
             end,    
    MIDDLE = case isnull(ii.MIDDLE,'')
		when '' then d.MiddleName
		else ii.MIDDLE
	     end,
    SUFFIX = case isnull(ii.SUFFIX,'')
               when '' then d.Suffix
               else ii.SUFFIX
             end,
    GENDER = case isnull(ii.GENDER,'')
               when '' then d.Gender
               else ii.GENDER
             end,
    DOB    = case isnull(ii.DOB,'')
               when '' then CONVERT(datetime,d.DOB,112)
               else ii.DOB
             end,
    RENEWALDATE = case isnull(ii.RENEWALDATE,'')
		 	when '' then D.RenewalDate
			else ii.RENEWALDATE
		  end,
   CREATEDATE = case isnull(ii.CREATEDATE,'')
			when '' then D.CreateDate
			else ii.CREATEDATE
		end
    
from IMPORT ii, DMV d
where ii.LICENSE = d.License
update IMPORT
set AADDR1 = case isnull(ii.AADDR1,'')
               when '' then a.Addr1
               else ii.AADDR1
             end,
    ACITY  = case isnull(ii.ACITY,'')
               when '' then a.City
               else ii.ACITY
             end,
    ASTATE = case isnull(ii.ASTATE,'')
               when '' then a.State
               else ii.ASTATE
             end,
    AZIP   = case isnull(ii.AZIP,'')
               when '' then a.Zip
               else ii.AZIP
             end
from IMPORT ii, DMV d, DMVADDR a
where ii.LICENSE   = d.License
and   d.ID         = a.DMVID
and   a.ADDRTYPEID = 1
update IMPORT
set BADDR1 = case isnull(ii.BADDR1,'')
               when '' then a.Addr1
               else ii.BADDR1
             end,
    BCITY  = case isnull(ii.BCITY,'')
               when '' then a.City
               else ii.BCITY
             end,
    BSTATE = case isnull(ii.BSTATE,'')
               when '' then a.State
               else ii.BSTATE
             end,
    BZIP   = case isnull(ii.BZIP,'')
               when '' then a.Zip
               else ii.BZIP
             end
from IMPORT ii, DMV d, DMVADDR a
where ii.LICENSE   = d.License
and   d.ID         = a.DMVID
and   a.ADDRTYPEID = 2
update IMPORT
set DONOR = case isnull(ii.DONOR,'')
              when '' then ot.Code
              else ii.DONOR
            end
from IMPORT ii, DMV d, DMVORGAN o, ORGANTYPE ot
where ii.LICENSE    = d.License
and   d.ID          = o.DMVID
and   o.ORGANTYPEID = ot.ID
and   o.ORGANTYPEID = 1







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

