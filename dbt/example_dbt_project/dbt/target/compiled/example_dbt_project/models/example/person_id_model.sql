

with source_data as (
    select person_id as id
    from "postgres"."demo_cdm"."person"
    limit 100
)

select id
from source_data