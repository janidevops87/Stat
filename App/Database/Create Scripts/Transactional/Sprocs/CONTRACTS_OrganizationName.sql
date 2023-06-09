SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_OrganizationName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_OrganizationName]
GO


CREATE PROCEDURE CONTRACTS_OrganizationName @OrganizationID VARCHAR(2000) AS
IF @OrganizationID = '*' 
  SELECT 'All Clients' OrganizationName
ELSE
  SELECT OrganizationName
  FROM Organization
  WHERE OrganizationID = @OrganizationID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

