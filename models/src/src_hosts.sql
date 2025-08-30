

with raw_hosts as(
    select 
        * 
    from  
        {{ source('airbnb_raw_data', 'RAW_HOSTS') }}
)
select 
    id as host_id,
    name as host_name,
    is_superhost,
    created_at,
    updated_at
from 
    raw_hosts

