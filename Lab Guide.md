# Setup the Azure Synapse Analytics (ASA) workspace

## Task 1 - Create resources

1. Create a new resource group

2. In the resource group, create a regular blob storage account. Create in it two private containers named `staging` and `models`.

3. In the resource group, create an empty Azure Synapse Analytics workspace.

4. Create the following file systems in the primary storage account of the workspace: `dev`, `staging`, and `wwi`. Also create a new dedicated SQL Pool and Apache Spark Pool in the same synapse workspace.

5. Create a linked service to the dedicated pool of the workspace. Configure it to connect with username and password and use the workspace's SQL admin account credentials. It is recommended to name the linked service `sqlpool01` to simplify importing datasets, data flows, and pipelines later.

6. Create a linked service to the primary storage account. Configure it to connect with the account key. It is recommended to name the linked service `asadatalake01` to simplify importing datasets, data flows, and pipelines later.

7. Create a linked service to the blob storage account. Configure it to connect with the account key. It is recommended to name the linked service `asastore01` to simplify importing datasets, data flows, and pipelines later.

8. For the remainder of this guide, the following terms will be used for various ASA-related resources (make sure you replace them with actual names and values):

    ASA resource | To be referred to as
    --- | ---
    Workspace resource group | `WorkspaceResourceGroup`
    Workspace | `Workspace`
    Identity used to create `Workspace` | `MasterUser`
    Primary storage account | `PrimaryStorage`
    Blob storage account | `BlobStorage`
    First Spark pool | `SparkPool01`
    First SQL pool | `SQLPool01`
    SQL admin account | `asa.sql.admin`
    Linked service to first SQL pool | `sqlpool01`
    Linked service to primary storage account | `asadatalake01`
    Linked service to blob storage account | `asastore01`

9.  Ensure the `Workspace` security principal (which has the same name as the `Workspace`) and the `MasterUser` (the one used to create the `Workspace`) are added with the `Storage Blob Data Owner` or <mark>Storage Blob Data Contributor</mark> role to the `PrimaryStorage`.

## Task 2 - Upload the data used in the lab

1. Create a folder named `bronze` in the `dev` file system of `PrimaryStorage`.

2. Upload the following data files to the `bronze` folder created above:

    File name | Size | Download from
    --- | --- | ---
    `postalcodes.csv` | 1.8 MB | https://solliancepublicdata.blob.core.windows.net/wwi-01/postalcodes.csv
    `wwi-dimcity.csv` | 17.5 MB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-dimcity.csv
    `wwi-dimcustomer.csv` | 67.3 KB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-dimcustomer.csv
    `wwi-dimdate.csv` | 146.3 KB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-dimdate.csv
    `wwi-dimemployee.csv` | 18.7 KB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-dimemployee.csv
    `wwi-dimpaymentmethod.csv` | 514 B | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-dimpaymentmethod.csv
    `wwi-dimstockitem.csv` | 114.6 KB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-dimstockitem.csv
    `wwi-dimsupplier.csv` | 3.8 KB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-dimsupplier.csv
    `wwi-dimtransactiontype.csv` | 1.3 KB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-dimtransactiontype.csv
    `wwi-factmovement.csv` | 11.1 MB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-factmovement.csv
    `wwi-factorder.csv` | 31.3 MB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-factorder.csv
    `wwi-factpurchase.csv` | 461.1. KB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-factpurchase.csv
    `wwi-factsale-big-1.csv` | 3.0 GB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-factsale-big-1.csv
    `wwi-factsale-big-2.csv` | 3.0 GB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-factsale-big-2.csv
    `wwi-factsale-big-3.csv` | 3.0 GB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-factsale-big-3.csv
    `wwi-factsale-big-4.csv` | 3.0 GB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-factsale-big-4.csv
    `wwi-factsale.csv` | 1.8 GB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-factsale.csv
    `wwi-factstockholding.csv` | 8.9 KB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-factstockholding.csv
    `wwi-facttransaction.csv` | 7.2 MB | https://solliancepublicdata.blob.core.windows.net/wwi-01/wwi-facttransaction.csv

## Task 3 - Import datasets, data flows, and pipelines

### Import datasets pointing to `PrimaryStorage`

Perform the following steps for each dataset to be imported:

1. Create a new, empty dataset with the same name as the one to be imported.

2. Switch to code view and replace the code with the content of the associated JSON file.

3. If the name used for the linked service to `PrimaryStorage` is not `asadatalake01`, replace the `properties.linkedServiceName.referenceName` value in JSON with the actual name of the linked service.

4. Save and publish the dataset. Optionally, you can publish all datasets at once, at the end of the import procedure.

The following datasets pointing to `PrimaryStorage` must be imported:

Dataset | Source code
--- | ---
`external_postalcode_adls` | [external_postalcode_adls.json](dataset/external_postalcode_adls.json)
`staging_enrichedcustomer_adls` | [staging_enrichedcustomer_adls.json](dataset/staging_enrichedcustomer_adls.json)
`wwi_dimcity_adls` | [wwi_dimcity_adls.json](dataset/wwi_dimcity_adls.json)
`wwi_dimcustomer_adls` | [wwi_dimcustomer_adls.json](dataset/wwi_dimcustomer_adls.json)
`wwi_dimdate_adls` | [wwi_dimdate_adls.json](dataset/wwi_dimdate_adls.json)
`wwi_dimemployee_adls` | [wwi_dimemployee_adls.json](dataset/wwi_dimemployee_adls.json)
`wwi_dimpaymentmethod_adls` | [wwi_dimpaymentmethod_adls.json](dataset/wwi_dimpaymentmethod_adls.json)
`wwi_dimstockitem_adls` | [wwi_dimstockitem_adls.json](dataset/wwi_dimstockitem_adls.json)
`wwi_dimsupplier_adls` | [wwi_dimsupplier_adls.json](dataset/wwi_dimsupplier_adls.json)
`wwi_dimtransactiontype_adls` | [wwi_dimtransactiontype_adls.json](dataset/wwi_dimtransactiontype_adls.json)
`wwi_factmovement_adls` | [wwi_factmovement_adls.json](dataset/wwi_factmovement_adls.json)
`wwi_factorder_adls` | [wwi_factorder_adls.json](dataset/wwi_factorder_adls.json)
`wwi_factpurchase_adls` | [wwi_factpurchase_adls.json](dataset/wwi_factpurchase_adls.json)
`wwi_factsale_adls` | [wwi_factsale_adls.json](dataset/wwi_factsale_adls.json)
`wwi_factsale_big_1_adls` | [wwi_factsale_big_1_adls.json](dataset/wwi_factsale_big_1_adls.json)
`wwi_factsale_big_2_adls` | [wwi_factsale_big_2_adls.json](dataset/wwi_factsale_big_2_adls.json)
`wwi_factsale_big_3_adls` | [wwi_factsale_big_3_adls.json](dataset/wwi_factsale_big_3_adls.json)
`wwi_factsale_big_4_adls` | [wwi_factsale_big_4_adls.json](dataset/wwi_factsale_big_4_adls.json)
`wwi_factstockholding_adls` | [wwi_factstockholding_adls.json](dataset/wwi_factstockholding_adls.json)
`wwi_facttransaction_adls` | [wwi_facttransaction_adls.json](dataset/wwi_facttransaction_adls.json)

### Import datasets pointing to `SQLPool1`

Perform the following steps for each dataset to be imported:

1. Create a new, empty dataset with the same name as the one to be imported.

2. Switch to code view and replace the code with the content of the associated JSON file.

3. If the name used for the linked service to `SQLPool01` is not `sqlpool01`, replace the `properties.linkedServiceName.referenceName` value in JSON with the actual name of the linked service.

4. Save and publish the dataset. Optionally, you can publish all datasets at once, at the end of the import procedure.

The following datasets pointing to `SQLPool01` must be imported:

Dataset | Source code
--- | ---
`wwi_dimcity_asa` | [wwi_dimcity_asa.json](dataset/wwi_dimcity_asa.json)
`wwi_dimcustomer_asa` | [wwi_dimcustomer_asa.json](dataset/wwi_dimcustomer_asa.json)
`wwi_dimdate_asa` | [wwi_dimdate_asa.json](dataset/wwi_dimdate_asa.json)
`wwi_dimemployee_asa` | [wwi_dimemployee_asa.json](dataset/wwi_dimemployee_asa.json)
`wwi_dimpaymentmethod_asa` | [wwi_dimpaymentmethod_asa.json](dataset/wwi_dimpaymentmethod_asa.json)
`wwi_dimstockitem_asa` | [wwi_dimstockitem_asa.json](dataset/wwi_dimstockitem_asa.json)
`wwi_dimsupplier_asa` | [wwi_dimsupplier_asa.json](dataset/wwi_dimsupplier_asa.json)
`wwi_dimtransactiontype_asa` | [wwi_dimtransactiontype_asa.json](dataset/wwi_dimtransactiontype_asa.json)
`wwi_factmovement_asa` | [wwi_factmovement_asa.json](dataset/wwi_factmovement_asa.json)
`wwi_factorder_asa` | [wwi_factorder_asa.json](dataset/wwi_factorder_asa.json)
`wwi_factpurchase_asa` | [wwi_factpurchase_asa.json](dataset/wwi_factpurchase_asa.json)
`wwi_factsale_asa` | [wwi_factsale_asa.json](dataset/wwi_factsale_asa.json)
`wwi_factstockholding_asa` | [wwi_factstockholding_asa.json](dataset/wwi_factstockholding_asa.json)
`wwi_facttransaction_asa` | [wwi_facttransaction_asa.json](dataset/wwi_facttransaction_asa.json)
`wwi_perf_factsale_fast_asa` | [wwi_perf_factsale_fast_asa.json](dataset/wwi_perf_factsale_fast_asa.json)
`wwi_perf_factsale_slow_asa` | [wwi_perf_factsale_slow_asa.json](dataset/wwi_perf_factsale_slow_asa.json)
`wwi_staging_dimcustomer_asa` | [wwi_staging_dimcustomer_asa.json](dataset/wwi_staging_dimcustomer_asa.json)
`wwi_staging_enrichedcustomer_asa` | [wwi_staging_enrichedcustomer_asa.json](dataset/wwi_staging_enrichedcustomer_asa.json)

### Import data flows

Perform the following steps for each data flow to be imported:

1. Create a new, empty data flow with the same name as the one to be imported.

2. Switch to code view and replace the code with the content of the associated JSON file.

3. Save and publish the data flow. Optionally, you can publish all data flows at once, at the end of the import procedure.

The following data flows must be imported:

Data flow | Source code
--- | ---
`EnrichCustomerData` | [EnrichCustomerData.json](dataflow/EnrichCustomerData.json)

### Import pipelines

Perform the following steps for each pipeline to be imported:

1. Create a new, empty pipeline with the same name as the one to be imported.

2. Switch to code view and replace the code with the content of the associated JSON file.

