{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_1",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('test_category_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'brand_di',
        'created_on',
        'category_id',
        'display_name',
    ]) }} as _airbyte_test_category_hashid,
    tmp.*
from {{ ref('test_category_ab2') }} tmp
-- test_category
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

