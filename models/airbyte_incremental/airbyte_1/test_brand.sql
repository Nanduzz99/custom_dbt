{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "airbyte_1",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('test_brand_ab3') }}
select
    brand_id,
    brand_name,
    created_on,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_test_brand_hashid
from {{ ref('test_brand_ab3') }}
-- test_brand from {{ source('airbyte_1', '_airbyte_raw_test_brand') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

