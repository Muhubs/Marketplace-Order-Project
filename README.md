# Marketplace_order 🛍️

## About the Data
The data used for this project consists of order information obtained from sales across three platforms: **Shopee**, **Lazada**, and **TikTok**. The details captured include:

- **Order_Number**
- **Username**
- **Item Code**
- **Discount**
- **Shipping Fee**
- **Transportation**
- **Total Price**

This data is received every morning to facilitate sales orders for stock adjustments, revenue collection, creditor payments, and shipping.

## Tech Stack
- **Oracle DB**
- **Oracle Forms**
- **Oracle Reports**
- **SQL Loader**

## Data Pipeline
<p align="center">
  <img src="https://github.com/user-attachments/assets/571b07e9-6799-415b-b19e-d785fc9e1085" alt="Data Pipeline">
</p>

## Data Ingestion
- Collect data including Order Number, Username, Item Code, Discount, Shipping Fee, Transportation, and Total Price from each platform, with the **Order Number** serving as the unique key.

## Data Transformation
- Store the collected data in the **landing zone**.
  
### Automation with PL/SQL
During this process, we will use PL/SQL in Oracle Forms to automate various tasks:
<p align="center">
  <img src="https://github.com/user-attachments/assets/8f729a17-0faa-47a5-970b-5386b8b03329" alt="PL/SQL Automation">
</p>

### Background Operations
A Windows application operates in the background, controlled by **window6**:
<p align="center">
  <img src="https://github.com/user-attachments/assets/8258223a-ed23-4712-a6f3-12cd4ba3a352" alt="Background Operations">
</p>

To perform data processing:
1. **Press "Connect"** and then **"Gen_saleorder"**. This will initiate the following tasks:
   - Format the data by truncating the date to **DD/MM/YYYY** and removing the time.
   - Truncate the Order Number to **13 characters** and eliminate any leading or trailing spaces.
   - Remove rows with **null values** in the Item Code.
   - Filter out Item Codes that do not exist in the database.
   - Exclude data where the selling price exceeds the listed price.
   - Remove Order Numbers that are duplicated in the database logs.
   - Import the cleansed data into **Process Generated Orders** for stock adjustments, revenue collection, and creditor payments.

   **Note:** This part involves significant internal data processing, and specific details cannot be disclosed.

## Data Loading and Cleanup
- Load history and logs into the database table.
- Delete data from the landing zone once processing is complete.
