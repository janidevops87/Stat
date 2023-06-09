SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CONTRACTS_CriteriaGroupsName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CONTRACTS_CriteriaGroupsName]
GO

CREATE PROCEDURE sps_CONTRACTS_CriteriaGroupsName

	@CriteriaGroupID INT
AS

	DECLARE @CriteriaGroupName VARCHAR(255) 	

	SET NOCOUNT ON

	IF @CriteriaGroupID = 0
	BEGIN
		SELECT @CriteriaGroupName = '%'
	END
	ELSE 	
	BEGIN
		SELECT @CriteriaGroupName = c.CriteriaGroupName FROM Criteria c where c.CriteriaID = @CriteriaGroupID
	END
	
	SELECT @CriteriaGroupName AS 'CriteriaGroupName'



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