3. Save and publish the pipeline. Optionally, you can publish all pipelines at once, at the end of the import procedure.

The following pipelines must be imported:

Pipeline | Source code
--- | ---
`Exercise 2 - Enrich Data` | [Exercise 2 - Enrich Data.json](pipeline/Exercise%202%20-%20Enrich%20Data.json)
`Import WWI Data` | [Import WWI Data.json](pipeline/Import%20WWI%20Data.json)
`Import WWI Data - Fact Sale Full` | [Import WWI Data - Fact Sale Full.json](pipeline/Import%20WWI%20Data%20-%20Fact%20Sale%20Full.json)
`Import WWI Perf Data - Fact Sale Fast` | [Import WWI Perf Data - Fact Sale Fast.json](pipeline/Import%20WWI%20Perf%20Data%20-%20Fact%20Sale%20Fast.json)
`Import WWI Perf Data - Fact Sale Slow` | [Import WWI Perf Data - Fact Sale Slow.json](pipeline/Import%20WWI%20Perf%20Data%20-%20Fact%20Sale%20Slow.json)

## Task 4 - Populate `PrimaryStorage` with data

1. Import the [Setup Task 4 - Export Sales to Data Lake](
    Artifacts/Notebooks/Setup%20Task%204%20-%20Export%20Sales%20to%20Data%20Lake.ipynb) notebook.

2. Replace `<primary_storage>` with the actual data lake account name of `PrimaryStorage` in cells 1, 4, and 6.

3. Run the notebook to populate `PrimaryStorage` with data.

## Task 5 - Configure the SQL on-demand pool

1. Create a SQL on-demand database running the following script on the `master` database of the SQL on-demand pool:

    ```sql
    CREATE DATABASE SQLOnDemand01
    ```

2. Ensure the SQL on-demand pool can query the storage account using the following script:

    ```sql
    CREATE CREDENTIAL [https://<primary_storage>.dfs.core.windows.net]
    WITH IDENTITY='User Identity';
    ```

    In the script above, replace `<primary_storage>` with the name of `PrimaryStorage`.

    [Refer here](Artifacts/SQL%20Files/Setup%20Task%205%20-%20Configure%20the%20SQL%20on-demand%20pool.sql)

## Task 6 - Configure `SQLPool01`

1. Connect with either the SQL Active Directory admin or the `asa.sql.admin` account to `SQLPool01` using the tool of your choice.

2. Run the [Setup Task 6_1 - Configure SQLPool01](Artifacts/SQL%20Files/Setup%20Task%206_1%20-%20Configure%20SQLPool01.sql) SQL script to initialize the schema of the SQL pool.

3. Create the `asa.sql.staging` login in the `master` database of `Workspace` using the following script:

    ```sql
    CREATE LOGIN [asa.sql.staging]
	WITH PASSWORD = '<password>'
    GO
    ```

    In the script above, replace `<password>` with the actual password of the login.

4. Create the `asa.sql.staging` user in `SQLPool01` (not in master database) using the following script:

    ```sql
    CREATE USER [asa.sql.staging]
        FOR LOGIN [asa.sql.staging]
        WITH DEFAULT_SCHEMA = dbo
    GO

    -- Add user to the required roles

    EXEC sp_addrolemember N'db_datareader', N'asa.sql.staging'
    GO

    EXEC sp_addrolemember N'db_datawriter', N'asa.sql.staging'
    GO

    EXEC sp_addrolemember N'db_ddladmin', N'asa.sql.staging'
    GO
    ```

    
5. Configure access control to workspace pipeline runs in `SQLPool01` using the following script:

    ```sql
    --Create user in DB
    CREATE USER [<workspace>] FROM EXTERNAL PROVIDER;

    --Granting permission to the identity
    GRANT CONTROL ON DATABASE::<sqlpool> TO [<workspace>];
    ```

    In the script above, replace `<workspace>` with the actual name of `Workspace` and `<sqlpool>` with the actual name of `SQLPool01`.

    [Refer here](Artifacts/SQL%20Files/Setup%20Task%206_2%20-%20Create%20the%20login.sql)

>
6. Run the `Import WWI Data` pipeline to import all data except the sale facts into `SQLPool01`.

7. Run the `Import WWI Data - Fact Sale Full` pipeline to import the sale facts into `SQLPool01`.

8. Run the `Import WWI Perf Data - Fact Sale Fast` and `Import WWI Perf Data - Fact Sale Slow` pipelines to import the large-sized sale facts into `SQLPool01`.


## Task 7 - Configure Power BI

1. Ensure the `MasterUser` has a Power BI Pro subscription assigned.

