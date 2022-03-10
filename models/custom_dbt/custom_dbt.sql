select
    a.brand_name,
    b.display_name
from {{ ref('test_brand') }} a
left join {{ ref('test_category') }} b
on a._airbyte_test_brand_hashid = b._airbyte_test_category_hashid