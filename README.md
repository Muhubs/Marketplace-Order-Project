# Marketplace_order 🛍️

# About Data 
   - The data used for this project is Order data obtained from sales on three platforms: Shopee, Lazada, and TikTok. The details include Order_Number, Username, Item Code, Discount, Shipping Fee, Transportation, and Total Price. This data is received every morning to create sales orders for stock adjustments, revenue collection, creditor payments, and shipping

- Tech Stack
   - Oracle DB
   - Oracle form 
   - Oracle Report
   - SQL Loader
## Data Pipeline 
<p align="center">
  <img src="https://github.com/user-attachments/assets/571b07e9-6799-415b-b19e-d785fc9e1085" alt="image">
</p>

## Data Ingestion

  - Collect Order Number, Username, Item Code, Discount, Shipping Fee, Transportation, and Total Price data from each platform, with Order Number serving as the key.
## Data Transformation
  - Store the data in the landing zone.
  - ### (on this process we will write PL/SQL on oracle form to do Automate)
    ![image](https://github.com/user-attachments/assets/8f729a17-0faa-47a5-970b-5386b8b03329)
  - ### Windows operating in the background that control by window6
    ![image](https://github.com/user-attachments/assets/8258223a-ed23-4712-a6f3-12cd4ba3a352)
  ###   Just Press connect and press "Gen_saleorder!! It will perform the following tasks"
  - Format the data, such as truncating the date to include only DD/MM/YYYY and removing the time.
  - Truncate the Order Number to 13 characters and remove any leading or trailing spaces.
  - Remove rows with null values in the Item Code.
  - Filter out Item Codes that do not exist in the database.
  - Exclude data where the selling price is higher than the listed price.
  - Remove Order Numbers that are duplicated in the logs in the database.
  - Import the cleansed data into the Process Generated Orders, primarily for stock adjustments, revenue collection, and creditor payments.
    **Note: This part involves significant internal data processing, so the details cannot be disclosed **
## Load History and logs to Databased table and Delete data on landing zone.