2. Sign in to the [Power BI portal](https://powerbi.com) using the credentials of `MasterUser` and create a new Power BI workspace. In the remainder of this guide, this workspace will be referred to as `PowerBIWorkspace`.

3. Perform all the steps described in [Exercise 3 - Task 1](Lab%20Guide.md##task-1---create-a-power-bi-dataset-in-synapse). In step 11, instead of using the suggested naming convention, name your dataset `wwifactsales`.

4. In the Power BI portal, edit the security settings of the `wwifactsales` dataset and configure it to authenticate to `SQLPool01` using the credentials of the `asa.sql.admin` account. This allows the `Direct Query` option to work correctly for all participants in the lab.

## Task 8 - Import all SQL scripts and Spark notebooks

Import the following SQL scripts into `Workspace`:

SQL script name | Source code | Replacements
--- | --- | ---
`Ex 1 Task 1_2 - Read with SQL on-demand` | [Ex 1 Task 1_2 - Read with SQL on-demand.sql](Artifacts/SQL%20Files/Ex%201%20Task%201_2%20-%20Read%20with%20SQL%20on-demand.sql) | `<primary_storage>` with the actual name of `PrimaryStorage`
`Ex 4 Task 1 - Analyze Transactions` | [Ex 4 Task 1 - Analyze Transactions.sql](Artifacts/SQL%20Files/Ex%204%20Task%201%20-%20Analyze%20Transactions.sql) | None
`Ex 4 Task 2 - Investigate query performance` | [Ex 4 Task 2 - Investigate query performance.sql](Artifacts/SQL%20Files/Ex%204%20Task%202%20-%20Investigate%20query%20performance.sql) | None
`Ex 5 Task 1_1 - Create sample Data for Predict` | [Ex 5 Task 1_1 - Create sample Data for Predict](Artifacts/SQL%20Files/Ex%205%20Task%201_1%20-%20Create%20Sample%20Data%20for%20Predict.sql) | None
`Ex 5 Task 2 - Predict with model` | [Ex 5 Task 1 - Predict with model.sql](Artifacts/SQL%20Files/Ex%205%20Task%202%20-%20Predict%20with%20model.sql) | None
`Ex 5 Task 1_2 - Register model` | [Ex 5 Task 1_2 - Register model.sql](Artifacts/SQL%20Files/Ex%205%20Task%201_2%20-%20Register%20model.sql) | `<blob_storage_account_key>` with the storage account key of `BlobStorage`; `<blob_storage>` with the storage account name of `BlobStorage`

Import the following Spark notebooks into `Workspace`:

Spark notebook name | Source code | Replacements
--- | --- | ---
`Ex 2 - Bonus Notebook with CSharp` | [Ex 2 - Bonus Notebook with CSharp.ipynb](Artifacts/Notebooks/Ex%202%20-%20Bonus%20Notebook%20with%20CSharp.ipynb) | In cell 1 - `<primary_storage>` with the actual name of `PrimaryStorage`; In cell 3 - `<sql_staging_password>` with the password of `asa.sql.staging` created above in Task 4, step 3; In cell 3 - `<workspace>` with the name of the `Workspace`; In cell 3 - `<sql_pool>` with the name of `SQLPool1`

<!-- `Exercise 1 - Read with Spark` | [Exercise 1 - Read with Spark.ipynb](Artifacts/Notebooks/Exercise%201%20-%20Read%20with%20Spark.ipynb) | `<primary_storage>` with the actual name of `PrimaryStorage`
`Exercise 2 - Ingest Sales Data` | [Exercise 2 - Ingest Sales Data.ipynb](./artifacts/02/Exercise%202%20-%20Ingest%20Sales%20Data.ipynb) | In cell 1 - `<primary_storage>` with the actual name of `PrimaryStorage` -->


## Task 10 - Configure additional users to access the workspace

For each additional user that needs to have access to `Workspace` and run exercises 1 through 5, the following steps must be performed:

1. Assign the `Reader` role on the `WorkspaceResourceGroup` to the user.

2. Assign the `Reader` and `Blob Data Contributor` roles on the `PrimaryStorage` to the user.

3. Assign the `Workspace admin` role in the `Workspace` to the user.

4. Grant access to the `SQLPool01` to the user using the script below. You must be signed in with the `MasterUser` credentials (use SQL Server Management Studio if the script fails in Synapse Studio).

    ```sql
    CREATE USER [<user_principal_name>] FROM EXTERNAL PROVIDER;
    EXEC sp_addrolemember 'db_owner', '<user_principal_name>';
    ```

    In the script above, replace `<user_principal_name>` with Azure Active Directory user principal name of the user.

5. Assign the `Contributor` role on the Power BI workspace of the `MasterUser` created in Task 5, step 2.

<br/><br/>

# Exercise 1 - Explore the Data Lake with Azure Synapse serverless SQL pool and Azure Synapse Spark


In this exercise, you will explore data using the engine of your choice (SQL or Spark).

Understanding data through data exploration is one of the core challenges faced today by data engineers and data scientists. Depending on the data's underlying structure and the specific requirements of the exploration process, different data processing engines will offer varying degrees of performance, complexity, and flexibility.

In Azure Synapse Analytics, you can use either the SQL Serverless engine, the big-data Spark engine, or both.

The tasks you will perform in this exercise are:

- Explore the Data Lake with SQL On-demand and Spark
  - Task 1 - Explore the Data Lake with Azure Synapse serverless SQL pool 
  - Task 2 - Explore the Data Lake with Azure Synapse Spark

## Task 1 - Explore the Data Lake with Azure Synapse serverless SQL pool 

In this task, you will browse your data lake using serverless SQL pool.

1. In a Microsoft Edge web browser, navigate to the Azure portal (`https://portal.azure.com`) and login with your credentials. Then select **Resource groups**.

   ![Open Azure resource group](./media/00-open-resource-groups.png "Azure resource groups")

2. Select the **Synapse Analytics** resource group.

   ![Open Synapse Analytics resource group](./media/00-open-synapse-resource-group.png "Resources list")

3. Select **SQLPool01** and **resume** it before starting the exercise.

   ![SQLPool01 is highlighted.](media/select-sql-pool.png "SQLPool01")

   ![Resume sqlpool](./media/00-resume-sqlpool.png "Resume")

4. Return to the resource group, then select the **Synapse Analytics** workspace.

   ![Open Azure Synapse Analytics workspace](./media/00-open-workspace.png "Azure Synapse workspace")

5. On the Synapse workspace blade, open Synapse Analytics Studio by navigating to the **Workspace web URL** from the overview page.

   > You can also Open synapse studio by clicking on **Open** under **Getting started->Open synapse studio**

   ![The Launch Synapse Studio button is highlighted on the Synapse workspace toolbar.](media/ex01-open-synapse-studio.png "Launch Synapse Studio")

6. In Synapse Analytics Studio, navigate to the `Data` hub.

   ![Open Data hub in Synapse Analytics Studio](./media/data-hub.png)

7. Switch to the `Linked` tab **(1)**. Under `Azure Data Lake Storage Gen2` **(2)**, expand the primary data lake storage account, and then select the `wwi` file system **(3)**.

   ![The ADLS Gen2 storage account is selected.](media/storage-factsale-parquet.png "ADLS Gen2 storage account")

8. Inside the selected file system, double-click to navigate to `factsale-parquet` -> `2012` -> `Q1` -> `InvoiceDateKey=2012-01-01` **(4)**.

9. Once you are in `InvoiceDateKey=2012-01-01` right-click the Parquet file and select `New SQL script - Select TOP 100 rows`.

   > A script is automatically generated. Run this script to see how SQL on demand queries the file and returns the first 100 rows of that file with the header, allowing you to explore data in the file easily.

   ![Start new SQL script from data lake file](./media/ex01-sql-on-demand-01.png "Create a new SQL script")

10. Ensure the newly created script is connected to the `Built-in` pool representing serverless SQL pool and select `Run`. Data is loaded by the built-in SQL pool and processed as if it came from any regular relational database.

    ![Run SQL script on data lake file](./media/ex01-sql-on-demand-02.png "Execute SQL script")

11. Let us change the initial script to load multiple Parquet files at once.

    - In line 2, replace `TOP 100 *` with `COUNT(*)`.
    - In line 5, replace the path to the individual file with

    ```python
    https://<yourdatalake storage account name>.dfs.core.windows.net/wwi/factsale-parquet/2012/Q1/*/*
    ```

    > Note: Replace '< yourdatalake storage account name >' with the **Storage Account Name** provided in the environment details section on the Lab Environment tab on the right.

12. Select `Run` to re-run the script. You should see a result of `2991716`, which is the number of records contained in all the Parquet files within the `factsale-parquet/2012/Q1` directory.

    ![Run SQL on-demand script loading multiple Parquet data lake files](./media/ex01-sql-on-demand-03.png)

    [Refer here](Artifacts/SQL%20Files/Ex%201%20Task%201_1%20-%20Query%20parquet%20files%20from%20ADLS.sql)


13. In Azure Synapse Analytics Studio, navigate to the `Develop` hub.

    ![Develop hub.](media/develop-hub.png "Develop hub")

14. Select the `Exercise 1 - Read with SQL on-demand` **(1)** SQL script. Connect to **Built-in (2)**. Select **Run (3)** to execute the script.

    ![Run SQL on-demand script loading multiple CSV data lake files](./media/ex01-sql-on-demand-04.png)

    > This query demonstrates the same functionality, except this time, it loads CSV files instead of Parquet ones (notice the `factsale-csv` folder in the path). Parquet files are compressed and store data in columnar format for efficient querying, compared to CSV files that are raw representations of data but easily processed by many systems. You can often encounter many file types stored in a data lake and must know how to access and explore those files. For instance, when you access CSV files, you need to specify the format, field terminator, and other properties to let the query engine understand how to parse the data. In this case, we determine the value of `2` for FIRSTROW. This indicates that the first row of the file must be skipped because it contains the column header.
    >
    > Here, we use WITH to define the columns in the files. You must use WITH when using a bulk rowset (OPENROWSET) in the FROM clause. Also, defining the columns enables you to select and filter the values within.

    [Refer here](Artifacts/SQL%20Files/Ex%201%20Task%201_2%20-%20Read%20with%20SQL%20on-demand.sql)

## Task 2 - Explore the Data Lake with Azure Synapse Spark

1. Navigate to the `Data` hub, browse to the data lake storage account folder `wwi/factsale-parquet/2012/Q1/InvoiceDateKey=2012-01-01`, then right-click the Parquet file and select `New notebook->Load Data frame`

   ![Start new Spark notebook from data lake file](./media/ex01-spark-notebook-001.png "Create a new Spark notebook")

2. This will generate a notebook with PySpark code to load the data in a dataframe and display 10 rows with the header.

   ![New Spark notebook from data lake file](./media/ex01-spark-notebook-002.png "Review the notebook")

3. Attach the notebook to a Spark pool **(1)**.

   ![Run Spark notebook on data lake file](./media/ex01-attachsparkpool01.png "Attach notebook to Spark pool")

4. Select **Run all** on the notebook toolbar **(2)** to execute the notebook.

   > **Note**: The first time you run a notebook in a Spark pool, Synapse creates a new session. This can take approximately 3 minutes.
   
    ![Waiting for the Spark pool to start.](./media/ex01-attachsparkpool01waiting.png "Waiting for the Spark pool to start.")

5. As you can see, the output of the dataframe is displayed with 10 rows. To  display 100 rows with the header, replace the last line of code with the following:

   ```python
   display(df.limit(100))
   ```

6. Re-run the notebook again to see the result.

   ![Improve dataset formatting in Spark notebook](./media/ex01-spark-notebookrun-04.png "Execute notebook")

7. Notice the included charting capabilities that enable visual exploration of your data. Switch to **Chart** view **(1)**. Select **View Options (2)** and change the **Key** to `CustomerKey` **(3)** and **Values** to `CityKey` **(4)**. Finally, select **Apply** to apply changes **(5)**.

    ![View charts on data in Spark notebook](./media/ex01-spark-notebook-05.png "Review charted data")

8. Hover over the area just below the cell in the notebook, then select **{} Add code** to add a new cell.

   ![The add code button is highlighted.](media/add-cell.png "Add code")

9. Paste the following into the cell, and **replace** `YOUR_DATALAKE_NAME` **(1)** with the name of your **Storage Account Name** provided in the environment details section on the Lab Environment tab on the right. You can also copy it from the first cell of the notebook above.

   ```python
   data_path = spark.read.load(
      'abfss://wwi@YOUR_DATALAKE_NAME.dfs.core.windows.net/factsale-csv/2012/Q1/*/*',
      format='csv',
      sep="|",
      header=True)

   display(data_path.limit(100))
   ```

10. Select the **Run cell** button **(2)** to execute the new cell.

    ![The new cell is displayed, and the run cell button is highlighted.](media/notebook-new-csv-cell.png "New cell to explore CSV files")

    > This notebook demonstrates the same functionality, except this time, it loads CSV files instead of Parquet ones (notice the `factsale-csv` folder in the path).

11. **Important**: If you are continuing to Exercise 2 now, _leave this notebook open for the first task_ of the next exercise. This way, you can continue to use this notebook and the running Spark session, saving you time.
<br/><br/>
# Exercise 2 - Build a Modern Data Warehouse with Azure Synapse Pipelines

In this exercise, you examine various methods for ingesting data into Azure Synapse Analytics and Azure Data Lake Storage Gen2. You use notebooks and Data Flows to ingest, transform, and load data.

The tasks you will perform in this exercise are:

- Build Modern Data Warehouse pipelines
  - Task 1 - Explore and modify a notebook
    - Bonus Challenge
  - Task 2 - Explore, modify, and run a Pipeline containing a Data Flow
  - Task 3 - Monitor pipelines
  - Task 4 - Monitor Spark applications

---

**Important**:

In the tasks below, you will be asked to enter a unique identifier in several places. You can find your unique identifier by looking at the username you were provided for logging into the Azure portal. Your username is in the format `odl_user_UNIQUEID@msazurelabs.onmicrosoft.com`, where the _UNIQUEID_ component looks like `206184`, `206137`, or `205349`, as examples.

Please locate this value and note it for the steps below.

---

## Task 1 - Explore and modify a notebook

In this task, you see how easy it is to write into a dedicated SQL pool table with Spark thanks to the SQL Analytics Connector. Notebooks are used to write the code required to write to dedicated SQL pool tables using Spark.

1. **Note:** If you still have your notebook open from the end of Exercise 1, **skip ahead** to step 3 below. Otherwise, in Synapse Studio, select **Develop** from the left-hand menu.

   ![Develop is selected and highlighted in the Synapse Analytics menu.](media/develop-hub.png "Develop hub")

2. Select **+**, then **Notebook** to add a new notebook.

   ![The new notebook menu item is highlighted.](media/new-notebook.png "New notebook")

3. If not already attached, attach your Apache Spark pool by selecting it from the **Attach to** drop-down list **(1)**, then select **{} Add code** to create a new cell **(2)**.

   ![The Spark pool is selected in the Attach to drop-down.](media/new-notebook-add-code.png "Add code")

   **Note:** If you are using your notebook from the end of Exercise 1, hover over the area just below the cell in the notebook, then select **{} Add code** to add a new cell.

   ![The add code button is highlighted.](media/add-cell.png "Add code")

4. Paste the following into the new cell, and **replace** `YOUR_DATALAKE_NAME` with the name of your **Storage Account Name** provided in the environment details section on Lab Environment tab on the right. You can also copy it from the first cell of the notebook if you are using the same one from Exercise 1.

    ```scala
    %%spark

    // Set the path to read the WWI Sales files
    import org.apache.spark.sql.SparkSession

    // Set the path to the ADLS Gen2 account
    val adlsPath = "abfss://wwi@YOUR_DATALAKE_NAME.dfs.core.windows.net"
    ```

    Select the **Run cell** button to execute the new cell:

    ![The new cell is displayed.](media/ex02-notebook-cell1.png "Run cell")

    > This cell imports required libraries and sets the `adlsPath` variable, which defines the path used to connect to an Azure Data Lake Storage (ADLS) Gen2 account. Connecting to ADLS Gen2 from a notebook in Azure Synapse Analytics uses the power of Azure Active Directory (AAD) pass-through between compute and storage. The `%%spark` "magic" sets the cell language to Scala, which is required to use the `SparkSession` library.

5. Hover over the area just below the cell in the notebook, then select **{} Add code** to add a new cell.

    ![The add code button is highlighted.](media/add-cell.png "Add code")

6. Paste the following and run the new cell:

    ```scala
    %%spark

    // Read the sales into a dataframe
    val sales = spark.read.format("csv").option("header", "true").option("inferSchema", "true").option("sep", "|").load(s"$adlsPath/factsale-csv/2012/Q4")
    sales.show(5)
    sales.printSchema()
    ```

    This code loads data from CSV files in the data lake into a DataSet. Note the `option` parameters in the `read` command. These options specify the settings to use when reading the CSV files. The options tell Spark that the first row of each file containers the column headers, the separator in the files in the `|` character, and that we want Spark to infer the schema of the files based on an analysis of the contents of each column. Finally, we display the first five records of the data retrieved and print the inferred schema to the screen.

7. When the cell finishes running, take a moment to review the associated output.

    > The output of this cell provides some insight into the structure of the data and the data types that have been inferred. The `show(5)` command results in the first five rows of the data read being output, allowing you to see the columns and a sample of data contained within each. The `printSchema()` command outputs a list of columns and their inferred types.

    ![The output from the execution of the cell is displayed, with the result of the show(5) command shown first, followed by the output from the printSchema() command.](media/ex02-notebook-ingest-cell-2-output.png "Cell output")

8. Hover over the area just below the cell in the notebook, then select **{} Add code** to add a new cell.

    ![The add code button is highlighted.](media/add-cell.png "Add code")

9. Paste the following and run the new cell:

    ```scala
    %%spark

    // Import libraries for the SQL Analytics connector
    import com.microsoft.spark.sqlanalytics.utils.Constants
    import org.apache.spark.sql.SqlAnalyticsConnector._
    import org.apache.spark.sql.SaveMode

    // Set target table name
    var tableName = s"SQLPool01.wwi_staging.Sale"

    // Write the retrieved sales data into a staging table in Azure Synapse Analytics.
    sales.limit(10000).write.mode(SaveMode.Append).sqlanalytics(tableName, Constants.INTERNAL)
    ```

    This code writes the data retrieved from Blob Storage into a staging table in Azure Synapse Analytics using the SQL Analytics connector. Using the connector simplifies connecting to Azure Synapse Analytics because it uses AAD pass-through. There is no need to create a password, identity, external table, or format sources, as it is all managed by the connector.

10. As the cell runs, select the arrow icon below the cell to expand the details for the Spark job.

    > This pane allows you to monitor the underlying Spark jobs and observe the status of each. As you can see, the cell is split into two Spark jobs, and the progress of each can be observed. We will take a more in-depth look at monitoring Spark applications in Task 4 below.

    ![The Spark job status pane is displayed below the cell, with the progress of each Spark job visible.](media/ex02-notebook-ingest-cell-3-spark-job.png "Spark Job status")

11. After approximately 1-2 minutes, the execution of Cell 3 will complete. Once it has finished, select **Data** from the left-hand menu.

    ![Data is selected and highlighted in the Synapse Analytics menu.](media/data-hub.png "Data hub")

12. **Important**: Close the notebook by selecting the **X** in the top right of the tab and then select **Close + discard changes**. Closing the notebook will ensure you free up the allocated resources on the Spark Pool.

    ![The Close + discard changes button is highlighted.](media/notebook-close-discard-changes.png "Discard changes?")

13. Under **Workspace** tab **(1)**, expand **Databases** **(2)** and then expand the **SQLPool01** database **(3)**.

    ![The Databases folder is expanded, showing a list of databases within the Azure Synapse Analytics workspace. SQLPool01 is expanded and highlighted.](media/ex02-databasesqlpool.png "Synapse Analytics Databases")

14. Expand **Tables** and locate the table named `wwi_staging.Sale`.

    > If you do not see the table, select the Actions ellipsis next to Tables and then select **Refresh** from the fly-out menu.

    ![The new wwi_staging.Sale table is displayed.](media/data-staging-sales.png "New Sale table")

15. To the right of the `wwi_staging.Sale` table, select the Actions ellipsis.

    ![The Actions ellipsis button is highlighted next to the wwi_staging.Sale_UNIQUEID table.](media/ex02-data-sqlpool01-tables-staging-wwi-sales-data-actions.png "Synapse Analytics Databases")

16. In the Actions menu, select **New SQL script > Select TOP 100 rows**.

    ![In the Actions menu for the wwi_staging.Sale table, New SQL script > Select TOP 100 rows is highlighted.](media/ex02-data-sqlpool01-tables-staging-wwi-sales-data-actions-select.png "Synapse Analytics Databases")

17. Select **Run** to execute the query. Observe the results in the output pane, and see how easy it was to use Spark notebooks to write data from Blob Storage into Azure Synapse Analytics.

    ![The output of the SQL statement is displayed.](media/staging-sale-output.png "Sale script output")

18. Close the SQL script generated by `wwi_staging.Sale`.

    [Refer here](Artifacts/Notebooks/Ex%202%20Task%201%20-%20Explore%20and%20modify%20a%20notebook.ipynb)

### Bonus exercise

Now, take some time to review the **Exercise 2 - Bonus Notebook with CSharp** notebook.

1. In Synapse Studio, select **Develop** from the left-hand menu. Expand **Notebooks** and select the notebook named `Ex 2 - Bonus Notebook with CSharp.ipynb`.

   ![Open bonus notebook with CSharp from Develop hub](./media/ex02-csharp-for-spark-notebook.png "Open bonus notebook with CSharp from Develop hub")

2. Notice the language of choice being .NET Spark C# **(1)**:

   ![CSharp for Spark](./media/ex02-csharp-for-spark.png)

    This notebook demonstrates how easy it is to create and run notebooks using C# for Spark. The notebook shows the code for retrieving Azure Blob Storage data and writing that into a staging table in Azure Synapse Analytics using a JDBC connection.

    You can run each cell in this notebook and observe the output. Be aware, however, that writing data into a staging table in Azure Synapse Analytics with this notebook takes several minutes, so you don't need to wait on the notebook to finish before attempting to query the `wwi_staging.Sale_CSharp` table to observe the data being written or to move on to the next task.

3. Select **Run all (2)** and start the notebook.

    [Refer here](Artifacts/Notebooks/Ex%202%20-%20Bonus%20Notebook%20with%20CSharp.ipynb)

To observe the data being written into the table:

1. Select **Data** from the left-hand menu, select the Workspace tab, then expand Databases, SQLPool01, and Tables.

2. Right-click the table named `wwi_staging.Sale_CSharp`, and choose **New SQL Script** then **SELECT TOP 100 rows**.

   > If you do not see the table, select the Actions ellipsis next to Tables, and then select **Refresh** from the fly-out menu.

3. Replace the `SELECT` query in the editor with the query below:

   ```sql
   SELECT COUNT(*) FROM [wwi_staging].[Sale_CSharp]
   ```

4. Select **Run** on the toolbar.

   > Re-run the query every 5-10 seconds to watch the record count in the table and how it changes as the notebook is adding new records. The script in the notebook limits the number of rows to 1500, so if you see a count of 1500, the notebook has completed processing.

5. **Important**: Close the notebook by selecting the **X** in the top right of the tab and then select **Discard Changes**. Closing the notebook will ensure you free up the allocated resources on the Spark Pool.

## Task 2 - Explore, modify, and run a Pipeline containing a Data Flow

In this task, you use a Pipeline containing a Data Flow to explore, transform, and load data into an Azure Synapse Analytics table. Using pipelines and data flows allows you to perform data ingestion and transformations, similar to what you did in Task 1, but without writing any code.

1. In Synapse Studio and select **Integrate** from the left-hand menu.

   ![Integrate hub.](media/integrate-hub.png "Integrate hub")

2. In the Integrate menu, expand **Pipelines**, then select **Exercise 2 - Enrich Data**.

   ![The Enrich Data pipeline is selected.](media/enrich-data-pipeline.png "Pipelines")

   > Selecting a pipeline opens the pipeline canvas, where you can review and edit the pipeline using a code-free, graphical interface. This view shows the various activities within the pipeline and the links and relationships between those activities. The `Exercise 2 - Enrich Data` pipeline contains two activities, a copy data activity named `Import Customer dimension` and a mapping data flow activity named `Enrich Customer Data`.

3. Now, take a closer look at each of the activities within the pipeline. On the canvas graph, select the **Copy data** activity named `Import Customer dimension`.

    > Below the graph is a series of tabs, each providing additional details about the selected activity. The **General** tab displays the name and description assigned to the activity and a few other properties.

    ![A screenshot of Exercise 2 - Enrich Data pipeline canvas and properties pane is displayed.](media/ex02-orchestrate-copy-data-general.png "Pipeline canvas")

4. Select the **Source** tab. The source defines the location from which the activity will copy data. The **Source dataset** field is a pointer to the location of the source data.

    > Take a moment to review the various properties available on the Source tab. Data is being retrieved from files stored in a data lake.

    ![The Source tab for the Copy data activity is selected and highlighted.](media/ex02-orchestrate-copy-data-source.png "Pipeline canvas property tabs")

5. Next, select the **Sink** tab. The sink specifies where the copied data will be written. Like the Source, the sink uses a dataset to define a pointer to the target data store. Select **PolyBase** for the `Copy method`. This improves the data loading speed as compared to the default setting of bulk insert.

    ![The Sink tab for the Copy data activity is selected and highlighted.](media/ex02-orchestrate-copy-data-sink.png "Pipeline canvas property tabs")

    > Reviewing the fields on this tab, you will notice that it is possible to define the copy method, table options, and to provide pre-copy scripts to execute. Also, take special note of the sink dataset, `wwi_staging_dimcustomer_asa`. The dataset requires a parameter named `UniqueId`, which is populated using a substring of the Pipeline Run Id. This dataset points to the `wwi_staging.DimCustomer_UniqueId` table in Synapse Analytics, which is one of the data sources for the Mapping Data Flow. We will need to ensure that the copy activity successfully populates this table before running the data flow.

6. Select the **Mapping** tab. On this tab, you can review and set the column mappings. As you can see on this tab, the spaces are being removed from the sink's column names.

    ![The Mappings tab for the Copy data activity is highlighted and displayed.](media/ex02-orchestrate-copy-data-mapping.png "Pipeline canvas property tabs")

7. Finally, select the **Settings** tab. Check **Enable staging** and expand `Staging settings`. Select **asadatalake01** under `Staging account linked service`, then type **staging** into `Storage Path`. Finally, check **Enable Compression**.

    ![The staging settings are configured as described.](media/copy-data-settings.png "Settings")

    > Since we are using PolyBase with dynamic file properties, owing to the UniqueId values, we need to [enable staging](https://docs.microsoft.com/azure/data-factory/connector-azure-sql-data-warehouse#staged-copy-by-using-polybase). In cases of large file movement activities, configuring a staging path for the copy activity can improve performance.

8. Switch to the **Mapping Data Flow** activity by selecting the `Enrich Customer Data` Mapping Data Flow activity on the pipeline design canvas, then select the **Settings** tab.

    ![The data flow activity settings are displayed.](media/pipeline-data-flow-settings.png "Settings")

    > Observe the settings configurable on this tab. They include parameters to pass into the data flow, the Integration Runtime, and compute resource type and size to use. If you wish to use staging, you can also specify that here.

9. Next, select the **Parameters** tab in the configuration panel of the Mapping Data Flow activity.

    ![The Parameters table on the configuration panel of the Mapping Data Flow activity is selected and highlighted.](media/ex02-orchestrate-data-flow-parameters.png "Mapping Data Flow activity")

    Notice that the value contains:

    ```sql
    @substring(pipeline().RunId,0,8)
    ```

    > This sets the UniqueId parameter required by the `EnrichCustomerData` data flow to a unique substring extracted from the pipeline run ID.

10. Take a minute to look at the options available on the various tabs in the configuration panel. You will notice the properties here define how the data flow operates within the pipeline.

11. Now, let us look at the data flow definition the Mapping Data Flow activity references. Double-click the **Mapping Data Flow** activity on the pipeline canvas to open the underlying Data Flow in a new tab.

    > **Important**: Typically, when working with Data Flows, you would want to enable **Data flow debug**. [Debug mode](https://docs.microsoft.com/azure/data-factory/concepts-data-flow-debug-mode) creates a Spark cluster to use for interactively testing each step of the data flow and allows you to validate the output before saving and running the data flow. Enabling a debugging session can take up to 10 minutes, so you will not enable this for this workshop. Screenshots will be used to provide details that would otherwise require a debug session to view.

    ![The EnrichCustomerData Data Flow canvas is displayed.](media/ex02-orchestrate-data-flow.png "Data Flow canvas")

12. The [Data Flow canvas](https://docs.microsoft.com/azure/data-factory/concepts-data-flow-overview#data-flow-canvas) allows you to see the construction of the data flow and each component contained within it in greater detail.

    > From a high level, the `EnrichCustomerData` data flow is composed of two data sources, multiple transformations, and two sinks. The data source components, `PostalCodes` and `DimCustomer`, ingest data into the data flow. The `EnrichedCustomerData` and `EnrichedCustomerDataAdls` components on the right are sinks, used to write data to data stores. The remaining components between the sources and sinks are transformation steps, which can perform filtering, joins, select, and other transformational actions on the ingested data.

    ![On the data flow canvas, the components are broken down into three sections. Section number 1 is labeled data sources and contains the PostalCodes and DimCustomer components. Section number 2 is labeled Transformations, and contains the PostCodeFilter, JoinOnPostalCode, and SelectDesiredColumns components. Section number 3 is labeled sinks, and contains the EnrichedCustomerData and EnrichedCustomerDataAdls components.](media/ex02-orchestrate-data-flow-components.png "Data flow canvas")

13. To better understand how a data flow functions, let us inspect the various components. Select the `PostalCodes` data source on the data flow canvas.

    > On the **Source settings** tab, we see properties similar to what we saw on the pipeline activities property tabs. The name of the component can be defined, along with the source dataset and a few other properties. The `PostalCodes` dataset points to a CSV file stored in an Azure Data Lake Storage Gen2 account.

    ![The PostalCodes data source component is highlighted on the data flow canvas surface.](media/ex02-orchestrate-data-flow-sources-postal-codes.png "Data flow canvas")

14. Select the **Projection** tab.

    > The **Projections** tab allows you to define the schema of the data being ingested from a data source. A schema is required for each data source in a data flow to enable downstream transformations to perform actions against the data source fields. Note that selecting **Import schema** requires an active debug session to retrieve the schema data from the underlying data source, as it uses the Spark cluster to read the schema. In the screenshot above, notice the `Zip` column is highlighted. The schema inferred by the import process set the column type to `integer`. For US zip code data, the data type was changed to `string` so leading zeros are not discarded from the five-digit zip codes. It is essential to review the schema to ensure the correct types are set, both for working with the data and to ensure it is displayed and stored correctly in the data sink.

    ![The Projections tab for the PostalCodes data source is selected, and the Zip column of the imported schema is highlighted.](media/ex02-orchestrate-data-flow-sources-postal-codes-projection.png "Data flow canvas")

15. The **Data preview** tab allows you to ingest a small subset of data and view it on the canvas. This functionality requires an active debug session, so for this workshop, a screenshot that displays the execution results for that tab is provided below.

    > The `Zip` column is highlighted on the Data preview tab to show a sample of the values contained within that field. Below, you will filter the list of zip codes down to those that appear in the customer dataset.

    ![The Data preview tab is highlighted and selected. The Zip column is highlighted on the Data preview tab.](media/ex02-orchestrate-data-flow-sources-postal-codes-data-preview.png "Data flow canvas")

16. Before looking at the `PostalCodeFilter`, quickly select the `+` **(1)** button to the right of the `PostalCodes` data source to display a list of available transformations **(2)**.

    > Take a moment to browse the list of transformations available in Mapping Data Flows. From this list, you get an idea of the types of transformations possible using data flows. Transformations are broken down into three categories, **multiple inputs/outputs**, **schema modifiers**, and **row modifiers**. You can learn about each transformation in the docs by reading the [Mapping data flow transformation overview](https://docs.microsoft.com/azure/data-factory/data-flow-transformation-overview) article.

    ![The + button next to PostalCodes is highlighted, and the menu of available transformations is displayed.](media/ex02-orchestrate-data-flow-available-transformations.png "Data flow canvas")

17. Next, select the `PostalCodeFilter` transformation in the graph on the data flow canvas.

    ![The PostalCodeFilter transformation is highlighted on the data flow canvas graph.](media/ex02-orchestrate-data-flow-transformations-filter.png "Data flow canvas")

18. In the **Filter settings** tab of the configuration panel, click anywhere inside the **Filter on** box.

    ![The Filter on box is highlighted in the configuration panel for the PostalCodeFilter transformation.](media/ex02-orchestrate-data-flow-transformations-filter-on.png "Data flow canvas")

19. This will open the Visual expression builder.

    > In mapping data flows, many transformation properties are entered as expressions. These expressions are composed of column values, parameters, functions, operators, and literals that evaluate to a Spark data type at run time. To learn more, visit the [Build expressions in mapping data flow](https://docs.microsoft.com/azure/data-factory/concepts-data-flow-expression-builder) page in the documentation.

    ![The Visual expression builder is displayed.](media/ex02-orchestrate-data-flow-expression-builder.png "Visual expression builder")

20. The filter currently applied ensures all zip codes are between 00001 and 98000. Observe the different expression elements and values in the area below the expression box that help you create and modify filters and other expressions.

21. Select **Cancel** to close the visual expression builder.

22. Select the `DimCustomer` **(1)** data source on the data flow canvas graph.

    > Take a few minutes to review the various tabs in the configuration panel for this data source to better understand how it is configured, as you did above. Note that this data source relies on the `wwi_staging.DimCustomer_UniqueId` table from Azure Synapse Analytics for its data. `UniqueId` is supplied by a parameter to the data flow, which contains a substring of the Pipeline Run Id. Before running the pipeline, you will add a dependency to the Mapping Data Flow activity to ensure the Copy activity has populated the `wwi_staging.DimCustomer_UniqueId` in Azure Synapse Analytics before allowing the data flow to execute.

    ![The DimCustomer data source is highlighted on the data flow canvas graph.](media/ex02-orchestrate-data-flow-sources-dim-customer.png "Data flow canvas")

23. Next, select the `JoinOnPostalCode` **(1)** transformation and ensure the **Join settings** tab **(2)** is selected to see how you can join datasets using a simple and intuitive graphical interface.

    > The **Join settings** tab allows you to specify the data sources being joined and the join types and conditions. Notice the **Right stream** points to the `PostalCodeFilter` and not the `PostalCodes` data source directly. By referencing the filtered dataset, the join works with a smaller set of postal codes. For extensive datasets, this can provide performance benefits.

    ![The JoinOnPostalCode transformation is highlighted in the graph, and the Join settings tab is highlighted in the configuration panel.](media/ex02-orchestrate-data-flow-transformations-join.png "Data flow canvas")

24. Moving on to the next transformation, the `SelectDesiredColumns` transformation uses a **Select** schema modifier to allow choosing what columns to include.

    > You have probably noticed that the `SelectDesiredColumns` transformation appears twice in the graph. To enable writing the resulting dataset to two different sinks, Azure Synapse Analytics and Azure Data Lake Storage Gen2, a **Conditional split** multiple outputs transformation is required. This split is displayed in the graph as a repeat of the split item.

    ![The SelectDesiredColumns transformation is highlighted in the data flow graph.](media/ex02-orchestrate-data-flow-transformations-select.png "Data flow canvas")

25. The last two items in the data flow are the defined sinks. These provide the connection settings necessary to write the transformed data into the desired data sink. Select the `EnrichCustomerData` **(1)** sink and inspect the settings on the **Sink** tab **(2)**.

    ![The Sink tab is displayed for the EnrichCustomerData sink, which is highlighted in the graph.](media/ex02-orchestrate-data-flow-sink-sink.png "Data flow canvas")

26. Next, select the **Settings** tab and observe the properties set there.

    > The **Settings** tab defines how data is written into the target table in Azure Synapse Analytics. The Update method has been set only to allow inserts, and the table action is set to recreate the table whenever the data flow runs.

    ![The Settings tab is selected and highlighted in the configuration panel. On the tab, the Allow insert and Recreate table options are highlighted.](media/ex02-orchestrate-data-flow-sink-settings.png "Data flow canvas")

27. Now that you have taken the time to review the data flow, let us return to the pipeline. On the canvas, select the **Exercise 2 - Enrich Data** tab.

    ![The Exercise 2 - Enrich Data tab is highlighted on the canvas.](media/ex02-orchestrate-canvas-tabs-pipeline.png "Data pipeline canvas")

28. Before running the pipeline there is one more change we need to make. As mentioned above, the data flow depends on the data written by the copy activity, so you will add a dependency between the two activities.

29. In the data flow canvas graph, select the green box on the right-hand side of the **Copy data** activity and drag the resulting arrow up onto the **Mapping Data Flow** activity.

    ![The green box on the right-hand side of the Copy data activity is highlighted, and the arrow has been dragged onto the Mapping Data Flow.](media/ex02-orchestrate-pipelines-create-dependency.png "Data pipeline canvas")

30. This creates a requirement that the **Copy data** activity completes successfully before the **Mapping Data Flow** can execute and enforces our condition of the Synapse Analytics table being populated before running the data flow.

    ![The dependency arrow going from the Copy data activity to the Mapping Data Flow is displayed.](media/ex02-orchestrate-pipelines-create-dependency-complete.png "Data pipeline canvas")

31. The last step before running the pipeline is to publish the changes you have made. Select **Publish all** on the toolbar.

    ![The Publish all button is highlighted on the Synapse Studio toolbar.](media/ex02-orchestrate-pipelines-publish-all.png "Publish")

32. On the **Publish all** dialog, select **Publish**.

    > This Publish all dialog allows you to review the changes that will be saved.

33. Within a few seconds, you _may_ receive a notification that the publish is completed. If so, select **Dismiss** in the notification.

    ![The publishing completed notification is displayed.](media/ex02-publishing-completed.png "Publishing completed")

34. Your pipeline is now ready to run. Select **Add trigger (1)** then **Trigger now (2)** on the toolbar for the pipeline.

    ![Add trigger is highlighted on the pipeline toolbar, and Trigger now is highlighted in the fly-out menu.](media/ex02-orchestrate-pipelines-trigger-now.png "Trigger pipeline")

35. Select **OK** on the Pipeline run dialog to start the pipeline run.

    ![The OK button is highlighted in the Pipeline run dialog.](media/ex02-orchestrate-pipelines-trigger-run.png "Pipeline run trigger")

36. To monitor the pipeline run, move on to the next task.

## Task 3 - Monitor pipelines

After you finish building and debugging your data flow and its associated pipeline, you will want to monitor the execution of the pipeline and all of the activities contained within it, including the Data Flow activity. In this task, you review the [pipeline monitoring functionality in Azure Synapse Analytics](https://docs.microsoft.com/azure/data-factory/concepts-data-flow-monitoring) using the pipeline run you initiated at the end of the previous task.

1. In Synapse Studio, select **Monitor** from the left-hand menu.

   ![Monitor is selected and highlighted in the Synapse Analytics menu.](media/monitor-hub.png "Synapse Analytics menu")

2. Under Integration, select **Pipeline runs**.

   ![Pipeline runs is selected and highlighted under the Orchestration section of the monitor resource list.](media/ex02-monitor-pipeline-runs.png "Synapse Analytics Monitor")

3. Select the `Exercise 2 - Enrich Data_A03` pipeline the list. This will have a status of `In progress`.

   ![The first "Exercise 2 - Enrich Data" item in the list of pipeline runs is highlighted.](media/ex02-monitoring-pipeline-runs.png "Pipeline run list")

4. On the pipeline run details screen, you will see a graphical representation of the activities within the pipeline, as well as a list of the individual activity runs. Both provide status indicators for each activity.

   > This view allows you to monitor the overall status of the pipeline run, and observe each activity's status within the pipeline. The screen will auto-refresh for five minutes. If auto-refresh does not occur or your pipeline run takes longer than five minutes, you can get updates by selecting the Refresh button on the canvas toolbar.

   ![The pipeline run canvas is displayed, with activities list in the graph and in a list for in the Activity runs panel.](media/ex02-monitoring-pipeline-runs-details.png "Pipeline run details")

5. To get a better understanding of the types of information you can get from the monitoring capabilities, let us explore what information is available for each activity in the Activity runs list. Start by hovering your mouse cursor over the **Import Customer dimension** activity and select the **Output** icon that appears.

   ![The output icon is highlighted on the Import Customer dimension activity row.](media/ex02-monitoring-copy-activity-output.png "Copy activity output")

6. In the **Output** dialog, you will see details about the size of data read and written, the number of rows read and copied, the duration of the copy activity, and other information relating to the copy activity run. This information can be used for things like troubleshooting. For example, you could compare the copy run to data, such as the number of rows read and written, to expected numbers from the source and sink.

   ![The Output dialog for the Import Customer dimension activity is displayed.](media/ex02-monitoring-copy-activity-output-details.png "Copy activity output")

7. Close the Output dialog.

8. Next, hover your mouse cursor over the **Import Customer dimension** activity again, this time selecting the **Details** icon that appears.

   ![The Details icon is highlighted on the Import Customer dimension activity row.](media/ex02-monitoring-copy-activity.png "Copy activity run")

9. The **Details** dialog provides the data found on the Output dialog examine above but expands on that to include graphics for the source, staging storage, and sink, and a more detailed look at the activity run.

   ![The Details dialog for the copy activity is displayed.](media/ex02-monitoring-copy-activity-details.png "Copy activity details")

10. Close the Details dialog.

11. When the pipeline execution completes, all activity runs will reflect a status of Succeeded.

    ![A screenshot of the activity runs for the Exercise 2 - Enrich Data pipeline is displayed with all activities showing a status of Succeeded.](media/ex02-monitor-ex2-enrich-data-activity-runs-succeeded.png "Pipeline run monitoring")

12. When the **Enrich Customer Data** activity has a status of **Complete**, hover your mouse cursor over the **Enrich Customer Data** activity and select the **Details** icon that appears.

    > **Note**: It can take 5-7 minutes for the **Enrich Customer Data** activity to complete. You may need to select **Refresh** on the Monitoring toolbar to see the status update if your pipeline run takes longer than five minutes.

    ![The Details icon is highlighted on the Enrich Customer Data Mapping Data Flow activity row.](media/ex02-monitoring-data-flow.png "Data flow activity")

13. The Details dialog for data flow details takes you to a full-screen view of your data flow.

    > The initial view provides a details panel containing statistics for the sinks defined within the data flow. The information for these includes the number of rows written and the processing times for writing to each sink.

    ![The data flow Details dialog is displayed.](media/ex02-monitoring-data-flow-details.png "Data Flow activity details")

14. Select the **SelectDesiredColumns** transformation step of the data flow.

    > Selecting any component of the data flow opens a new panel with details about the processing that occurred for that component.

    ![The SelectDesiredColumns transformation step is highlighted in the graph on the details dialog.](media/ex02-monitoring-data-flow-select.png "Data Flow activity details")

15. Try selecting another component, such as the **EnrichCustomerData** sink, and view the information available.

    ![The EnrichCustomerData sink component is highlighted in the graph, and the associated details panel is displayed on the right-hand side of the screen.](media/ex02-monitoring-data-flow-sink.png "Data Flow activity details")

16. Close the data flow activity Details dialog by selecting the **X** on the right-hand side of the toolbar.

    ![The X (close) button is highlighted on the data flow Details dialog toolbar.](media/ex02-monitor-data-flow-close.png "Data flow details")

17. Back on Exercise 2 - Enrich Data pipeline run screen, switch to the Gantt view. This view provides a graphical representation of the run times of the various activities within the pipeline.

    ![The Gantt view option is selected and highlighted on the pipeline run dialog.](media/ex02-monitoring-ex2-enrich-data-activity-runs-gantt.png "Pipeline run Gantt view")

## Task 4 - Monitor Spark applications

In this task, you examine the Apache Spark application monitoring capabilities built into Azure Synapse Analytics. The Spark application monitoring screens provide a view into the logs for the Spark application, including a graphical view of those logs.

1. As you did in the previous task, select **Monitor** from the left-hand menu.

   ![Monitor is selected and highlighted in the Synapse Analytics menu.](media/monitor-hub.png "Synapse Analytics menu")

2. Next, select **Apache Spark applications** under Activities.

   ![Apache Spark applications is selected and highlighted under the Activities section of the monitor resource list.](media/ex02-monitor-activities-spark.png "Synapse Analytics Monitor")

3. On the Apache Spark applications page, select the **Submit time** value and observe the available options for limiting the time range for Spark applications that are displayed in the list. In this case, you are looking at the current run, so ensure **Last 24 hours** is selected and then select **OK**.

   ![Last 24 hours is selected and highlighted in the Time range list.](media/ex02-monitor-activities-spark-time-range.png "Synapse Analytics Monitor")

4. From the list of Spark applications, select the first job, which should have a status of `In progress` or `Succeeded`.

   > **Note**: You may see a status of `Cancelled`, and this does not prevent you from completing the following steps. Azure Synapse Analytics is still in preview, and the status gets set to `Cancelled` when the Spark pool used to run the Spark application times out.

   ![The current Spark application is highlighted in the applications list.](media/ex02-monitor-activities-spark-application-list.png "Synapse Analytics Monitor")

5. On the **Dataflow** screen, you will see a detailed view of the job, broken into three different sections.

   - The first section is a graphical representation of the stages that make up the Spark application.
   - The second section is a summary of the Spark application.
   - The third section displays the diagnostics and logs associated with the Spark application.

   ![A screenshot of the Log query screen is displayed.](media/ex02-monitor-activities-spark-application-dataflow.png "Synapse Analytics Monitor")

6. Select the **Logs** tab to view the log output. You may switch between log sources and types using the dropdown lists below.

    ![The Spark application logs are displayed.](media/ex02-monitor-activities-spark-application-logs.png "Logs")

7. Selecting any individual stage from the graph opens a new browser window showing the selected stage in the Spark UI, where you can dive deeper into the tasks that make up each stage. Select **View details** underneath one of the stages.

    ![The view details link is highlighted.](media/ex02-monitor-activities-spark-application-logs-view-details.png "View details")

8. Observe the information displayed in Spark UI.

    ![Details for Stage 3 are displayed in the Spark UI.](media/ex02-monitor-activities-spark-application-stage-3-spark-ui.png "Spark UI")

9. Return to the Synapse Analytics Monitoring page for your Spark application.

10. To look closer at any individual stage, you can use the **Job IDs** drop-down to select the stage number.

    ![Stage 3 is highlighted in the Job IDs drop-down list.](media/ex02-monitor-activities-spark-applications-all-job-ids-3.png "Synapse Analytics Monitor")

11. This view isolates the specific stage within the graphical view.

    ![Stage 3 is displayed.](media/ex05-monitor-activities-spark-applications-stage-3.png "Synapse Analytics Monitor")

12. Return the view to all stages by selecting **All job IDs** in the job ID drop-down list.

    ![All job IDs is highlighted in the Job IDs drop-down list.](media/ex02-monitor-activities-spark-applications-all-job-ids.png "Synapse Analytics Monitor")

13. Within the graph section, you also have the ability to **Playback** the Spark application.

    ![The Playback button is highlighted.](media/ex02-monitor-activities-spark-applications-playback.png "Synapse Analytics Monitor")

    > **Note**: Playback functionality is not available until the job status changes out of the `In progress` status. The job's status will remain listed as `In progress` until the underlying Spark resources are cleaned up by Azure Synapse Analytics, which can take some time.

14. Running a Playback allows you to observe the time required to complete each stage, as well as review the rows read or written as the job progresses.

    ![A screenshot of an in-progress playback is displayed. The playback is at 1m 49s into the Spark application run, and Stage 6 is showing a Stage progress of 6.25%.](media/ex02-monitor-activities-spark-applications-playback-progress.png "Synapse Analytics Monitor")

15. You can also perform playback on an individual stage. Returning to a view of only Stage 3, the **Playback** button shows the rows written at this stage, and the progress of reads and writes.

    ![A screenshot of an in-progress playback for Stage 3 is displayed.](media/ex02-monitor-activities-spark-applications-playback-stage-3.png "Synapse Analytics Monitor")

16. You can also change the view to see which stages involved read and write activities. Select **All job IDs** in the job dropdown, and in the **View** drop-down, select **Read**. You can see which stages performed reads, with each color-coded by how much data was read.

    ![Read is selected and highlighted in the Display drop-down list.](media/ex02-monitor-activities-spark-applications-display-drop-down-read-graph.png "Synapse Analytics Monitor")

<br/><br/>
# Exercise 3 - Power BI integration

In this exercise, you will realize another benefit of the fully integrated environment provided by Azure Synapse Analytics. Here, you will create a Power BI Report and build a visualization within Synapse Analytics Studio. Once you have published a dataset, you will not have to leave this environment to log into a separate Power BI website to view and edit reports.

The Power BI Workspace has already been created for you.

The tasks you will perform in this exercise are:

- Exercise 3 - Power BI integration
  - Task 1 - Create a Power BI dataset in Synapse
  - Task 2 - Create a Power BI report in Synapse

---

**Important**:

In the tasks below, you will be asked to enter a unique identifier in several places. You can find your unique identifier by looking at the username you were provided for logging into the Azure portal. Your username is in the format `odl_user_UNIQUEID@msazurelabs.onmicrosoft.com`, where the _UNIQUEID_ component looks like `206184`, `206137`, or `205349`, as examples.

Please locate this value and note it for the steps below.

---

## Task 1 - Create a Power BI dataset in Synapse

In this task, you will use Power BI Desktop to create the dataset used by the report.

> Note: Power BI desktop will already be installed in the virtual machine provided with the lab.

1. Open Synapse Analytics Studio, and then navigate to the `Develop hub`.

   ![Develop hub.](media/develop-hub.png "Develop hub")

2. Expand **Power BI**, expand the first node under it, and then select **Power BI datasets**.

   ![Selecting Power BI datasets in the Develop panel](media/ex03-pbi-menu.png "Select Power BI datasets")

   > The second node, named `PowerBIWorkspace<UniqueId>`, is the Power BI workspace added to your Synapse workspace as a linked service.

3. Select **New Power BI dataset** within the panel that appears.

   ![New Power BI dataset](media/ex03-new-pbi-dataset.png "Select New Power BI dataset")

4. In the panel that appears, if a prompt appears to Install Power BI Desktop, select **Start**.

   ![Select Start in the first screen of wizard](media/ex03-pbids-install-pbidesktop.png "Select Start")

5. In the step by step dialog that appears, select `SQLPool01` and then select **Continue**.

   ![The SQLPool01 data source is selected.](media/ex03-pbid-select-data-source.png "Select a data source")

6. Select **Download** to download and save the suggested `pbids` file.

   ![Selecting Download](media/ex03-download-pbid.png "Download file")

7. Open the downloaded .pbids file. This will launch Power BI desktop.

8. When Power BI Desktop loads, select **Microsoft account**, then select **Sign in**. Follow the login prompts to login with the credential provided to you. When you return to the SQL Server database dialog, select **Connect**.

   ![Signing in with a Microsoft account](media/ex03-login-pbi.png "Sign in")

9. In the Navigator dialog, within the list of tables select **wwi.FactSale**, confirm the preview shows some data, and then select **Load**.

   ![Selecting the wwi.FactSale table and viewing the preview](media/ex03-load-table-pbi.png "Select table")

10. When prompted, set the query type to **Direct Query** and select **OK**.

    ![Selecting the wwi.FactSale table and viewing the preview](media/ex03-pbi-directquery.png "Set query type")

11. From the **File** menu, select **Publish** and then select **Publish to Power BI**. If prompted to save your changes, select Save and provide `wwifactsales` as the name. This will also be the name used for the dataset. You may be prompted to login a second time. Follow the login prompts to login with the credentials provided to you.

    ![Selecting Publish to Power BI from the File menu](media/ex03-publish-menu.png "Publish to Power BI")

12. In the dialog that appears, select the provided Power BI workspace (the first one that appears under the `Power BI` section in the `Develop` hub). Do not select the item labeled My workspace. Choose **Select**.

    ![Selecting the correct Power BI workspace](media/ex03-select-workspace.png "Select workspace")

13. Wait until the publishing dialog shows a status of **Success**, then click **Got it** to close the dialog.

    ![The publishing succeeded.](media/ex03-publishing-succeeded.png "Publishing to Power BI")

14. Return to your browser where you have Azure Synapse Studio open. Select **Close and refresh** in the New Power BI dataset dialog that should still be open.

    ![Closing the wizard dialog](media/ex03-close-and-refresh-pbids.png "Close the wizard")

15. You should see your new Power BI dataset appear in the listing on the Power BI datasets panel. If not, select **Refresh**.

    ![Viewing the dataset listing](media/ex03-view-new-dataset.png "Browse datasets")

## Task 2 - Create a Power BI report in Synapse

In this task, you will learn how to use a collaborative approach to create a new Power BI report within Synapse Analytics Studio. To do this, you will use a dataset that was not created by you.

1. Select the `wwifactsales` dataset within the panel that appears. When you hover over the dataset, a button for creating a new Power BI report will appear. Select that button.

   ![Selecting new Power BI report from dataset](media/ex03-select-new-power-bi-report.png "Select dataset")

2. This will launch a new tabbed document with the Power BI report designer. Also note, that your new report appears under the Power BI reports folder in the `Develop` hub.

   ![Viewing the new Power BI report](media/ex03-new-report-document.png "View report")

---

**Important**:

If you do not see a list of data fields under Fields, follow the steps below for a fix.

1. Navigate to [www.powerbi.com](https://www.powerbi.com) on a new browser tab. Select **Sign In** and use the credential provided to you.

2. Select `Workspaces` from the left menu and select the `PowerBIWorkspace` as shown in the screenshot.

   ![Selecting the right workspace to work on](media/ex03-selecting-workspace.png "Selecting the right workspace to work on")

3. Navigate to **Settings**, then select **Settings** from the menu.

   ![The Settings menu is displayed.](media/pbi-settings.png "Settings")

4. Select the **Datasets** tab. From the list of datasets select `wwifactsales`, then select **Edit credentials** underneath the **Data Source credentials** section.

   ![Changing settings for the wwifactsales dataset](media/ex03-setting-dataset-credentials.png "Changing settings for the wwifactsales dataset")

5. Under **Authentication Method** select `OAuth2` and select **Sign In**.

   ![Selecting the right workspace to work on](media/ex03-enter-dataset-credentials.png "Selecting the right workspace to work on")

6. Navigate back to your Synapse workspace in the previous tab and select the **refresh** button above the Fields list in the Power BI report. After a few seconds, you should see the list of fields below. Alternatively, you may refresh your browser window.

   ![The refresh button above the fields list is highlighted.](media/ex03-pbi-refresh.png "Refresh")

7. Within the Power BI Designer, select **Line and clustered column chart** under Visualizations.

   ![The visualization is highlighted.](media/ex03-pbi-line-clustered-column-chart-vis.png "Line and clustered column chart")

8. Drag the **SalespersonKey** field into **Shared axis** for the visualization. Then drag the **TotalExcludingTax** field into **Column values**. Finally, drag the **Profit** field into **Line values**.

   ![The field values are displayed as described above.](media/ex03-visualization-fields.png "Visualization fields")

9. Resize the line and clustered column chart visualization to fit the report area. Your visualization should look like the following:

   ![The visualization is highlighted on the report canvas.](media/ex03-pbi-visualization-no-filter.png "Completed visualization")

10. Under the **Filters** pane, expand the **Profit** filter **(1)**. Select **is greater than** under `Show items when the value:` **(2)**, then enter **50000000** for the value. Select **Apply filter (3)**.

    ![The filter is configured as described above.](media/ex03-pbi-apply-filter.png "Profit filter")

11. After a few seconds, you should see the visualization change based on the filter. In this case, we narrow down the results to only those where the total profit amount is greater than $50 million. Since we are using Direct Query, Power BI pushed down the filter to the dedicated SQL pool (SQLPool01) to execute a new query based on the filter parameters. The pool sent back the results to Power BI to re-render the chart. Since we are dealing with a vast number of records (over 12 million), harnessing the dedicated SQL pool's power to aggregate and filter the data rather than importing them and using the Power BI engine to do the work is much more efficient.

    ![The filtered visualization is displayed.](media/ex03-pbi-filtered-visualization.png "Filtered visualization")

12. From the file menu within the designer, select **Save As**.

    ![Selecting Save As from the File menu](media/ex03-file-save-as.png "Save As")

13. In the dialog that appears, enter **Key Sales by Person** for the name, then select **Save**.

    ![The save dialog is displayed.](media/ex03-pbi-save-report.png "Save your report")

14. This report is now available to all authorized users within Synapse Analytics Studio and the Power BI workspace.

## Task 3 - View the SQL query

1. Navigate to the **Monitor** hub.

   ![Monitor hub.](media/monitor-hub.png "Monitor hub")

2. Select **SQL requests** in the left-hand menu **(1)**, then select **SQLPool01** under the Pool filter **(2)**. Look at the list of recent queries executed by your lab username as the Submitter. Hover over one of these queries to see the **Request content** button next to the `SQL request ID` value **(3)** to view the executed query.

   ![The list of SQL requests is displayed.](media/ex03-sql-requests.png "SQL requests")

3. View the queries' request content until you find one that contains the SQL SELECT statement executed by your filter in the Power BI report. Here you can see the `Profit` and `TotalExcludingTax` fields have the SUM aggregate, and the `wwi.FactSale` table is grouped by `SalespersonKey`. A WHERE clause filters the rows by `Profit` (aliased as `a0`) where the value is greater than or equal to `50000000` ($50 million). Power BI generated the SQL script, then used the dedicated SQL pool to execute the query and send back the results.

   ![The SQL query is displayed as described above.](media/ex03-pbi-sql-statement.png "Request content")

<br/><br/>
# Exercise 4 - High-Performance Analysis with Azure Synapse Dedicated SQL Pools

In this exercise, you will use several of the capabilities associated with dedicated SQL Pools to analyze the data.

SQL data warehouses have been for a long time the centers of gravity in data platforms. Modern data warehouses can provide high performance, distributed, and governed workloads, regardless of the data volumes at hand.

The dedicated SQL pool in Azure Synapse is the new incarnation of the former Azure SQL Data Warehouse. It provides all the modern SQL data warehousing features while benefiting from the advanced integration with all the other Synapse services.

The tasks you will perform in this exercise are:

- Exercise 4 - High-Performance Analysis with Azure Synapse Dedicated SQL Pools
  - Task 1 - Use a dedicated SQL pool query to understand a dataset
  - Task 2 - Investigate query performance and table design
    - Bonus Challenge

> **Note**: The tasks in this exercise must be run against the dedicated SQL pool (as opposed to the ones from exercise 1, which were run against the serverless SQL pool
named "built-in" pool). Make sure you have `SQLPool01` selected before running each query:

![Run queries against a dedicated SQL pool](./media/ex04-run-on-sql-pool.png)

## Task 1 - Use a SQL Synapse Pool query to understand a dataset

In this task, you will try to understand who your best customers are.

**Challenge:** Can you author and run a query that will aggregate the total quantity of items purchased by the customer and then visualize the result with a chart similar to the following?

![Example Chart](media/ex05-chart-sample.png "Example chart")

**Solution:**

1. Open Synapse Analytics Studio, and then navigate to the `Develop` hub.
2. Under `SQL scripts`, select the script called `Ex 4 Task 1 - Analyze Transactions.sql`.
3. Change the **Connect to** drop-down to the **SQLPool01** database.
4. Select **Run** to execute the script against the SQL Pool database.
5. When the results appear, for the **View** toggle, select **Chart**.
6. For the Chart type, select `Column`.
7. For the Category column, leave the selection at `(none)`.
8. For the Legend (series) column, select `CustomerKey`.

    [Refer here](Artifacts/SQL%20Files/Ex%204%20Task%201%20-%20Analyze%20Transactions.sql)

![Example Chart](media/ex05-chart.png "Example chart")

## Task 2 - Investigate query performance and table design

In this task, you will try to understand the implications of the table design at a general level. You will run the same set of queries against two fact tables (`FactSale_Fast` and `FactSale_Slow`). The two fact tables have (with one notable exception) the same structure and contain identical data.

First, let us set the stage by performing the following steps:

1. Under **SQL Scripts** in the `Develop` hub within Synapse Analytics Studio, select the script called `Ex 4 Task 2 - Investigate query performance`.
2. Change the **Connect to** drop-down to the **SQLPool01** database.
3. Select line 1 and then select `Run`.

   ![Run a count on FactSale_Slow](./media/ex04-query-selection-01.png "Run script")

   Notice the quick response time (usually under 3 seconds) and the result - 83.4 million records. If SQLPool was configured with DW500c, then it would be under 1 second.

4. Select line 3 and then select `Run`.

   ![Run a count on FactSale_Fast](./media/ex04-query-selection-02.png "Run script")

  Notice the quick response time (usually under 3 seconds) and the result - 83.4 million records. If SQLPool was configured with DW500c, then it would be under 1 second.

5. Select lines 5 to 20 and then select `Run`.

   ![Run a complex query on FactSale_Slow](./media/ex04-query-selection-03.png "Run script")

   Re-run the query 3 to 5 times until the execution time stabilizes (usually, the first "cold" execution takes longer than subsequent ones who benefit from the initialization of various internal data and communications buffers). Make a note of the amount of time needed to run the query (typically 15 to 30 seconds).

6. Select lines 22 to 37 and then select `Run`.

   ![Run a complex query on FactSale_Fast](./media/ex04-query-selection-04.png "Run script")

   Re-run the query 3 to 5 times until the execution time stabilizes (usually, the first "cold" execution takes longer than subsequent ones who benefit from the initialization of various internal data and communications buffers). Make a note on the amount of time needed to run the query (typically 3 to 5 seconds).

   [Refer here](Artifacts/SQL%20Files/Ex%204%20Task%202%20-%20Investigate%20query%20performance.sql)


## Bonus Challenge

Can you explain the significant difference in performance between the two seemingly identical tables? Furthermore, can you explain why the first set of queries (the simple counts) were not that further apart in execution times?

**Solution:**

1. In Synapse Analytics Studio, navigate to the `Data` hub.
2. Under Databases, expand the `SQLPool01` node, expand `Tables`, and locate the `wwi_perf.FactSale_Slow` table.
3. Right-click the table **(1)** and then select `New SQL script` **(2)**, `CREATE` **(3)**.

   ![View table structure](./media/ex04-view-table-definition.png "Table structure")

4. In the CREATE script, note the `DISTRIBUTION = ROUND_ROBIN` option used to distribute the table.

   ![View Round-Robin Distribution](./media/ex04-view-round-robin.png "Round-Robin Distribution")

5. Repeat the same actions for the `wwi_perf.FactSale_Fast` table and note the `DISTRIBUTION = HASH ( [CustomerKey] )` option used to distribute the table.

   ![View Hash Distribution](./media/ex04-view-hash-distribution.png "Hash Distribution")
 
This is the critical difference that has such a significant impact on the last two queries' performance. Because `wwi_perf.FactSale_Slow` is distributed in a round-robin fashion, each customer's data will end up living in multiple (if not all) distributions. When our query needs to consolidate each customer's data, a lot of data movement will occur between the distributions. This is what slows down the query significantly.

On the other hand, `wwi_perf.FactSale_Fast` is distributed using the hash of the customer identifier. This means that each customer's data will end up living in a single distribution. When the query needs to consolidate each customer's data, virtually no data movement occurs between distributions, which makes the query very fast.

> By default, tables are Round Robin-distributed, enabling users to create new tables without deciding on the distribution. In some workloads, Round Robin tables have acceptable performance. However, in many cases, selecting a distribution column will perform much better.
>
> A round-robin distributed table distributes table rows evenly across all distributions. The assignment of rows to distributions is random. Unlike hash-distributed tables, rows with equal values are not guaranteed to be assigned to the same distribution. As a result, the system sometimes needs to invoke a data movement operation to better organize your data before resolving a query. This extra step can slow down your queries. For example, joining a round-robin table usually requires reshuffling the rows, which is a performance hit.

Finally, the first two queries (the counts) were not that far apart performance-wise because none of them incurred any data movement (each distribution just reported its local counts, and then the results were aggregated).

This simple example demonstrates one of the core challenges of modern, massively distributed data platforms - solid design. You witnessed first-hand how one decision taken at table design time can significantly influence the performance of queries. You also got a glimpse of Azure Synapse Analytics' raw power: the more efficient table design enabled a non-trivial query involving more than 80 million records to execute in just a few seconds.
<br/><br/>
# Exercise 5 - Data Science with Azure Synapse Spark (optional)

Azure Synapse Analytics provides support for using trained models (in ONNX format) directly from dedicated SQL pools. What this means in practice, is that your data engineers can write T-SQL queries that use those models to make predictions against tabular data stored in a SQL Pool database table.

In this exercise, you will leverage a previously trained model to make predictions using the T-SQL `Predict` statement.

For context, the following are the high-level steps taken to create a Spark ML based model and deploy it, so it is ready for use from T-SQL.

![The process for registering and using a model](media/ex05-model-registration-process.png "Review model registration process")

The steps are performed using a combination of Azure Databricks and Azure Synapse Analytics workspaces:

- Within a Databricks notebook, a data scientist will:

  a. Train a model using Spark ML; the machine learning library included with Apache Spark. Models can also be trained using other approaches, including by using Azure Machine Learning automated ML. The main requirement is that the model format must be supported by ONNX.

  b. Convert the model to the ONNX format using the `onnxml` tools.

  c. Save a hexadecimal encoded version of the ONNX model to a table in the SQL Pool database.

- To use the model for making predictions in Synapse Analytics, in a SQL Script, a data engineer will:

  a. Read the model into a binary variable by querying it from the table in which it was stored.

  b. Execute a query using the `FROM PREDICT` statement as you would a table. This statement defines both the model to use and the query to execute that will provide the data used for prediction. You can then take these predictions and insert them into a table for use by downstream analytics applications.

> What is ONNX? [ONNX](https://onnx.ai/) is an acronym for the Open Neural Network eXchange and is an open format built to represent machine learning models, regardless of what frameworks were used to create the model. This enables model portability, as models in the ONNX format can be run using a wide variety of frameworks, tools, runtimes, and platforms. Think of it as a universal file format for machine learning models.

In this exercise, the tasks you will perform are:

- Exercise 5 - Data Science with Spark
  - Task 1 - Prepare a machine learning model
  - Task 2 - Making predictions with a trained model
  - Task 3 - Examining the model training and registration process (Optional)

## Task 1 - Prepare a machine learning model

Prepare the `models` container in `BlobStorage` by creating two folders: `onnx` and `hex`.

To prepare the machine learning model for Exercise 5, you have two options:

- Use the already trained and converted machine learning model (available as a starter artifact)
- Train and convert a new machine learning model

### Import the already trained and converted machine learning model

1. Upload the [model.onnx.hex](Artifacts/ml/model.onnx.hex) file to the `hex` folder in the `models` container of `BlobStorage`.

2. Run the `Ex 5 Task 1_1 - Create sample Data for Predict` SQL script to create sample data for machine learning predictions.

3. Run the `Ex 5 Task 1_2 - Register model` SQL script to register the model with the `SQLPool01` SQL pool.

### Train and convert a new machine learning model

1. Run the `Ex 5 Task 3 - Model Training` Spark notebook to train the machine learning model and save it in ONNX format. The model will be saved as `model.onnx` in the `onnx` folder in the `models` container of `BlobStorage`.

2. Use the [convertion PowerShell script](Artifacts/ml/convert-to-hex.ps1) to transform `model.onnx` into `model.onnx.hex`.

3. Perform steps 1, 2, and 3 described in the previous section.


## Task 2 - Making predictions with a trained model

In this task, you will author a T-SQL query that uses a pre-trained model to make predictions.

1. Open Synapse Analytics Studio, and then navigate to the `Data` hub.

2. Expand the Databases listing, right-click your dedicated SQL Pool and then select `New SQL Script`, and then `Empty script`.

   ![Showing the context menu, selecting New SQL Script, Empty Script](media/ex05-new-sql-script.png "Create new script")

3. Replace the contents of this script with following:

   ```sql
   -- Retrieve the latest hex encoded ONNX model from the table
   DECLARE @model varbinary(max) = (SELECT Model FROM [wwi_ml].[MLModel] WHERE Id = (SELECT Top(1) max(ID) FROM [wwi_ml].[MLModel]));

   -- Run a prediction query
   SELECT d.*, p.*
   FROM PREDICT(MODEL = @model, DATA = [wwi].[SampleData] AS d, RUNTIME = ONNX) WITH (prediction real) AS p;
   ```

4. Select **Run** from the menubar.

   ![The Run button](media/ex05-select-run.png "Select Run")

5. View the results, notice that the `Prediction` column is the model's prediction of how many items of the kind represented by `StockItemKey` that the customer identified by `CustomerKey` will purchase.

    [Refer here](Artifacts/SQL%20Files/Ex%205%20Task%202%20-%20Predict%20with%20model.sql)


   ![Viewing the prediction results in the query result pane](media/ex05-view-prediction-results.png "View prediction results")

## Task 3 - Examining the model training and registration process (Optional)

You can see the notebook and SQL scripts that were used to train and register this model if you are curious. To do so, follow these steps:

1. Open the Azure Databricks workspace, and then navigate to the `Workspace` section.

2. Under **Shared**, select the notebook called `Exercise 5 - Model Training`.

3. This notebook handles training the model, converting the model to ONNX, and uploading the ONNX model to Azure Storage.

4. Execute the notebook to get the trained Machine Learning model in ONNX format.

5. One step that is not shown by the notebook is an offline step that converts the ONNX model to hexadecimal. The resulting hex-encoded model is also uploaded to Azure Storage. This conversion is currently performed with [this PowerShell script](Artifacts/ml/convert-to-hex.ps1), but could be automated using any scripting platform.

6. Once you have read through the notebook, return to the `Develop` hub, expand **SQL scripts** and select `Ex 5 Task 1_2 - Register model`. View, but **do not run this script**.

7. This script uses PolyBase to load the hex-encoded model from Azure Storage into a table within the SQL Pool database. Once the model is inserted into the table in this way, it is available for use by the Predict statement as was shown in Task 1.
