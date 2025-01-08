-- CHALLENGE 20 --------------------------------------------
/* 
Parse out all the query parameters from the urls.

A query param is a list of key value pairs that follow this syntax ?item=toy&id=1

Note the & is how to list multiple key value pairs.

Once you extract all the query params filter them so only the urls with utm_source=advent-of-sql are returned.

Submit the url with the most query params (including the utm-source)

If there are multiple rows order by the url ascending

Example Schema: 
CREATE TABLE web_requests (
    request_id SERIAL PRIMARY KEY,
  	url TEXT NOT NULL
);

Example Result:
                                                url                                                |                                            query_parameters                                             | count_params 
---------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------+--------------
 http://music.example.com/playlist?genre=pop&duration=long&listener=guest&utm_source=advent-of-sql | { "genre" : "pop", "duration" : "long", "listener" : "guest", "utm_source" : "advent-of-sql" }          |            4
 https://shop.example.com/items?item=toy&color=red&size=small&ref=google&utm_source=advent-of-sql  | { "item" : "toy", "color" : "red", "size" : "small", "ref" : "google", "utm_source" : "advent-of-sql" } |            5
 http://news.example.org/article?id=123&source=rss&author=jdoe&utm_source=advent-of-sql            | { "id" : "123", "source" : "rss", "author" : "jdoe", "utm_source" : "advent-of-sql" }                   |            4

*/
-- SOLUTION --------------------------------------------- 
with query_string as (
  select 
  	request_id, 
  	split_part(url, '?', 2) as params
  from web_requests 
),
key_value_pairs as (
  select 
  	request_id, 
  	string_to_array(params, '&') as kv_array
  from query_string
), 
json_kv_pairs as (
	select 
	  request_id,
	  json_object_agg(split_part(pair, '=', 1), split_part(pair, '=', 2)) as query_parameters
	from key_value_pairs, 
	lateral unnest(kv_array) as pair
	group by request_id
)
select 
	wr.url,
	jkp.query_parameters,
	(select count(distinct json_object_keys) from json_object_keys(jkp.query_parameters)) as count_params
from web_requests wr 
join json_kv_pairs jkp on wr.request_id =jkp.request_id
where jkp.query_parameters ->> 'utm_source' = 'advent-of-sql'
order by 3 desc, 1

-- RESULT ---------------------------------------------
-- http://abbott.biz?sapiente_incidunt_quisquam_saepe=tempore-vel-labore-vel&eos-fugit-veniam-alias=voluptatum_officia_esse_ut_numquam&ea_voluptas=possimus-iure-doloribus-ab-dolorum&utm_source=advent-of-sql


