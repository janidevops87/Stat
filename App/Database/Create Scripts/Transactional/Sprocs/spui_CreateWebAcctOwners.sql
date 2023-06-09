SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_CreateWebAcctOwners]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_CreateWebAcctOwners]
GO


CREATE PROCEDURE spui_CreateWebAcctOwners
			@WebPersonID as int,
			@GroupOwnerID as int,
			@ReportGroupID as int,
			@HospitalID as int,
			@DefaultSourceCodeID as int,
			@vPersonId as int

 AS

Delete from OnlineHospitalaccount where WebPersonID = @WebPersonID

 
INSERT INTO OnLineHospitalaccount  (WebPersonID,GroupOwnerID,ReportGroupID,HospitalID,DefaultSourceCodeID,PersonId)
VALUES (@webPersonID,@GroupOwnerID,@ReportGroupID,@HospitalID,@DefaultSourceCodeID,@vPersonId);
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

