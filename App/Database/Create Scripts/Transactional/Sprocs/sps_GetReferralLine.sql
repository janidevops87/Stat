SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetReferralLine]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetReferralLine]
GO





CREATE PROCEDURE sps_GetReferralLine
	@vUserOrgID	int		= null

AS

	select top 1 Sourcecode.SourceCodeName,Sourcecode.SourceCodeID from sourcecodeorganization JOIN SourceCode 
ON SourceCode.SourceCodeID = SourceCodeORganization.SourceCodeID where organizationID = @vUserOrgID


--select DefaultSourceCodeID as SourceCodeID,SourceCode.SourcecodeName from onlinehospitalaccount Join SourceCode ON Sourcecode.SourcecodeID = onlinehospitalaccount.DefaultSourceCodeID
--where webpersonID =@vUserID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

