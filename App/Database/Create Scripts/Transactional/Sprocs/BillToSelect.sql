 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[BillToSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[BillToSelect]
	PRINT 'Dropping Procedure: BillToSelect'
END
	PRINT 'Creating Procedure: BillToSelect'
GO

CREATE PROCEDURE [dbo].[BillToSelect]
(	
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: BillToSelect.sql
**		Name: BillToSelect
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 7/6/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/6/2009	bret	initial
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT     
		BillTo.BillToID, 
		BillTo.OrganizationID, 
		BillTo.Name, 
		BillTo.Address1, 
		BillTo.Address2, 
		BillTo.City, 
		BillTo.StateID,
		State.StateAbbrv AS State, 
		BillTo.PostalCode, 
		BillTo.CountryID, 
		Country.COUNTRYNAME AS CountryName, 
		BillTo.LastModified, 
		BillTo.LastStatEmployeeId, 
		BillTo.AuditLogTypeId
	FROM         
		BillTo 
	LEFT JOIN
		State ON BillTo.StateID = State.StateID 
	LEFT JOIN
		Country ON BillTo.CountryID = Country.COUNTRYID
	WHERE 
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID)


	RETURN @@Error
GO