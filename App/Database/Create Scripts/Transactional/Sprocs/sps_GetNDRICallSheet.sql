SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetNDRICallSheet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetNDRICallSheet]
GO


CREATE PROCEDURE sps_GetNDRICallSheet
	@CallId as int

AS

SELECT ncs.*, r.RaceName, a.ABORefName, s.SourceCodeName,
	CASE ncs.Sepsis
		WHEN 1 THEN 'Yes'
		WHEN 2 THEN 'No'
		ELSE 'Unk'
	END,
	CASE ncs.Chemotherapy
		WHEN 1 THEN 'Yes'
		WHEN 2 THEN 'No'
		ELSE 'Unk'
	END,
	CASE ncs.Radiation
		WHEN 1 THEN 'Yes'
		WHEN 2 THEN 'No'
		ELSE 'Unk'
	END,
	CASE ncs.SubstanceAbuse
		WHEN 1 THEN 'Yes'
		WHEN 2 THEN 'No'
		ELSE 'Unk'
	END,
	CASE ncs.FamilyAtHospital
		WHEN 1 THEN 'Yes'
		WHEN 2 THEN 'No'
		ELSE 'Unk'
	END,
	CASE ncs.FamilyHIVStatus
		WHEN 1 THEN 'Yes'
		WHEN 2 THEN 'No'
		ELSE 'Unk'
	END
FROM NDRICallSheet ncs
LEFT JOIN Race r on ncs.RaceId = r.RaceId
LEFT JOIN ABORef a on ncs.ABO_RH = a.ABORefId
JOIN Call cl on ncs.CallId = cl.CallId
JOIN SourceCode s on cl.SourceCodeId = s.SourceCodeId
WHERE ncs.CallId = @CallId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

