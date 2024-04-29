{{ config(materialized='table') }}

with source_data as (
    select person_id as id
    from {{ source('omop_person', 'person') }}
    limit 100
)

select id
from source_data
