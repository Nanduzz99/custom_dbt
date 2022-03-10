{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_1",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('airbyte_1', '_airbyte_raw_test_brand') }}
select
    {{ json_extract_scalar('_airbyte_data', ['brand_id'], ['brand_id']) }} as brand_id,
    {{ json_extract_scalar('_airbyte_data', ['brand_name'], ['brand_name']) }} as brand_name,
    {{ json_extract_scalar('_airbyte_data', ['created_on'], ['created_on']) }} as created_on,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('airbyte_1', '_airbyte_raw_test_brand') }} as table_alias
-- test_brand
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

