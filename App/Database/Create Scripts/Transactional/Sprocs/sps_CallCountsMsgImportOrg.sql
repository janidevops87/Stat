SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CallCountsMsgImportOrg]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CallCountsMsgImportOrg]
GO






/****** Object:  Stored Procedure dbo.sps_CallCountsMsgImportOrg    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE sps_CallCountsMsgImportOrg
	@vOrgID		int		= null,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null
AS
/********************************************************************************/
/*	Total Messages 								*/
/********************************************************************************/
	SELECT 	OrganizationID, Count(MessageID) AS  TotalMessages
	INTO	#TotalMessages
	FROM 	Message
	JOIN	Call ON Call.CallID = Message.CallID 
	WHERE 	MessageTypeID <> 2 
	AND	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate	
	AND	OrganizationID = @vOrgID
	GROUP BY OrganizationID
/********************************************************************************/
/*	Total Imports 								*/
/********************************************************************************/
	SELECT 	OrganizationID, Count(MessageID) AS  TotalImports
	INTO	#TotalImports
	FROM 	Message
	JOIN	Call ON Call.CallID = Message.CallID
	WHERE 	MessageTypeID = 2 
	AND	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate	
	AND	OrganizationID = @vOrgID
	
	GROUP BY OrganizationID
/********************************************************************************/
/*	Final Total Counts							*/
/********************************************************************************/
	SELECT		Organization.OrganizationID, OrganizationName, TotalMessages, TotalImports
	FROM		Organization
	LEFT JOIN	#TotalMessages ON #TotalMessages.OrganizationID = Organization.OrganizationID
	LEFT JOIN	#TotalImports ON #TotalImports.OrganizationID = Organization.OrganizationID
	WHERE		OrganizationTypeID = 1
	AND		Organization.OrganizationID = @vOrgID




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

