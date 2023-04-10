SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_Organizations]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_Organizations]
GO






/****** Object:  Stored Procedure dbo.sps_Organizations    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_Organizations AS

SELECT		OrganizationID, OrganizationName
FROM		Organization
WHERE		OrganizationTypeID = 1
ORDER BY	OrganizationName




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

