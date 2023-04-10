
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_ParameterEventLookup')
	BEGIN
		PRINT 'Dropping Procedure sps_ParameterEventLookup'
		DROP  Procedure  sps_ParameterEventLookup
	END

GO

PRINT 'Creating Procedure sps_ParameterEventLookup'
GO
CREATE Procedure [dbo].[sps_ParameterEventLookup]
		@EventCategoryID int = NULL,
		@EventSubCategoryID int = NULL,
		@State varchar(12)
AS
/******************************************************************************
**		File: sps_ParameterEventLookup.sql
**		Name: sps_ParameterEventLookup
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: ccarroll						03/10/2008
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**     03/10/2008		ccarroll				Initial
**	   05/19/2009		ccarroll				Added NEOB Events
**	   01/27/2011		ccarroll				Added NV, NE Events
**	   03/03/2014		ccarroll				Added HI
*******************************************************************************/
DECLARE @EventCategoryName AS varchar(255);
DECLARE @EventSubCategoryName AS varchar(255);
DECLARE @RegistryOwnerID AS Int;

IF @State = 'CO'
/* Return Event names for Colorado */
BEGIN
	IF	coalesce(@EventCategoryID, 0) <> 0
		BEGIN
			SET @EventCategoryName = (SELECT EventCategoryName FROM DMV_CO.dbo.EventCategory WHERE EventCategoryID = coalesce(@EventCategoryID, 0))
		END
	ELSE
		BEGIN
			SET @EventCategoryName = 'All';
		END

	IF	coalesce(@EventSubCategoryID, 0) <> 0
		BEGIN
			SET @EventSubCategoryName = (SELECT EventSubCategoryName FROM DMV_CO.dbo.EventSubCategory WHERE EventSubCategoryID = coalesce(@EventSubCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventSubCategoryName = 'All';
		END
END

IF @State = 'WY'
/* Return Event names for Wyoming */

BEGIN
	IF	coalesce(@EventCategoryID, 0) <> 0
		BEGIN
			SET @EventCategoryName = (SELECT EventCategoryName FROM DMV_WY.dbo.EventCategory WHERE EventCategoryID = coalesce(@EventCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventCategoryName = 'All';
		END

	IF	coalesce(@EventSubCategoryID, 0) <> 0
		BEGIN
			SET @EventSubCategoryName = (SELECT EventSubCategoryName FROM DMV_WY.dbo.EventSubCategory WHERE EventSubCategoryID = coalesce(@EventSubCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventSubCategoryName = 'All';
		END
END

IF @State IN ('CT', 'MA', 'ME', 'NH', 'RI', 'VT')
/* Return Event names for NEOB */
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NEOB')
BEGIN
	IF	coalesce(@EventCategoryID, 0) <> 0
		BEGIN
			SET @EventCategoryName = (SELECT EventCategoryName FROM DMV_Common.dbo.EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryID = coalesce(@EventCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventCategoryName = 'All';
		END

	IF	coalesce(@EventSubCategoryID, 0) <> 0
		BEGIN
			SET @EventSubCategoryName = (SELECT EventSubCategoryName FROM DMV_Common.dbo.EventSubCategory WHERE EventSubCategoryID = coalesce(@EventSubCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventSubCategoryName = 'All';
		END
END

IF @State IN ('NV')
/* Return Event names for NDN */
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NDN') ;
BEGIN
	IF	coalesce(@EventCategoryID, 0) <> 0
		BEGIN
			SET @EventCategoryName = (SELECT EventCategoryName FROM DMV_Common.dbo.EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryID = coalesce(@EventCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventCategoryName = 'All';
		END

	IF	coalesce(@EventSubCategoryID, 0) <> 0
		BEGIN
			SET @EventSubCategoryName = (SELECT EventSubCategoryName FROM DMV_Common.dbo.EventSubCategory WHERE EventSubCategoryID = coalesce(@EventSubCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventSubCategoryName = 'All';
		END
END

IF @State IN ('NE')
/* Return Event names for NORS */
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'NORS');
BEGIN
	IF	coalesce(@EventCategoryID, 0) <> 0
		BEGIN
			SET @EventCategoryName = (SELECT EventCategoryName FROM DMV_Common.dbo.EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryID = coalesce(@EventCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventCategoryName = 'All';
		END

	IF	coalesce(@EventSubCategoryID, 0) <> 0
		BEGIN
			SET @EventSubCategoryName = (SELECT EventSubCategoryName FROM DMV_Common.dbo.EventSubCategory WHERE EventSubCategoryID = coalesce(@EventSubCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventSubCategoryName = 'All';
		END
END

IF @State IN ('HI')
/* Return Event names for HIOP */
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM RegistryOwner WHERE RegistryOwnerName = 'HIOP') ;
BEGIN
	IF	coalesce(@EventCategoryID, 0) <> 0
		BEGIN
			SET @EventCategoryName = (SELECT EventCategoryName FROM DMV_Common.dbo.EventCategory WHERE RegistryOwnerID = @RegistryOwnerID AND EventCategoryID = coalesce(@EventCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventCategoryName = 'All';
		END

	IF	coalesce(@EventSubCategoryID, 0) <> 0
		BEGIN
			SET @EventSubCategoryName = (SELECT EventSubCategoryName FROM DMV_Common.dbo.EventSubCategory WHERE EventSubCategoryID = coalesce(@EventSubCategoryID, 0));
		END
	ELSE
		BEGIN
			SET @EventSubCategoryName = 'All';
		END
END

SELECT	@EventCategoryName AS 'EventCategoryName',
		@EventSubCategoryName AS 'EventSubCategoryName';



GO
