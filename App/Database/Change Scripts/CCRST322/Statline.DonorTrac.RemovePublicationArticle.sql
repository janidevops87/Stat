/**************************************************************************************************
** The following script will remove an article from Publication, allowing for table changes.
** If you are making table changes add the schema and table name to the @tableList below. 
** 
**	Note: following the deployment the AuditTrail scripts will need to be reran to re-enable all publications
**	This script is stored under the queries folder of the transactional database project
*** 1. To use this script under the give CCR folder add a "DataMigrationPreDeployment" script and place this script in the folder.
*** 2. Update the @tableList to include all tables that are changing and new tables. Add new tables to cover when we make changes in test after the inital create.
*** 3. Modify GenerateSQL to check the DataMigrationPreDeployment folder. This line should run before any sql changes.
*** Following the script push AuditTrail script are automatically ran in Test. The DBA will manually run all replication scripts.
****************************************************************************************************/

PRINT '----------------------------------- Remove Publication Article: ' + DB_NAME()  + ' -----------------------------------'

SET NOCOUNT ON;
declare @tableList table 
(
	schemaName sysname,
	tableName sysname
)

insert @tableList values ('dbo', 'Message')
		     
;

/*********************** Do not modify anything below this line **************************************/

declare 	
	@destinationDb sysname,
	@serverName sysname,
	@publication sysname,
	@destinationTable sysname,
	@articlename sysname;

declare @subscriptionList table
(
	destinationDb sysname,
	serverName sysname,
	publication sysname,
	destinationTable sysname,
	articlename sysname
);

-- Publication need to have allow_anonymnous false and immediate sync false in order for this process to work.
--exec sp_changepublication AuditTrail,allow_anonymous,false 
--GO
--exec sp_changepublication AuditTRail,immediate_sync,false 
--GO

-- check to see if replication is running before trying to stop it
if exists(select * from sys.tables where name = 'sysarticles')
BEGIN
	insert @subscriptionList
		select ss.dest_db,
			ss.srvname, sp.name as 'Publication',
			sa.dest_table,
			sa.name as 'articleName'
		from sysarticles sa
			join sys.objects so on sa.objid = so.object_id
			join sys.schemas sc on so.schema_id = sc.schema_id	
			join syssubscriptions ss on sa.artid = ss.artid
			join syspublications sp on sa.pubid = sp.pubid
			join @tableList tl on so.name = tl.tableName and sc.name = tl.schemaName;

	while exists (select * from @subscriptionList)
	begin
		select top(1)
			@destinationDb = destinationDb,
			@serverName = serverName,
			@publication = publication,
			@destinationTable = destinationTable,
			@articlename = articlename
		from @subscriptionList;
		
		PRINT  @articlename;
		EXEC sp_dropsubscription 
			@publication=@publication,
			@article=@articlename,
			@subscriber = @serverName,
			@destination_db=@destinationDb;
	
		EXEC sp_droparticle  
			@publication = @publication,
			@article = @articlename, 
			@force_invalidate_snapshot = 0;

		delete @subscriptionList
		where @destinationDb = destinationDb
			and @serverName = serverName
			and @publication = publication
			and @destinationTable = destinationTable
			and @articlename = articlename;
	end
 END
GO
