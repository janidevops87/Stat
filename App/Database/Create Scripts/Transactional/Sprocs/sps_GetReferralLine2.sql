SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetReferralLine2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetReferralLine2]
GO




CREATE PROCEDURE sps_GetReferralLine2
	@vUserOrgID	int		= null

AS

	--select top 1 Sourcecode.SourceCodeName,Sourcecode.SourceCodeID from sourcecodeorganization JOIN SourceCode 
--ON SourceCode.SourceCodeID = SourceCodeORganization.SourceCodeID where organizationID = @vUserOrgID


select SourceCode.SourcecodeName,DefaultSourceCodeID as SourceCodeID  from onlinehospitalaccount Join SourceCode ON Sourcecode.SourcecodeID = onlinehospitalaccount.DefaultSourceCodeID
where webpersonID =@vUserOrgID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

