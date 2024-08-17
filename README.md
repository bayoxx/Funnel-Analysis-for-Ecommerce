### Project Overview: Funnel Analysis for E-commerce

**Objective:**
The goal was to perform a funnel analysis for an e-commerce store, focusing on key user events across the top three countries by event volume: Canada, India, and the United States. The analysis aimed to identify user engagement and conversion rates at each stage of the funnel, from initial interaction to purchase.

**Process:**

1. **Data Exploration:**
   - The analysis began with a thorough exploration of the `raw_events` table in BigQuery to understand the events captured during user interactions on the website.
   - A key challenge was dealing with duplicate events that could inflate the results. I wrote SQL queries in BigQuery to eliminate duplicate events, ensuring that only the first occurrence of each event per `user_pseudo_id` was considered for the funnel analysis.

2. **Event Selection:**
   - Identified and selected six key events relevant to the e-commerce funnel: `page_view`, `session_start`, `view_item`, `add_to_cart`, `begin_checkout`, and `purchase`.
   - Created a unique events table in BigQuery to be used for the funnel analysis.

3. **Funnel Chart Creation:**
   - Using Google Sheets, I created a funnel chart with a country split to compare user behaviour across Canada, India, and the United States. The funnel chart illustrated the drop-off rates at each stage of the funnel.

**Insights:**

1. **Initial Engagement:**
   - High initial engagement was observed, with approximately 99% of users who viewed a page also starting a session across all three countries.
2. **Drop-off After Item View:**
   - A significant drop in engagement occurred after the `view_item` event, with only about 22-23% of users proceeding to the `add_to_cart` stage.
3. **Cart Abandonment:**
   - There was a substantial drop between `add_to_cart` and `begin_checkout`, with only 4.73% of initial users adding items to their cart, and 20.74% of those who viewed items actually adding them to their cart.
4. **High Checkout Engagement:**
   - A high percentage (75.56% - 76.94%) of users who added items to their cart proceeded to the `begin_checkout` stage.
5. **Final Purchase Rate:**
   - Despite strong engagement at the checkout stage, only about 45.06% - 46.47% of users who began checkout completed the purchase, resulting in a final conversion rate of 1.65% from the top of the funnel to purchase across all three countries.

**Country-Specific Insights:**
   - **Canada:** Performed slightly better in the early stages but had similar drop-off rates in later stages as India and the US.
   - **India:** Displayed a comparable pattern to Canada but with a slight increase in drop-off during the `add_to_cart` stage.
   - **United States:** Had higher engagement in early stages but a similar drop-off in later stages, indicating uniform challenges across countries.

**Recommendations:**

1. **Product Visibility & Selection:**
   - Enhance product visibility and streamline the selection process to reduce drop-off after `view_item`.

2. **Checkout Optimization:**
   - Investigate the causes of drop-off between `begin_checkout` and `purchase`, focusing on factors like shipping costs, return policies, and trust issues.

3. **Leverage High Engagement Strategies:**
   - Analyze and replicate the strategies that led to high engagement at the checkout stage to improve performance at earlier funnel stages.

4. **Country-Specific Analysis:**
   - Conduct a detailed analysis of cultural or economic factors affecting user behaviour in each country to tailor strategies accordingly.

---
**Tools Used**:
- **BigQuery** for data extraction and SQL queries.
- **Googlesheet** for data visualization and analysis.

- This is the link to my [spreadsheet](https://docs.google.com/spreadsheets/d/1Of7Kw0Yh-bIjfY0pTYlM-UTS-VuaEvmEe_P_pFyQTG8/edit?usp=sharing). The spreadsheet shows my **dashboard**, **the data and my workings**, **insights**, and **recommendations**. 

Note: *I have also attached the .sql file to this repository*. You can also check the SQL Query [here](https://github.com/bayoxx/Funnel-Analysis-for-Ecommerce/blob/main/Funnel%20Analysis.sql)

