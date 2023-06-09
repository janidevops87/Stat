SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryMedicationOther]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryMedicationOther]
GO


CREATE PROCEDURE sps_SecondaryMedicationOther
	@CallId int,
	@MedicationType varchar(100)

AS
/******************************************************************************
**		File: sps_SecondaryMedicationOther.sql
**		Name: sps_SecondaryMedicationOther
**		Desc: Generate list of SecondaryMedicationOther
**
**              
**		Return values: returns list of SecondaryMedicationOthter
** 
**		Called by:   Statline.StatTrac.ctlItemList.getSelected`
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		@CallID 	[int],
**		@StatEmployeeID int,
**		@SourceCodeID int,
**		@CallExtension int
**		@CallTypeID int,
**		@CallDateTime datetime,
**		@CallTotalTime varchar(50),
**		@CallSeconds   varchar(50),
**		@CallTemp int,
**		@CallOpenByID int,
**		@CallTempExclusive int,
**		@CallTempSavedByID int,
**		@RecycleNCFlag int,
**		@CallActive int,
**		@CallSaveLastByID int,
**
**		Auth: Thien Ta
**		Date: 4/13/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		4/13/07			Thien Ta				initial    
**		04/05/07		Bret Knoll				8.4.3.8 Audit Call table 
**												add AuditLogTypeID
**												added LastModied Update
*******************************************************************************/
SELECT 
	sm.MedicationId, 
--sm.SecondaryMedicationTypeUse, 
	CASE 
		sm.MedicationId 
		WHEN 
			-1 
		THEN 
			sm.SecondaryMedicationOtherName 
		ELSE 
			m.MedicationName 
	END as SecondaryMedicationOtherName, 
	sm.SecondaryMedicationOtherDose, 
	sm.SecondaryMedicationOtherStartDate, 
	sm.SecondaryMedicationOtherEndDate,
	sm.SecondaryMedicationOtherID

FROM SecondaryMedicationOther sm
LEFT JOIN Medication m ON sm.MedicationId = m.MedicationId
WHERE sm.CallId = @CallId
AND sm.SecondaryMedicationOtherTypeUse = @MedicationType
ORDER BY SecondaryMedicationOtherName






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

