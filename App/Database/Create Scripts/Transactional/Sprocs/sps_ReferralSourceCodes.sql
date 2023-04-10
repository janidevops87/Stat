SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralSourceCodes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralSourceCodes]
GO

CREATE PROCEDURE sps_ReferralSourceCodes

AS

SELECT
	sc.SourceCodeName,
	sc.SourceCodeID
FROM
	dbo.SourceCode sc
	INNER JOIN CallType scType ON sc.SourceCodeType = scType.CallTypeID AND scType.CallTypeName = 'Referral'
ORDER BY
	SourceCodeName;

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO