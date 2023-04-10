  if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetTransplantCenter]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetTransplantCenter]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE GetTransplantCenter
			@TransplantCenterCode varchar(50)

/******************************************************************************
**		File: 
**		Name: GetTransplantCenter
**		Desc: gets SourceCode and message organizationID
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Called By:
**
**		Auth: Thien Ta
**		Date: 4/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		4/10/2007		Thien Ta				initial	  
**		4/13/2007		Bret Knoll				changed table name from TxCenter to TransplantCenter
**		06/02/2011		ccarroll				Added MessageOrganizationID CASE for StatTrac compatibility
****************************************************************************/



 AS

Declare 
	@SourceCodeID as int
	Set @SourceCodeID = 0

	Select 
		@SourceCodeID= SourceCodeID 
	from 
		SourceCodeTransplantCenter 
	where 
		TransplantCode = @TransplantCenterCode

	if @SourceCodeID = 0
		Begin
			Select  
				SourceCodeID,
				OrganizationID,
				TransplantCode 
			from 
				SourceCodeTransplantCenter 
			where 
				TransplantCode = 'IMPORT'
		end

	if @SourceCodeID > 0 
		Begin
			Select 
				SourceCodeID,
				CASE 
					WHEN MessageOrganizationID IS NULL  
					THEN OrganizationID
					ELSE MessageOrganizationID 
				END AS OrganizationID,
				TransplantCode 
			from 
				SourceCodeTransplantCenter 
			where 
				TransplantCode = @TransplantCenterCode
		end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

