select
    countries.id AS countryId,
    countries.name as countryName,
    count(*) as customerCount
from
    {{ ref('countries') }} as countries
inner join
    {{ ref('customers') }} as customers
on
    countries.id = customers.countryId
where
    customers.isActive = true
group by
    countries.id,
    countries.name
