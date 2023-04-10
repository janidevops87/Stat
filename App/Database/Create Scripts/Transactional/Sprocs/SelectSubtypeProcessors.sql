IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectSubtypeProcessors')
	BEGIN
		PRINT 'Dropping Procedure SelectSubtypeProcessors';
		PRINT GETDATE();
		DROP Procedure SelectSubtypeProcessors;
	END
GO

PRINT 'Creating Procedure SelectSubtypeProcessors';
PRINT GETDATE();
GO
CREATE Procedure SelectSubtypeProcessors
(
		@CriteriaId int,
		@ProcessorId int
)
AS
/******************************************************************************
**	File: SelectSubtypeProcessors.sql
**	Name: SelectSubtypeProcessors
**	Desc: Selects Subtype Processors
**	Auth: Pam Scheichenost
**	Date: 11/21/2019
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/21/2019		Pam Scheichenost		Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

(
	SELECT 
		cs.subtypeid, 
		s.subtypename, 
		cs.processorprecedence, 
		cs.subcriteriaid, '1' AS checked 
	FROM subcriteria cs 
	INNER JOIN subtype s ON cs.subtypeid = s.subtypeid 
	Where CriteriaID = @CriteriaId 
	And ProcessorId = @ProcessorId
Union 
	SELECT 
		s.subtypeid, 
		s.subtypename, 
		'0', 
		'0', 
		'0' 
	FROM subtype s 
	WHERE EXISTS (SELECT 1 FROM criteriasubtype WHERE criteriaid = @CriteriaId AND s.subtypeid = criteriasubtype.subtypeid)
	AND NOT EXISTS (select 1 from subcriteria where criteriaid = @CriteriaId And ProcessorId = @ProcessorId AND s.subtypeid = subcriteria.subtypeid)
) 
	order by s.subtypename asc;
	
GO

GRANT EXEC ON SelectSubtypeProcessors TO PUBLIC;
GO

