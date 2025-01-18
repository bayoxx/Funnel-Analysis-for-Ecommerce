-- Funnel Analysis for ecommerce events

WITH formatted_events AS (
  SELECT
    PARSE_DATE('%Y%m%d', event_date) AS event_date_format,
    TIMESTAMP_MICROS(event_timestamp) AS event_timestamp_format,
    event_name,
    event_value_in_usd,
    user_id,
    user_pseudo_id,
    TIMESTAMP_MICROS(user_first_touch_timestamp) AS user_first_touch_timestamp_format,
    category,
    mobile_model_name,
    mobile_brand_name,
    operating_system,
    language,
    is_limited_ad_tracking,
    browser,
    browser_version,
    country,
    medium,
    name,
    traffic_source,
    platform,
    total_item_quantity,
    purchase_revenue_in_usd,
    refund_value_in_usd,
    shipping_value_in_usd,
    tax_value_in_usd,
    transaction_id,
    page_title,
    page_location,
    source,
    page_referrer,
    campaign
  FROM
    `tc-da-1.turing_data_analytics.raw_events`
),
unduplicated_events AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY user_pseudo_id, event_name ORDER BY event_timestamp_format ASC) AS row_num
  FROM
    formatted_events
)
SELECT
  event_date_format AS event_date,
  event_timestamp_format AS event_timestamp,
  event_name,
  event_value_in_usd,
  user_id,
  user_pseudo_id,
  user_first_touch_timestamp_format AS user_first_touch_timestamp,
  category,
  mobile_model_name,
  mobile_brand_name,
  operating_system,
  language,
  is_limited_ad_tracking,
  browser,
  browser_version,
  country,
  medium,
  name,
  traffic_source,
  platform,
  total_item_quantity,
  purchase_revenue_in_usd,
  refund_value_in_usd,
  shipping_value_in_usd,
  tax_value_in_usd,
  transaction_id,
  page_title,
  page_location,
  source,
  page_referrer,
  campaign
FROM
  unduplicated_events
WHERE
  row_num = 1;



  


-- Funnel Analysis for ecommerce selected events

WITH formatted_events AS (
  SELECT
    TIMESTAMP_MICROS(event_timestamp) AS event_timestamp_format,
    event_name,
    user_pseudo_id,
    country
  FROM
    `tc-da-1.turing_data_analytics.raw_events`
),
unduplicated_events AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY user_pseudo_id, event_name ORDER BY event_timestamp_format ASC) AS row_num
  FROM
    formatted_events
),
event_data AS (
  SELECT
    event_name,
    user_pseudo_id,
    country
  FROM
    unduplicated_events
  WHERE
    row_num = 1
),
event_counts AS (
  SELECT
    country,
    COUNT(user_pseudo_id) AS total_event_count
  FROM
    event_data
  WHERE
    event_name IN ('page_view', 'session_start', 'view_item', 'add_to_cart', 'begin_checkout', 'purchase')
  GROUP BY
    country
  ORDER BY
    total_event_count DESC
  LIMIT 3
)
SELECT
  event_data.event_name,
  event_data.country,
  COUNT(event_data.user_pseudo_id) AS event_count
FROM
  event_data
INNER JOIN
  event_counts
ON
  event_data.country = event_counts.country
WHERE
  event_name IN ('page_view', 'session_start', 'view_item', 'add_to_cart', 'begin_checkout', 'purchase')
GROUP BY
  event_data.event_name,
  event_data.country
ORDER BY
  event_data.country,
  event_data.event_name;





