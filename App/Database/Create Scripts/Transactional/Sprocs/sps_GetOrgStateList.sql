SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetOrgStateList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetOrgStateList]
GO


CREATE PROCEDURE sps_GetOrgStateList

@StateID	int		=null,
@RefType	int		=null,
@OrderBy	varchar(30)	=null

AS
/******************************************************************************
**	File: sps_GetOrgStateList.sql
**	Name: sps_GetOrgStateList
**	Desc: Selects multiple rows of Organizations 
**	Auth: unknown
**	Date: 00/00/0000
**	Called By: Old Reports
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	00/00/0000		unknown					Initial Sproc Creation
**	03/01/2012		ccarroll				Added JOIN to OrganizationPhone and Group BY
**	03/13/2012		ccarroll				Added noted for inclusion in release CCRST168 
*******************************************************************************/
DECLARE	@StateStart	int
DECLARE	@StateLast	int
DECLARE	@RefStart	int
DECLARE	@RefLast	int

--Gather State Data
If @StateID <> 0
	BEGIN
		SELECT @StateStart = @StateID
		SELECT @StateLast = @StateID
	END
ELSE
	BEGIN
		SELECT @StateStart = @StateID
		SELECT @StateLast = MAX(StateID)
		FROM State
	END

--Gather Referral Type Data
If @RefType <> 0
	BEGIN
		SELECT @RefStart = @RefType
		SELECT @RefLast = @RefType
	END
ELSE
	BEGIN
		SELECT @RefStart = @RefType
		SELECT @RefLast = MAX(OrganizationTypeID)
		FROM OrganizationType
	END

IF @OrderBy = 'OrganizationTypeName'
	BEGIN

	--Main Query
	SELECT
	MIN('(' + Phone.PhoneAreaCode + ') ' + Phone.PhonePrefix + '-' + Phone.PhoneNumber) AS Phone,
	Organization.OrganizationID,
	Organization.OrganizationName,
	Organization.OrganizationAddress1,
	Organization.OrganizationCity,
	County.CountyName,
	Organization.OrganizationZipCode,
	OrganizationType.OrganizationTypeName
	
	FROM Organization
	JOIN	State ON State.StateID = Organization.StateID
	JOIN    OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
	JOIN	Phone ON Phone.PhoneID = OrganizationPhone.PhoneID
	JOIN 	County ON County.CountyID = Organization.CountyID
	JOIN	OrganizationType ON OrganizationType.OrganizationTypeID = Organization.OrganizationTypeID
	
	WHERE (State.StateID BETWEEN @StateStart AND @StateLast) AND
		(OrganizationType.OrganizationTypeID BETWEEN @RefStart AND @RefLast)
	Group BY 
	Organization.OrganizationID,
	Organization.OrganizationName,
	Organization.OrganizationAddress1,
	Organization.OrganizationCity,
	County.CountyName,
	Organization.OrganizationZipCode,
	OrganizationType.OrganizationTypeName

	ORDER BY OrganizationTypeName, OrganizationName
 
	END

ELSE
	BEGIN

	--Main Query
	SELECT
	MIN('(' + Phone.PhoneAreaCode + ') ' + Phone.PhonePrefix + '-' + Phone.PhoneNumber) AS Phone,
	Organization.OrganizationID,
	Organization.OrganizationName,
	Organization.OrganizationAddress1,
	Organization.OrganizationCity,
	County.CountyName,
	Organization.OrganizationZipCode,
	OrganizationType.OrganizationTypeName
	
	FROM Organization
	JOIN	State ON State.StateID = Organization.StateID
	JOIN    OrganizationPhone ON Organization.OrganizationID = OrganizationPhone.OrganizationID
	JOIN	Phone ON Phone.PhoneID = OrganizationPhone.PhoneID
	JOIN 	County ON County.CountyID = Organization.CountyID
	JOIN	OrganizationType ON OrganizationType.OrganizationTypeID = Organization.OrganizationTypeID
	
	WHERE (State.StateID BETWEEN @StateStart AND @StateLast) AND
		(OrganizationType.OrganizationTypeID BETWEEN @RefStart AND @RefLast)

	Group BY 
	Organization.OrganizationID,
	Organization.OrganizationName,
	Organization.OrganizationAddress1,
	Organization.OrganizationCity,
	County.CountyName,
	Organization.OrganizationZipCode,
	OrganizationType.OrganizationTypeName

	ORDER BY OrganizationTypeName, OrganizationName ASC

	END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

