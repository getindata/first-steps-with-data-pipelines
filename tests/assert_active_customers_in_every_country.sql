-- Check if every country has at least 1 active customer [in the report]

WITH calculate_countries_count AS (
    SELECT
      COUNT(DISTINCT id) AS country_count
    FROM
      {{ ref('countries') }}
), calculate_active_customers_countries AS (
    SELECT
      COUNT(DISTINCT countryId) AS country_count
    FROM
      {{ ref('customers_report') }}
)
SELECT
  1
FROM
  calculate_countries_count AS ccc
INNER JOIN
  calculate_active_customers_countries AS cacc
ON
  ccc.country_count != cacc.country_count
