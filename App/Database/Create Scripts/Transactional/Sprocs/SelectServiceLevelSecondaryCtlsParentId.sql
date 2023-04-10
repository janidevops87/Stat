

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectServiceLevelSecondaryCtlsParentId')
	BEGIN
		PRINT 'Dropping Procedure SelectServiceLevelSecondaryCtlsParentId';
		PRINT GETDATE();
		DROP Procedure SelectServiceLevelSecondaryCtlsParentId;
	END
GO
;
PRINT 'Creating Procedure SelectServiceLevelSecondaryCtlsParentId'
PRINT GETDATE();
GO
CREATE Procedure SelectServiceLevelSecondaryCtlsParentId
(
		@ServiceLevelID int = null
)
AS
/******************************************************************************
**	File: SelectServiceLevelSecondaryCtlsParentId.sql
**	Name: SelectServiceLevelSecondaryCtlsParentId
**	Desc: Selects multiple rows of ServiceLevelSecondaryCtls Based on Id  fields 
**	Auth: Pam Scheichenost
**	Date: 10/16/2019
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/16/2019		Pam Scheichenost		Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	Select distinct 
		s1.ServiceLevelSecondaryCtlsID,
		s1.ServiceLevelID,
		s1.ParentID,
		s1.ControlName,
		s1.DisplayName,
		s1.DisplayOrder,
		s1.Visible,
		s1.X,
		s1.Y,
		s1.Height,
		s1.LeftPos,
		isnull(s2.visible,-1) as parentvisible, 
		s1.MaxChar 
	from ServiceLevelSecondaryCtls s1 
	left join servicelevelsecondaryctls s2 on s1.parentid = s2.ServiceLevelSecondaryCtlsId 
	Where s1.ServiceLevelId = @ServiceLevelID
	and s1.visible = -1 
	and (s2.visible IS NULL OR s2.visible = -1 )
order by s1.parentid, s1.displayorder asc;
	
GO

GRANT EXEC ON SelectServiceLevelSecondaryCtlsParentId TO PUBLIC;
GO
