SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ListApproachType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ListApproachType]
GO






/****** Object:  Stored Procedure dbo.sps_ListApproachType    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_ListApproachType


AS


	SELECT	ApproachTypeID, ApproachTypeName
	FROM	ApproachType




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

