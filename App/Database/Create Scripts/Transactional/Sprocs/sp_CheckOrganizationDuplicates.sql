IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sp_CheckOrganizationDuplicates')
	BEGIN
		PRINT 'Dropping Procedure sp_CheckOrganizationDuplicates';
		DROP Procedure sp_CheckOrganizationDuplicates;
	END
GO

PRINT 'Creating Procedure sp_CheckOrganizationDuplicates';
GO
CREATE Procedure sp_CheckOrganizationDuplicates
AS
/******************************************************************************
**	File: sp_CheckOrganizationDuplicates.sql
**	Name: sp_CheckOrganizationDuplicates
**	Desc: checks Service level for duplicate Organizations
**	Auth: Bret Knoll
**	Date: 9/18/2019
**	Called By: SQL Job 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	9/18/2019		Bret Knoll		Initial Sproc Creation (9376)
**	1/13/2022		Mike Berenson	Changed Recipient to ServiceConsultant@statline.org
*******************************************************************************/

	declare 
		@xmlData Nvarchar(max),
		@sql nvarchar(max);
	if OBJECT_ID('tempdb..#DuplicateRecords') is not null
	begin
		drop table #DuplicateRecords;
	end		
	create table #DuplicateRecords
	(
		ServiceLevelGroupName nvarchar(max) , 
		OrganizationID int, 
		OrganizationName nvarchar(max), 
		SourceCodeName nvarchar(max)
	);

	set @sql = 'select distinct sl.ServiceLevelGroupName , o.OrganizationID, o.OrganizationName, sc.SourceCodeName
		from ServiceLevel30Organization so
		join (
					  select so.OrganizationID, slsc.SourceCodeID
					  from (select distinct Organizationid, ServiceLevelid from   ServiceLevel30Organization) so
					  join ServiceLevel on so.ServiceLevelID = ServiceLevel.ServiceLevelID
					  join ServiceLevelSourceCode slsc on ServiceLevel.ServiceLevelid = slsc.ServiceLevelID
							   join Organization on so.OrganizationID = Organization.OrganizationID
					  where ServiceLevel.ServiceLevelStatus = 1
							  and Organization.OrganizationTypeID <> 1 -- Procurement Organization
					 group by so.OrganizationID, slsc.SourceCodeID
					  having count(so.ServiceLevelID) > 1
			   ) do on so.OrganizationID = do.OrganizationID
		join ServiceLevel sl on so.ServiceLevelID = sl.ServiceLevelID
		join Organization o on so.OrganizationID = o.OrganizationID
		join ServiceLevelSourceCode slsc on sl.ServiceLevelID = slsc.ServiceLevelID and do.SourceCodeID = slsc.SourceCodeID
		join SourceCode sc on slsc.SourceCodeID = sc.SourceCodeID
		where sl.ServiceLevelStatus = 1
		order by  o.OrganizationName, sc.SourceCodeName 
		';

	insert #DuplicateRecords
	exec (@sql);

	if exists (select * from #DuplicateRecords)
	begin
		exec msdb..sp_send_dbmail @subject = 'Organizations in Multiple Service Levels',
		@body = 'An organization has been placed into more than one Service Level in the same Source Code.',
		@importance='High',
		@query= @sql,
		@execute_query_database='_ReferralProd',
		@body_format = 'text',
		@recipients = 'ServiceConsultant@statline.org';
	end
	if OBJECT_ID('tempdb..#DuplicateRecords') is not null
	begin
		drop table #DuplicateRecords;
	end		

GO
GRANT EXEC ON sp_CheckOrganizationDuplicates TO PUBLIC;
GO