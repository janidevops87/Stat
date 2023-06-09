SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_TrashBin_County]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_TrashBin_County]
GO



--spf_TrashBin_County 332, 1


CREATE PROCEDURE  spf_TrashBin_County
	
	@vCountyID 	int	= null,	--County ID parameter
	@vUserID	int	= null	--User ID parameter

 AS
/*
	Line below used to set database to allow bulkcopy
	sp_dboption '_TrashBin', 'select into/bulkcopy', 'TRUE'

	select * from call where CallID = @vCallID
	select * from referral where callid = @vCallID
	select * from logevent where callid = @vCallID
	select * from message where callid = @vCallID

	delete call where callid = @vCallID
	delete referral where callid = @vCallID
	delete logevent where callid = @vCallID
	delete message where callid = @vCallID
*/
	select * from _ReferralProd.dbo.County where CountyID = @vCountyID
	Insert into _TrashBin.dbo.County
		(CountyID, CountyName, StateID, Verified, Inactive, LastModified, UpdatedFlag, ArchiveDate, UserID)
		select 
			CountyID, CountyName, StateID, Verified, Inactive, LastModified, UpdatedFlag, getdate(), @vUserID
		from _ReferralProd.dbo.County where CountyID = @vCountyID

	select * from _TrashBin.dbo.County where CountyID = @vCountyID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

