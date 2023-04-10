/*
This script drops all foreign keys in the database to allow for second script to rebuild them.



*/

declare @dropSqlQuery nvarchar(4000)

while exists(select sys.schemas.name ,sys.tables.name,sys.foreign_keys.name from sys.foreign_keys
	join sys.tables on sys.foreign_keys.parent_object_id = sys.tables.object_id
	join sys.schemas on sys.tables.schema_id = sys.schemas.schema_id)
begin

	select @dropSqlQuery = 'ALTER TABLE [' + sys.schemas.name + '].[' + sys.tables.name + '] DROP CONSTRAINT [' + sys.foreign_keys.name + ']' from sys.foreign_keys
	join sys.tables on sys.foreign_keys.parent_object_id = sys.tables.object_id
	join sys.schemas on sys.tables.schema_id = sys.schemas.schema_id
	print @dropSqlQuery

	exec sp_executesql @dropSqlQuery	

end