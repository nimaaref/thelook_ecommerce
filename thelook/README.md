# TheLook eCommerce dbt Project

## Project Description
TheLook eCommerce dbt Project is designed to transform source data from public datasets available in Google BigQuery into various models that monitor business performance and better understand user funnel progression. This project is a portfolio piece that showcases how data can be structured and analyzed to answer key business questions.

## Installation Instructions
To set up this project, you will need:
1. An account with [Google BigQuery](https://cloud.google.com/bigquery).
2. [dbt](https://docs.getdbt.com/docs/installation) installed on your local machine.
3. Python 3.6+.
4. Necessary dependencies:
   ```sh
   pip install dbt-bigquery
   ```

## Usage Instructions
This project is intended to demonstrate how data can be structured to answer various business questions. It includes models that can be used to generate reports on:
- Product performance, including margin percentage per product.
- User progression through the funnel.
- Top-selling products for a given time period.

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

## Key Features
- **Final Tables in Mart Folder:** These tables are used to visualize data in Looker Studio, providing insights into business performance and user behavior.
- **Modular Structure:** The project is organized in a way that makes it easy to extend and modify.
- **Comprehensive Testing:** Includes tests for data integrity and quality to ensure reliable outputs.

## Examples or Screenshots
Coming Soon!

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
