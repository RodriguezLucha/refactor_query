SELECT
  cu.customer_id AS id,
  concat(cu.first_name, ' ', cu.last_name) AS name,
  a.address AS address,
  a.postal_code AS `zip code`,
  a.phone AS phone,
  sakila.city.city AS city,
  sakila.country.country AS country,
  if(cu.active, 'active', '') AS notes,
  cu.store_id AS sid
FROM
  (
    (
      (
        sakila.customer cu
        JOIN sakila.address a on((cu.address_id = a.address_id))
      )
      JOIN sakila.city on((a.city_id = sakila.city.city_id))
    )
    JOIN sakila.country on(
      (
        sakila.city.country_id = sakila.country.country_id
      )
    )
  )