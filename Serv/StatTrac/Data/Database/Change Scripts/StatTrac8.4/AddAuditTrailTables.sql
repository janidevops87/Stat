INSERT AuditTrailTable (AuditTrailTableName)
select 
	replace(name, 'Delete','') 

from 
	sysobjects 
where 
	name like 'delete%'
order by id