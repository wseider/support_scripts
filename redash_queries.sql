/*FOR BULK DELETE VIEW SCRIPT: run this query and export csv where org_id is the internal (integer) id and 
'XXXXXXXXX'is the views you'd like to delete.  column[0] will be the id (with header), which is needed to 
run the script*/
select cast(id as varchar), name 
from perspectives
where organization_id = '{org_id}'
and name IN ('XXXXXXXXX')

/*FOR BULK DELETE LISTS: procedure is the same as the above bulk delete views */
select cast(id as varchar), name
from lists
where organization_id = 'XXXX'
and name IN('XXXXX')

/*FOR BULK DELETE CATALOGS: procedure is same as above two queries*/
select cast(id as varchar), name
from catalogs
where organization_id = 'XXXX'
and name IN('XXXXX') 