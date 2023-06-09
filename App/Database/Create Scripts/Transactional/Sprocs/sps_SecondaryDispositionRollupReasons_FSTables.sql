SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryDispositionRollupReasons_FSTables]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryDispositionRollupReasons_FSTables]
GO



CREATE PROCEDURE sps_SecondaryDispositionRollupReasons_FSTables AS


SELECT 1 col, fsa.FSAppropriateID ID, fsa.FSAppropriateName Name
FROM FSAppropriate fsa
UNION
SELECT 2 col, a.FSApproachID ID, a.FSApproachName Name
FROM FSApproach a
WHERE Inactive <> -1
UNION
SELECT 3 col, c.FSConsentID ID, c.FSConsentName Name
FROM FSConsent c
WHERE Inactive <> -1
UNION
SELECT 4 col, r.FSConversionID ID, r.FSConversionName Name
FROM FSConversion r
WHERE Inactive <> -1








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

