SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryDispositionRollupReasons]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryDispositionRollupReasons]
GO


CREATE PROCEDURE sps_SecondaryDispositionRollupReasons AS


SELECT 1 col, fsa.FSAppropriateID ID, fsa.FSAppropriateName Name
FROM FSAppropriate fsa
UNION
SELECT 2 col, a.ApproachID ID, a.ApproachName Name
FROM Approach a
UNION
SELECT 3 col, c.ConsentID ID, c.ConsentName Name
FROM Consent c
UNION
SELECT 4 col, r.ConversionID ID, r.ConversionName Name
FROM Conversion r



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

