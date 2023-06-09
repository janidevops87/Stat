SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_CODInitializeCall]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_CODInitializeCall]
GO



CREATE  PROCEDURE spi_CODInitializeCall
/*
   Initializes a call to the Coalition on Donation Spanish Information line.
   Used by COD_Call_Track.sls.
   Created 3/31/05 by Scott Plummer


   ccarroll 07/21/2006 - Changed source code to DLASPAN - was CODSPAN  

*/
AS

SET NOCOUNT ON

DECLARE @codspanEmployeeId integer,
	@codspanSourceCodeId integer
-- Get the StatEmployeeId for the employee designated as 'DLASPAN'
SET @codspanEmployeeId = (SELECT TOP 1 StatEmployeeID FROM StatEmployee WHERE StatEmployeeUserID = 'DLASPAN');
-- Get the SourceCode for the DLASPAN Information line
SET @codspanSourceCodeId = (SELECT TOP 1 SourceCodeID FROM SourceCode WHERE SourceCodeName = 'DLASPAN' AND SourceCodeType = 5);



INSERT INTO Call 
	(CallNumber, CallTypeID, CallDateTime, StatEmployeeID, CallTotalTime, CallSeconds, 
	CallTemp, SourceCodeID, CallOpenByID, CallTempExclusive, CallTempSavedByID, CallExtension) 
VALUES (NULL,5,GetDate(),@codspanEmployeeId,'00:00:00',0,
	0,@codspanSourceCodeId,-1,0,-1,0);

SELECT SCOPE_IDENTITY() AS CallId;


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

