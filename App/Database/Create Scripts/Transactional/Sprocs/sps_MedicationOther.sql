SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_MedicationOther]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_MedicationOther]
GO


CREATE PROCEDURE sps_MedicationOther
	@MedicationType varchar(100)

AS

SELECT MedicationId, 
--MedicationTypeUse, 
MedicationName
FROM Medication
WHERE MedicationTypeUse = @MedicationType
ORDER BY MedicationName



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

