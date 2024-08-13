# TheLook eCommerce dbt Project

## Project Description
TheLook eCommerce dbt Project aims to transform source data from public datasets available in Google BigQuery into various models to monitor business performance. This portfolio piece demonstrates how data can be structured and analyzed to answer key business questions, including:

1. **Overall Performance**:
	- What is the overall performance in the last year?
	- What are the top-selling products and categories?
2. **Customer Insights**:
	- How many returning vs. new customers do we have?
	- What products are being purchased by returning and new customers?
3. **Website Funnel Effectiveness**:
	- How effective is the website funnel in converting visits to purchases?
	- Which marketing channel is generating the most purchases?
4. **Distribution Center Analysis in the USA**:
	- Which distribution centers are frequently shipping products to customers from non-optimal locations?
	- What are the categories and products most often shipped from a non-optimal locations to customers?

This project showcases advanced data modeling, transformation, and analysis techniques using dbt, providing actionable insights to improve business performance. The data was visualized in four LookerStudio dashboards that may be accessed by the following [link](https://lookerstudio.google.com/reporting/d84185e7-6e4b-4d4f-b476-450296e46f88).

## [LookerStudio Dashboards](https://lookerstudio.google.com/reporting/d84185e7-6e4b-4d4f-b476-450296e46f88)
![Screenshot 2024-08-13 at 3 38 00 PM](https://github.com/user-attachments/assets/66c1352a-2a53-4f56-b485-a843c11081b9)

![Screenshot 2024-08-13 at 3 38 23 PM](https://github.com/user-attachments/assets/42439b2f-63b0-43ba-a5bf-c33879895b84)

## Key Transformations

- **Order Items Intermediate Table:** Joins orders, distribution centers, inventory, and order items into a single intermediary table, providing dimensions such as the distribution center the product was sent from and metrics like revenue earned from product sales.

- **User Closest DC Intermediate:** Identifies the closest distribution center to each customer using the `ST_DISTANCE` and `QUALIFY` statements.

- **New vs Returning Customers in User Table:** Distinguishes between new and returning customers based on their first purchase date and recurring purchases.

- **Funnel Performance Table:** Filters key funnel metrics to provide visibility into channel and browser performance.


## DAG
![dbt-dag (2)](https://github.com/user-attachments/assets/729a2f50-f788-406a-8678-066660cf3266)

## Installation Instructions
To set up this project, you will need:
1. An account with [Google BigQuery](https://cloud.google.com/bigquery).
2. [dbt](https://docs.getdbt.com/docs/installation) installed on your local machine.
3. Python 3.6+.
4. Necessary dependencies:
   ```sh
   pip install dbt-bigquery
   ```

### Running the Project
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo-url.git
   cd your-repo
   ```

2. Set up your BigQuery profile in `~/.dbt/profiles.yml`:
   ```yaml
   your_project_name:
     target: dev
     outputs:
       dev:
         type: bigquery
         method: oauth
         project: your-gcp-project-id
         dataset: your_dataset
         threads: 1
         timeout_seconds: 300
         location: US
   ```

3. Run dbt models:
   ```sh
   dbt run
   ```

4. Test the models:
   ```sh
   dbt test
   ```

5. Generate and serve documentation:
   ```sh
   dbt docs generate
   dbt docs serve
   ```

## Project Structure
The project is structured according to dbt best practices:

- `models/`
  - `staging/`: Staging files that prepare raw data for further transformations.
  - `intermediate/`: Intermediate files that join and transform staging data.
  - `marts/`: Final fact and dimension tables that are used for analysis and reporting.

## License
This project is licensed under the MIT License.

## Contact Information
For any questions or feedback, feel free to reach out:
- [LinkedIn](https://www.linkedin.com/in/nima-aref/)
- [Email](mailto:nima.aref6@gmail.com)

## Additional Information
This project uses public datasets available in Google BigQuery. Special thanks to the providers of these datasets. For more details on the datasets used, please refer to the BigQuery documentation.

## Acknowledgments
- [dbt](https://www.getdbt.com/)
- [Google BigQuery](https://cloud.google.com/bigquery)
