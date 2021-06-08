# Azure Synapse + Power BI Extension Module &nbsp;
&nbsp;
&nbsp;
&nbsp;


# Exercise 6 - Develop a Power BI Model


In this exercise, you are working in the role of a **data architect** or **BI developer**.
You will use Power BI Desktop to develop a data model over your Azure Synapse Wide World Importers (WWI) data warehouse. The data model will allow you to publish a semantic layer over the data warehouse. Comprising six tables, it will define relationships, hierarchies, calculations, and friendly and consistent names. The data model will become an intuitive and high performance source for Power BI reports.

---

**Important**: 

You must use the lab Azure credentials to connect to Azure Synapse and to publish content to Power BI.

---

## **Task 1: Create the Model**

In this exercise, you will create a DirectQuery model to support Power BI analysis and reporting of the data warehouse sale subject.

### **Subtask 1: Prepare Your Environment**

In this task, you will prepare your environment.

1. Open Power BI Desktop.

2. At the top-right corner, verify that you are signed in using the lab Azure credentials.

3. If you are not signed in using the lab Azure credentials, you must now sign in with those credentials.

4. Close Power BI Desktop.

5. Open a new web browser session, and then navigate to *https://powerbi.com*.

6. If you are not signed in automatically, click **Sign In**, and then sign in using the lab Azure credentials.

### **Subtask 2: Download a Dataset File**

In this task, you will download a Power BI data source file from Synapse Studio.

1. In the Azure Synapse web browser session (opened in your previous exercise), navigate to **Synapse Studio**.

2. At the left, select the **Develop** hub.

   ![ws name.](media/6.6.png)

3. In the **Develop** pane, expand the **Power BI** group, and then select **Power BI Datasets**.

   ![ws name.](media/6.7.png)

4. In the **Power BI Datasets** pane, click **New Power BI Dataset**.

   ![ws name.](media/6.8.png)

5. Click **Start**.

6. Select your SQL pool, and then click **Continue**.

7. Click the link to **download** the .pbids file.

    *A .pbids file contains a connection to your SQL pool. It’s a convenient way to start your project. When opened, it’ll create a new Power BI Desktop solution that already stores the connection details to your SQL pool*.

8. When the .pbids file has downloaded, open it.

    *When the file opens, it’ll prompt you to create queries using the connection. You’ll define those queries in the next task*.

### **Subtask 3: Create Model Queries**

In this task, you will create six Power Query queries that will each load as a table to your model.

   *Power Query is a Microsoft technology used to connect to data stores, profile data, and transform data. You’ll define query for each table your model.*

1. In Power BI Desktop, in the **SQL Server Database** window, at the left, select **Microsoft Account**.

   ![ws name.](media/3.1.png)

2. Click **Sign In**.

3. Sign in using the lab Azure credentials.

4. Click **Connect**.

   ![ws name.](media/3.4.png)

5. In Power BI Desktop, in the **Navigator** window, select (don’t check) the **wwi.DimCity** table.

6. In the right pane, notice the preview result, which shows a subset of the table rows.

7. To create queries (which will become model tables), check the following six tables:

   - wwi.DimCity
   - wwi.DimCustomer
   - wwi.DimDate
   - wwi.DimEmployee
   - wwi.DimStockItem
   - wwi.FactSale

   ![ws name.](media/6.12.png)

8. To apply transformations to the queries, at the bottom-right, click **Transform Data**.

   ![ws name.](media/6.13.png)

   *Transforming the data allows you to define what data will be available in your model.*

9. In the **Connection Settings** window, select the **DirectQuery** option.

   ![ws name.](media/6.14.png)

   *This decision is important. DirectQuery is a storage mode. A model table that uses DirectQuery storage mode doesn’t store data. So, when a Power BI report visual queries a DirectQuery table, Power BI sends a native query to the data source. This storage mode is often used for large data stores like Azure Synapse Analytics (because it’s impractical or uneconomic to import large data volumes) or when near real-time results are required.*

10. Click **OK**.

    ![ws name.](media/6.15.png)

11. In the **Power Query Editor** window, in the **Queries** pane (located at the left), notice there is one query for each table you requested.

    ![ws name.](media/6.16.png)

   *You’ll now revise the definition of each query. Each query will become a model table when they are applied to the model. So, you’ll now rename them so they’re described in more friendly and concise ways, and apply transformations to deliver the columns required by reports.*

12. Select the **wwi DimCity** query.

    ![ws name.](media/6.17.png)   

13. In the **Query Settings** pane (located at the right), to rename the query, in the **Name** box, replace the text with **Geography**, and then press **Enter**.

    ![ws name.](media/6.18.png)

14. On the **Home** ribbon tab, from inside the **Manage Columns** group, click the **Choose Columns** icon.

    ![ws name.](media/6.19.png)

15. In the **Choose Columns** window, to uncheck all checkboxes, uncheck the first checkbox.

    ![ws name.](media/6.20.png)

16. Check the following seven columns.

	- CityKey
	- City
	- StateProvince
	- Country
	- SalesTerritory
	- Region
	- Subregion

	![ws name.](media/6.21.png)

	*This selection of columns determine what will be available in your model.*

17. Click **OK**.

    ![ws name.](media/6.22.png)

18. In the **Query Settings** pane, in the **Applied Steps** list, notice that a step was added to remove other columns.

    ![ws name.](media/6.23.png)

    *Power Query defines steps to achieve the desired structure and data. Each transformation is a step in the query logic.*

19. To rename the **StateProvince** column, double-click the **StateProvince** column header.

20. Insert a hyphen character (-) between the word **State** and the word **Province**, and then press **Enter**.

    ![ws name.](media/6.24.png)

21. Notice that a new applied step is added to the query.

    ![ws name.](media/6.25.png)

22. Rename the **SalesTerritory** column as **Sales Territory** (insert a space between the two words).

23. To validate the query design, in the status bar (located along the bottom of the window), verify that the query has seven columns.

    ![ws name.](media/6.26.png)

    *Important: If the query design does not match, review the lab steps to make any corrections.*

    *The design of the **Geography** query is now complete.*

24. In the **Applied Steps** pane, right-click the last step, and then select **View Native Query**.

    ![ws name.](media/6.27.png)

25. In the **Native Query** window, review the SELECT statement that reflects the query design.

    *This concept is important. A native query is what Power BI uses to query the data source. To ensure best performance, the database developer should ensure this query is optimized by creating appropriate indexes, etc.*

26. To close the **Native Query** window, click **OK**.

    ![ws name.](media/6.28.png)

27. Select the **wwi DimCustomer** query.

    ![ws name.](media/6.29.png)

28. Rename the query as **Customer**.

29. Remove all columns, except:

	- CustomerKey
	- Customer
	- Category
	- BuyingGroup
   
	![ws name.](media/6.30.png)

30. Rename the **BuyingGroup** column as **Buying Group** (insert a space between the two words).

31. Verify that the query has four columns.

   *The design of the **Customer** query is now complete.*
 
32. Select the **wwi DimDate** query.

    ![ws name.](media/6.31.png)

33. Rename the query as **Date**.
 
34. Remove all columns, except:

	- Date
	- CalendarMonthNumber
	- CalendarMonthLabel
	- CalendarYear
	- CalendarYearLabel

	![ws name.](media/6.32.png)

35. Rename the following columns:

	- **CalendarMonthLabel** as **Month**
	- **CalendarYearLabel** as **Year**
 
36. To add a computed column, on the **Add Column** ribbon tab, from inside the **General** group, click **Custom Column**.

    ![ws name.](media/6.33.png)

37. In the **Custom Column** window, in the **New Column Name** box, replace the text with **MonthKey**.
    
    ![ws name.](media/6.34.png)

38. In the Custom Column Formula box, enter the following formula:

    ```
    ([CalendarYear] * 100) +[CalendarMonthNumber]
    
    ```
    
    *Tip: To add the column references to the formula, in the **Available Columns** list, simply double-click a column.
    
    *The formula produces a unique key value for each month of a calendar year. It’s required to ensure that the calendar month labels sort in chronologic order. You’ll use this column in the next exercise when you configure the **Month** column sort order.*

39. Click **OK**.

    ![ws name.](media/6.36.png)

40. Remove the **CalendarMonthNumber** and **CalendarYear** columns.

	*Tip: You can remove the columns using one of three techniques. First, you can open the Choose Columns window, and then uncheck those columns. Second, you can multi-select the columns and use the ribbon Remove Columns commands. Or, third, you can multi-select the columns, right-click the selection, and then select the context menu to Remove Columns options.*

41. Review the native query, and notice the SQL expression used to compute the **MonthKey** column.
   
	*This design isn’t optimal. In a real world solution, query performance would be better if the **MonthKey** column values are stored in the **wwi.DimDate** table (or a materialized view).*

42. Verify that the query has four columns.

	*The design of the **Date** query is now complete.*

43. Select the **wwi DimEmployee** query.

    ![ws name.](media/6.37.png)

44. Rename the query as **Salesperson**.

45. To filter the table rows, in the **IsSalesperson** column header, click the down arrow, and then uncheck the **FALSE** item.

    ![ws name.](media/6.38.png)

46. Click **OK**.
 
47. Remove all columns, except:

	- EmployeeKey
	- Employee

    ![ws name.](media/6.39.png)

48. Rename the **Employee** column as **Salesperson**.

49. Review the native query, and notice the WHERE clause that filters the table.

50. Verify that the query has two columns.

    *The design of the **Salesperson** query is now complete*.

51. Select the **wwi DimStockItem** query.

    ![ws name.](media/6.40.png)

52. Rename the query as **Product**.
 
53. Remove all columns, except:

	- StockItemKey
	- Stock Item
	- Color
   
54. Rename the **Stock Item** column as **Product**.

55. Verify that the query has three columns.

    *The design of the **Product** query is now complete.*

56. Select the **wwi FactSale** query.

	![ws name.](media/6.41.png)

57. Rename the query as **Sale**.

58. Remove all columns, except:

	- CityKey
	- CustomerKey
	- StockItemKey
	- InvoiceDateKey
	- SalespersonKey
	- Quantity
	- UnitPrice
	- Profit

	![ws name.](media/6.42.png)

59. Rename the following columns:

	- **UnitPrice** as **Unit Price**
	- **Profit** as **Profit Amount**

60. Add a computed column using the following formula to create the **Sale Amount** column.

	```
	[Quantity] * [Unit Price]
	```

61. To modify the **Sale Amount** column data type, in the column header, click the **ABC123** icon, and then select **Decimal Number**.

	![ws name.](media/6.44.png)

62. Verify that the query has nine columns.

	*The design of the **Sale** query is now complete.*

63. To apply the queries, on the **Home** ribbon tab, from inside the **Close** group, click the **Close & Apply** icon.

    ![ws name.](media/6.45.png)
 
    *Each query is applied to create a model table. Because the data connection is using DirectQuery storage mode, only the model structure is created. No data is imported. The model now consists of one table for each query.*
    
64. In Power BI Desktop, when the queries have been applied, at the bottom-left corner in thes status bar, notice that the model storage mode is DirectQuery. 

    ![ws name.](media/3.60.png)

65. In Power BI Desktop, at the left, switch to Model view.
 
    ![ws name.](media/6.46.png)
 
     *Model view allows you to see all tables in the model diagram. It also allows you to configure many model properties. You’ll configure model properties in the next exercise.*

66. To upgrade to the new model view, in the banner across the top of the diagram, click Upgrade Now.

    ![ws name.](media/3.62.png)

67. In the model diagram, notice that there are six tables (some may be out of view—scroll horizontally to see them all).

68. Hover the cursor over any table header to reveal a tooltip, and then review the information presented.

69. To save the Power BI Desktop solution, on the **File** tab (backstage view), select **Save**.

70. Save the file as **Sale Analysis** to an easy-to-remember location in your file system.

71. Open File Explorer, and navigate to the file system location.

72. Notice the file size that is very small (~24 KB).

    *The Power Query queries have been loaded to create model tables. In the next exercise, you’ll complete the design of the model by creating relationships and applying model configurations.*

## **Task 2: Develop the Model**

In this exercise, you will develop the model by creating relationships, setting table and column properties, and creating measures.


### **Subtask 1: Create Relationships**

In this task, you will create relationships between all model tables. Each relationship with relate the **Sale** fact table to a dimension table.

1. In Power BI Desktop, in the model diagram, organize the tables as follows:

   -	Position the **Sale** table at the center of the diagram, and then surround it with the five dimension tables
   -	Ensure that the **Date** and **Geography** tables are next to each other

   ![ws name.](media/4.1.png)

2. To create the first relationship, from the **Sale** table, drag the **CityKey** column, and then drop it on the **Geography** table **CityKey** column.

   *Sometimes this technique doesn’t work properly. In this case, deselect the column you want to drag by selecting a different column, and then start the drag operation again.*

   ![ws name.](media/4.2.png)

3. In the **Create Relationship** window, at the bottom-left, check the **Assume Referential Integrity** checkbox.

   ![ws name.](media/6.49.png)

   *When referential integrity is assumed, Power BI will join tables by using a more efficient INNER join (instead of an OUTER join). However, it’s important that there are matching values on both sides of the join, because an INNER join will eliminate rows from the query result when values don’t match. At design time, sometimes Power BI Desktop will attempt to validate that data integrity is in place. If the validation takes too long, when prompted, you can skip validation process.*

4. Click **OK**.

   ![ws name.](media/6.50.png)

5. In the diagram, notice the relationship is a connector between tables..

   ![ws name.](media/4.3.png)

   *Model relationships propagate filters between tables. So, for example, if a report filters by **State-Province** column by **California**, a filter propagates to the **Sale** table to ensure rows for that state are queried.*

6. Notice there is a one-side (1) and many-side (*) to the relationship.

	*Dimension tables, like **Geography**, are always the one-side of the relationship. These tables include a unique column (dimension key column). Filters always propagate from the one-side to the many-side. In more advanced scenarios, filters can propagate in both directions. In this lab, you won’t configure bi-directional relationships. For more information about relationships*, [***see Model relationships in Power BI Desktop.***](https://docs.microsoft.com/en-us/power-bi/transform-model/desktop-relationships-understand)

7. Create four additional relationships and configure each to assume referential integrity:

   - Relate the **Sale** table **CustomerKey** column to the **Customer** table **CustomerKey** column
   - Relate the **Sale** table **InvoiceDateKey** column to the **Date** table **Date** column
   - Relate the **Sale** table **SalespersonKey** column to the **Salesperson** table **EmployeeKey** column
   - Relate the **Sale** table **StockItemKey** column to the **Product** table **StockItemKey** column
 
8. Verify that all tables are now related.

   ![ws name.](media/4.4.png)


9. Verify that the one-side of each relationship is on the dimension table side.

   *If a relationship is configured to filter in the wrong direction, double-click the relationship, and then modify the **Cardinality** property.*

10. Save the Power BI Desktop solution.

## **Subtask 2: Configure the Geography Table**

In this task, you will add two hierarchies to the **Geography** table and configure data categorization for three columns.

1. In the model diagram, in the **Geography** table, right-click the **Region** column, and then select **Create Hierarchy**.

   ![ws name.](media/4.5.png)

   *Hierarchies provide ease of navigation across the model data, allowing drill down and drill up operations. Always create a hierarchy using the column that’s to become the first (top) level of the hierarchy.*

2. In the Properties pane (located at the right of the model diagram), in the **Name** box, replace the text with **Sales Organization**.

   ![ws name.](media/6.54.png)

3. In the **Properties** pane, in the Hierarchy dropdown list (select a column to add a level), select the **Subregion** column.

4. Notice that the column was added as the next level in the hierarchy.

   ![ws name.](media/6.55.png)

5. Add the following three additional columns to the hierarchy, in this order:

   - Sales Territory
   - State-Province
   - City

6. To complete the hierarchy configuration, click **Apply Level Changes**.

   ![ws name.](media/6.56.png)

7. Create a second hierarchy in the **Geography** table named **Geography**, with the following levels:

   - Country
   - State-Province
   - City

   ![ws name.](media/6.57.png)

8. In the **Geography** table, select the **Country** column.
 
9. In the **Properties** pane, expand the **Advanced** section, and then in the **Data Category** dropdown, select **Country/Region**.

   ![ws name.](media/6.58.png)

   *Data categorization defines additional metadata. In this case, the column is categorized as a spatial column, and as such Power BI will—by default—visualize it by using map visuals.*

10. Set the following additional column data categorizations:

   - Categorize the **State-Province** column as **State or Province**
   - Categorize the **City** column as **City**

   *Configuration of the **Geography** table is now complete.*
   
### **Subtask 3: Configure the Date Table**

In this task, you will add a hierarchy to the Date table and configure the Month column sort order.

1. In the **Date** table, create a hierarchy named **Calendar**, with the following levels:

   - Year
   - Month
   - Date

2. In the **Date** table, select the **Month** column.

3. In the **Properties** pane, in the **Advanced** section, in the **Sort by Column** dropdown list, select **MonthKey**.

   ![ws name.](media/6.59.png)
 
   *The alphabetic **Month** column values will now sort by the chronologic **MonthKey** column values.*
   
   *Configuration of the **Date** table is now complete.*
   
### **Subtask 4: Configure the Sale Table**

In this task, you will configure the **Sale** table columns.

1. In the **Sale** table, select the **Quantity** column.

2. In the **Properties** pane, in the **Formatting** section, set the **Thousands Separator** property to **Yes**.

   ![ws name.](media/6.60.png)

   *Formatting columns ensures appropriate and consistent formatted values in report visuals.*

3. To multi-select columns, first press the **Ctrl** key, and then select the following three columns:

   - Profit Amount
   - Sale Amount
   - Unit Price

4. In the **Properties** pane, in the **Formatting** section, in the **Format** dropdown list, select **Currency**.

   ![ws name.](media/6.61.png)

5. In the Decimal Places box, enter 2.

5. Select the **Unit Price** column (you might need to first de-select the multi-selection of columns, and then select this single column).

6. In the **Properties** pane, in the **Advanced** section, in the **Summarize by** dropdown list, select **Average**.

   *By default, numeric column will be aggregated by using the sum function. In this case, it doesn’t make sense to sum unit price values together. The default summarization for this column now averages unit prices.*
 
	![ws name.](media/6.62.png)

   *Configuration of the **Sale** table is now complete.*

### **Subtask 5: Hide Columns**

In this task, you will hide columns that are not appropriate for reporting.

*Typically, you hide key columns that are used to relate tables or sort columns.*

1. Multi-select the following 10 columns:

   - **Geography** table **CityKey** column
   - **Date** table **MonthKey** column
   - **Customer** table **CustomerKey** column
   - **Salesperson** table **EmployeeKey** column
   - **Product** table **StockItemKey** column
   - **Sale** table **CityKey**, **CustomerKey**, **InvoiceDateKey**, **SalespersonKey**, and **StockItemKey** columns
 
2. In the **Properties** pane, set the **Is Hidden** property to **Yes**.

	![ws name.](media/6.63.png)


### **Subtask 6: Mark the Date Table**

In this task, you will mark the **Date** table.

*Marking a date table is required to ensure the Data Analysis Expressions (DAX) time intelligence functions work correctly. You’ll create a measure and define a time intelligence calculation in the next task.*

1. Switch to Report view.

   ![ws name.](media/6.64.png)

   *Marking a date table cannot be done in Model view.*

2. In the **Fields** pane (located at the right), select the **Date** table.

3. On the **Table Tools** contextual ribbon tab, from inside the **Calendars** group, click **Mark as Date Table**, and then select **Mark as Date Table**.
 
   ![ws name.](media/6.65.png)
 
4. In the **Mark as Date Table** window, in the **Date Column** dropdown list, select **Date**.

   ![ws name.](media/6.66.png)
 
5. When validation has succeeded, click **OK**.

   ![ws name.](media/6.67.png)
 
   *Validation ensures the column contains unique dates, no missing dates, and no gaps between dates. These conditions are a prerequisite to ensure the DAX time intelligence filters work correctly.*

### **Subtask 7: Create Measures**

In this task, you will create two measures. Measures are expressions that summarize model data.

1. In the **Fields** pane, right-click the **Sale** table, and then select **New Measure**.
 
   ![ws name.](media/6.68.png)
 
2. In the formula bar (located directly beneath the ribbon), replace the text with the following measure definition, and then press **Enter**.

   *Tip: When entering the formula, to enter a carriage return, press **Shift+Enter**.*
   
   ![ws name.](media/6.69.png)

   *This formula uses a built-in DAX time intelligence function to accumulate the sum of the **Sale** table **Profit Amount** column values within the year to produce a year-to-date (YTD) result.*

3. In the **Fields** pane, notice the addition of the measure.

   ![ws name.](media/6.70.png)

   *Measures are identified by the calculator icon.*

4. To configure formatting, in the **Fields** pane, ensure the measure is selected (not checked).

5. On the **Measure Tools** contextual ribbon, from inside the **Formatting** group, in the dropdown list, select **Currency**, and set the decimal places to **2**.
 
   ![ws name.](media/6.71.png)
 
6. Add a second measure to the Sale table using the following formula:

   ![ws name.](media/6.72.png)
   
   ```
   Profit % All Geography =
   DIVIDE(
    SUM(Sale[Profit Amount]),
    CALCULATE(
        SUM(Sale[Profit Amount]),
        REMOVEFILTERS(geography)
    )
   )
   ```

   *This formula divides the sum of the **Sale** table **Profit Amount** column by the same expression, but by using a different filter context. The denominator removes any filters applied to the **Geography** table.*

7. Format the **Profit % All Geography** measure as a percentage.

   ![ws name.](media/6.73.png)
 
8. Save the Power BI Desktop solution.

   *All model configurations have now been made. In the next exercise, you’ll create a test report and measure query performance.*

## **Task 3: Test the Model**

In this exercise, you will create a test report. You will then use Performance Analyzer to measure query performance.

### **Subtask 1: Create a Test Report**

In this task, you will design a simple report to test query performance.

1. In Power BI Desktop, in Report view, to add a slicer to the report canvas, in the **Visualizations** pane, click the slicer icon.
 
   ![ws name.](media/6.74.png)

2. In the Fields pane, from the Date table, drag the Calendar hierarchy to the slicer.

3. In the Visualizations pane, in the Field well, to remove the Date hierarchy level, click X.

   ![ws name.](media/4.6.png)

3. Filter the slicer by **CY2012**.

   ![ws name.](media/6.75.png)
 
4. To create a new visual, first select an empty area of the report canvas.

   *Selecting the report canvas de-selects the slicer visual*.
 
5. To add a table visual to the report canvas, in the **Visualizations** pane, click the table visual icon.

   ![ws name.](media/6.76.png)
 
6. Position the table visual to the right of the slicer, and then resize it as large as possible.

7. Drag and drop the following visuals into the table visual:

   - **Date** table **Month** field (not the **Month** hierarchy level)
   - **Sale** table **Profit Amount** field
   - **Sale** table **Profit YTD** field
 
   ![ws name.](media/6.77.png)

   *Performance is likely to be slow, as the model hasn’t yet been optimized. You’ll be optimizing the model with aggregations in **Exercise 07**.*
 
8. In the **Visualizations** pane, in the **Values** well, to remove the fields, click **X** next to each field.

   ![ws name.](media/6.78.png)
 
9. Drag and drop the following fields into the table visual:

   - **Geography** table **State-Province** field (it is second from the bottom—do not use the **State-Province** hierarchy level)
   - **Sale** table **Profit Amount** field
   - **Sale** table **Profit %** **Total Geography** field

   ![ws name.](media/6.79.png)


### **Subtask 2: Measure Query Performance**

In this task, you will use Performance Analyzer to measure query performance.

1. On the **View** ribbon tab, from inside **Show Panes** group, select **Performance Analyzer**.

   ![ws name.](media/6.80.png)
 
2. In the **Performance Analyzer** pane, click **Start Recording**.

   ![ws name.](media/6.81.png)
 
   *When recording, Performance Analyzer captures statistics when visual query data.*

3. In the **Performance Analyzer** pane, click **Refresh Visuals**.

   ![ws name.](media/6.82.png)
 
4. In the list, notice the duration statistics, which are recorded in milliseconds.

5. Expand the **Table** node.

6. Notice that it is possible to determine the duration of the DirectQuery process, and that presently it is several seconds.

    *Report users demand fast responses. Usually, they’re very happy when visuals refresh in less than one second, but are still happy when it takes no more than about five seconds.*

7. To copy the SQL query to the clipboard, click the **Copy Query**.

   ![ws name.](media/6.83.png)
 
8. Open a text editor, like Notepad, and paste in the query.

9. Review the query.

   *The query statement provides you with insight into how Power BI queries Azure Synapse Analytics. It can lead to you to apply specific optimizations in the data source, like indexes or materialized views, to improve query performance.*

10. Close the text editor, without saving changes.

11. In the **Performance Analyzer** pane, click **Stop**.

    ![ws name.](media/6.84.png)
 
12. Save the Power BI Desktop solution.

    *The lab is now complete. Leave your Power BI Desktop solution open ready to start the next lab (when instructed to do so)*.

    *In **Exercise 07**, you’ll improve query performance by creating an aggregation table*.

### Summary

In this exercise, you used Power BI Desktop to develop a data model over your Azure Synapse Wide World Importers (WWI) data warehouse. The data model allowed you to publish a semantic layer over the data warehouse. Comprising six tables, it defines relationships, hierarchies, calculations, and friendly and consistent names. The data model is an intuitive and high performance source for Power BI reports.
<br/><br/>
# Exercise 7: Optimize a Power BI Model

In this Exercise, you are continuing to work in the role of a **Data architect** or **BI developer**.

You will use Power BI Desktop to configure dimension table storage as dual. You will then add an aggregation table to accelerate query performance. The model storage will be switched to mixed mode: Some tables will cache data to further boost query performance. You will finalize the lab by deploying the model to the Power BI service, so it is ready for reporting in Exercise 8.

---

**Important**

It’s a prerequisite that you successfully complete Exercise 6 before commencing this lab.

---

## **Task 1: Add an Aggregation Table**

In this exercise, you will configure dimension tables as dual storage mode table. You will then create an aggregation table to boost Power BI query performance for date, geography, and profit reporting.

### **Subtask 1: Configure Dual Storage**

In this task, you will configure dual storage for all dimension tables.

1. Switch to the Power BI Desktop solution you developed in **Exercise 6**.

2.	Switch to Model view.

3.	While pressing the **Ctrl** key, multi-select each of the five dimension tables:

   -	Customer
   -	Date
   -	Geography
   -	Product
   -	Salesperson

4. In the **Properties** pane, from within the **Advanced** section, in the **Storage Mode** dropdown list, select **Dual**.

   ![ws name.](media/Dual.png)
 
   *It’s common to set dimension tables to use dual storage mode. This way, when used by report slicers, they deliver fast performance. If these dimension tables will be queried at the same time as other imported tables, it can avoid the need for Power BI to query the data source.*.
   
   
5. When prompted to set the storage mode, click **OK**.
   
   ![ws name.](media/7.002.png)
  
6. When the refresh completes, notice that the dual storage tables are indicated by a dashed header line.

   ![ws name.](media/7.001.png)

7. Save the Power BI Desktop solution.

   *The data model is now in mixed mode. It’s a composite model consisting of DirectQuery storage mode tables and import storage mode tables.*
   
8. In File Explorer, notice the file size has grown as a result of the imported data for the dimension tables.

   *When the model stores data, you need to ensure the cached data current. The model must be refreshed on a frequent basis to ensure import data is in sync with the source data*.
   
9. In Report view, in the status bar, at the bottom-right, notice that the storage mode is now mixed.

   ![ws name.](media/7.003.png)
   
10. In the **Performance Analyzer** pane, start recording, and then refresh visuals.

11. Notice that the query result for the slicer is now sub-second.

12. In the **Performance Analyzer** pane, stop recording.

### **Subtask 2: Create an Aggregation Table**

In this task, you will create an aggregation table to accelerate Power BI report visuals that specifically query by date and geography, and summarize profit.

1. To open the Power Query Editor window, on the **Home** ribbon tab, from inside the **Queries** group, click the **Transform Data** icon.
 
   ![ws name.](media/Transform.Data.png)
   
2. In the Power Query Editor window, from inside the **Queries** pane, right-click the **Sale** query, and then select **Duplicate**.

   ![ws name.](media/Duplicate.png)
 
3. In the **Queries** pane, notice the addition of a new query.

   ![ws name.](media/Queries.png)
 
   *You’ll apply a transformation to group by the **CityKey** and **InvoiceDateKey** columns, and aggregate the sum of **Profit Amount** column*.
   
4. Rename the query as **Sale Agg**.
   
   ![ws name.](media/7.7.png)
   
5. On the **Transform** ribbon tab, from inside the **Table** group, click **Group By**.
   
   ![ws name.](media/7.8.png)
    
6. In the **Group By** window, select the **Advanced** option.
   
   ![ws name.](media/7.9.png)
    
   *The advanced option allows grouping by more than one column.*
   
7. In the grouping dropdown list, ensure that **CityKey** is selected.
   
   ![ws name.](media/7.10.png)
    
8.	Click **Add Grouping**.

9.	In the second grouping dropdown list, select **InvoiceDateKey**.

10. In the **New Column Name** box, replace the text with **Profit Amount**.

11. In the **Operation** dropdown list, select **Sum**.

12. In the **Column** dropdown list, select **Profit Amount**.

    ![ws name.](media/7.11.png)
 
13. Click **OK**.

    ![ws name.](media/7.12.png)
     
14. On the **Home** ribbon tab, from inside the **Close** group, click the **Close & Apply** icon.

    ![ws name.](media/7.13.png)

    *A new table is added to the model*.
    
15. Save the Power BI Desktop solution.

### **Subtask 3: Configure Aggregations**

In this task, you will switch the aggregation table to import data. You will then create model relationships to the aggregation table and manage aggregations.

1.	Switch to Model view.

2.	Position the **Sale Agg** table so that it is near the Geography and **Date** tables.

3.	Set the storage mode for the **Sale Agg** table as **Import**.
   
   ![ws name.](media/7.14.png)
   
4.	If prompted to proceed, click OK.
   
   ![ws name.](media/7.002.png)

5.	When the refresh completes, notice that the import storage table does not include a blue mark across the top (solid or dashed).
   
   ![ws name.](media/7.004.png)
 
6.	Create two model relationships:

   -	Relate the **Sale Agg** table CityKey column to the **Geography** table **CityKey** column
   -	Relate the **Sale Agg** table **InvoiceDateKey** column to the **Date** table **Date** column

   ![ws name.](media/7.005.png)
   
7.	Right-click the **Sale Agg** table, and then select **Manage Aggregations**.
   
   ![ws name.](media/7.16.png)
 
8. In the **Manage Aggregations** window, for the **Profit Amount** aggregation column, set the following properties:

    -	Summarization: **Sum**
    -	Detail table: **Sale**
    -	Detail column: **Profit Amount**

   ![ws name.](media/7.17.png)
   
9.	Notice the warning that describes the table will be hidden.

   *The table will be hidden in a different way to other hidden model objects (like the key columns you hid in **Exercise 6**). Aggregation tables are always hidden, and they can’t even be referenced in model calculations*.
   
10. Click **Apply All**.

    ![ws name.](media/7.18.png)
   
11. In the model diagram, notice that the **Sale Agg** table is now hidden.

    ![ws name.](media/7.006.png)
 
12. In the model diagram, select the **Sale Agg** table.
    
13. Switch to Report view.

14. In the **Performance Analyzer** pane, start recording, and then refresh visuals.

15. Notice that the query results for the table visual is now sub-second.

    *Because the **Geography** and **Date** tables use dual storage mode, when a report visual queries them at the same time as the aggregation table, Power BI will query the model cache. There’s no need to use DirectQuery to query the data*.

16. In the **Performance Analyzer** pane, stop recording.

## **Task 2: Publish the Model**

In this task, you will publish the model and complete some post-publication tasks.

### **Subtask 1: Publish the Model**

In this task, you will publish the model.

1.	In Power BI Desktop, on the **Home** ribbon tab, from inside the **Share** group, click **Publish**.

   ![ws name.](media/7.007.png)
    
2.	If prompted to save changes, click **Yes**.

3.	In the **Publish to Power BI** window, select the lab workspace (do not use **My Workspace**).

4.	Click **Select**.

   ![ws name.](media/7.21.png)
   
5.	When publication has completed, click **Got It**.

6.	Close Power BI Desktop.

   *You will open a new instance of Power BI Desktop in **Exercise 8** when you create a new composite model.*
   
## **Subtask 2: Complete Post-Publication Tasks**

In this task, you will complete some post-publication tasks.

*You’ll complete the post-publication tasks using the Power BI service because it’s not possible to do them in Synapse Studio.*

1.	In Power BI web browser session, open your lab workspace.

   ![ws name.](media/7.22.png)
   
2.	In the **Navigation** pane, open the workspace, and then verify that the **Sale Analysis** dataset exists.

   ![ws name.](media/aiad2.png)
   
3.	Notice there is also the **Sale Analysis** report.

   *It wasn’t our intention to publish a report, it was published alongside the model. You’ll develop a report in **Exercise 8**. So, we’ll delete this report*.
   
4.	In the **Navigation** pane, hover the cursor over the **Sale Analysis** report, click the vertical ellipsis (…), and then select **Remove**.

   ![ws name.](media/7.24.png)
   
5.	When prompted to delete the report, click **Delete**.

   ![ws name.](media/7.25.png)
 
6.	To apply data source credentials, in the **Navigation** pane, hover the cursor over the **Sale Analysis** dataset, click the vertical ellipsis, and then select **Settings**.

   ![ws name.](media/7.26.png)
   
7.	Expand the **Data Source Credentials** section.
   *You’ll see an error, and it’s expected. You will address the error in the next step.*
   
    ![ws name.](media/7.000.png)
  
8.  To assign credentials, click the **Edit Credentials** link.

9.  In the window, in the **Authentication Method** dropdown list, ensure **OAuth2** is selected.

10. In the **Privacy Level** dropdown list, select **Organizational**.

    *If you need the Power BI report user identity to flow to Azure Synapse (because per-user access permission must be enforced), you can check the checkbox. When the checkbox is left unchecked, the identity you will use to sign in (at the next step) will be used for all connections*.

11. Click **Sign In**.

    ![ws name.](media/7.28.png)
    
12. Use the lab Azure credentials to **sign in**.
 
13. Expand the **Scheduled Refresh** section.

    ![ws name.](media/7.29.png)

    *In this lab, you won’t schedule data refresh. Because your dataset contains import data (for the dimension tables and the aggregation table), you can schedule data refresh to keep the aggregation and dimension table import data current. It’s possible, too, that your Azure Data Factory pipelines could send refresh commands using the Power BI REST API, once the data warehouse load has completed*.
    
14. Expand the **Endorsement** section.

    ![ws name.](media/7.30.png)
     
15. Select the **Promoted** option.

    *The promoted endorsement communicates that the model is production-ready. In this lab, ideally, you’d select the **Certified** option. A certified dataset is one that’s truly reliable and authoritative, designed for use across the organization. (It’s not available for your trial account.)*
    
16. In the **Description** box, enter: **Lab dataset**

17. Click **Apply**(you may need to scroll down).

    ![ws name.](media/7.31.png)
    
18. Switch to the Azure Synapse web browser session.

19. In the **Develop** hub, select **Power BI Datasets**.

20. Notice that the **Sale Analysis** dataset is listed.

    ![ws name.](media/7.32.png)
 
    *The dataset is published and is configured ready for use. In **Exercise 8**, you’ll perform a live connection to the dataset and create a report*.
    
   ### Summary
   
In this exercise, you used Power BI Desktop to configure dimension table storage as dual. You then added an aggregation table to accelerate query performance. The model storage was switched to mixed mode: Some tables now cache data to further boost query performance. You finalized the exercise by deploying the model to the Power BI service, so it is ready for reporting in **Exercise 08**.
<br/><br/>
# Exercise 8: Create a Model Using DQ to Power BI

In this lab, you are working in the role of a **data analyst**.

You will use Power BI Desktop to connect to the **Sale Analysis** dataset published in **Exercise 7**. You will then convert the live connection to a DirectQuery model, allowing you to extend the remote model with a calculated column and a new table of imported data sourced from a web page.

---

**Important**

Important: You must successfully complete Exercise 7 before commencing this lab.

---

## **Task 1: Getting Started**

In this task, you will get started by enabling a preview feature and creating a live connection to the Sale Analysis dataset.


### **Subtask 1: Enable Preview Feature**

In this task, you will enable a preview feature to work with DirectQuery models with Power BI datasets.

1. Open Power BI Desktop.

2. If the getting started window opens, at the top-right of the window, click **X**.

   ![ws name.](media/A1.png)

3. To enable the preview feature, on the File tab (backstage view), select Options and Settings, and then select Options.

   ![ws name.](media/A2.png)

4. In the Options window, at the left, select Preview Features.
	
   ![ws name.](media/A3.png)

5. Ensure the DirectQuery for Power BI Datasets and Analysis Services feature is checked.
	
   ![ws name.](media/A4.png)

6. Click OK.

   ![ws name.](media/A5.png)

7. When notified that a restart of Power BI Desktop is required, click OK.

8. Close Power BI Desktop.

9. Open Power BI Desktop again, and close the getting started window.
 
10. To save the Power BI Desktop solution, on the **File** tab (backstage view), select **Save**.

11. Save the file as **Sale Report** to an easy-to-remember location in your file system.

### **Subtask 2: Create a Live Connection**

In this task, you will create a live connection to the **Sale Analysis** dataset.

1. On the **Home** ribbon, from inside the **Data** group, click **Get Data**, and then select **Power BI Datasets**.

   ![ws name.](media/A6.png)
 
2. In the **Select a Dataset** window, notice that the **Sale Analysis** dataset is endorsed as a promoted dataset.
	
   *It was endorsed by the BI developer who published the dataset in Exercise 07.*

3. Select the **Sale Analysis** dataset.

   ![ws name.](media/A7.png)
 
4. Click **Create**.
   
   ![ws name.](media/A8.png)
   
5. In the status bar, at the right, notice the live connection status.

   ![ws name.](media/A9.png)
   
    *Live connections are ideal when creating a report that uses an existing Power BI dataset.*
   
6. Switch to Model view.

7. To upgrade to the new model view, in the banner across the top of the diagram, click Upgrade Now.

   ![ws name.](media/A10.png)
	
   *While the model is hosted remotely as a Power BI dataset, it’s still possible to review the model design in the diagram.*
	
8. In the model diagram, select any table, and then in the Properties pane, notice that all properties are read-only.

    *A live connection to a Power BI dataset is read-only, unless you convert it to a DirectQuery model. You will convert it to a DirectQuery model in the next section. It will allow you to extend the design of the remote model that the BI developer published in Exercise 07.*
 
9. Save the Power BI Desktop solution.

## **Task 2: Develop a Model Using DQ to Power BI**

In this task, you will develop a new model that uses a DirectQuery connection to a remote Power BI dataset and extends it with new calculations and data. You will then publish the new model to the Power BI service.

### **Subtask 1: Edit the Model**

In this task, you will edit the model.

1. On the Home ribbon tab, from inside the Modeling group, click Make Changes to This Model.
	
   ![ws name.](media/A11.png)

2. To understand the transformation that is about to happen, read the text in the dialog window.

3. Click Add a Local Model.

   ![ws name.](media/A12.png)

   *The model is now a DirectQuery model. It’s now possible to enhance the model by modifying certain table or column properties, or adding calculated columns. It’s even possible to extend the model with new tables of data that are sourced from other data sources.*
	
	
4. In Report view, in the status bar, at the right, notice that the model is using DirectQuery storage mode.

   ![ws name.](media/A13.png)
		
   *Your local model is in fact a DirectQuery connection to the Power BI dataset.*
	
5. Switch to Model view.

6. In the diagram, select any table, and then notice it is now possible to modify the properties—but do not modify any properties at this time.

### **Subtask 2: Create a Calculated Column**

In this task, you will create a calculated column to enable a new way of analyzing US state sale amounts.

1. Switch to Report view.

2. In the Fields pane (located at the right), right-click the Geography table, and then select New Column.

   ![ws name.](media/A14.png)
		
3. In the formula bar (located beneath the ribbon tab), enter the following calculated column definition.

   *Tip: To enter a carriage return, press Shift+Enter. To enter a tab, press Shift +Tab.*
	```
	DAX
	State-Province Type =
	SWITCH(
		TRUE(),
		Geography[State-Province] = "Puerto Rico (US Territory)", "Territory",
		Geography[State-Province] IN {"Alaska", "Hawaii"}, "Non-contiguous",
		Geography[Country] = "United States", "Contiguous",
		"N/A"
	)
	```	
   *The calculated column is named **State-Province Type**. The expression uses the DAX SWITCH function to return a classification for each table row (which represents a city) based on these rules (the first rule match wins):
• If the state name of the city is Puerto Rico (US Territory), it is classified as **Territory**.
• Otherwise, if the state name of the city is Alaska or Hawaii, it is classified as **Non-contiguous**.
• Otherwise, if the country of the city is United States, it is classified as **Contiguous**.
• Otherwise, it is classified as **N/A**.

4. In the Fields pane, in the Geography table, notice the addition of the calculated column (if necessary, widen the pane).

   ![ws name.](media/A15.png)
		
5. To filter the report, ensure the Filters pane is open.

   ![ws name.](media/A16.png)
		
6. In the Fields pane, in the Geography table, right-click the Country field, and then select Add to Filters | Report-level Filters.

   ![ws name.](media/A17.png)
		
7. In the Filters pane, in the Country filter tile, check the United States item.

   ![ws name.](media/A18.png)
	
   *All report pages now filter by the country United States.*
	
8. To add a matrix visual to the page, in the Visualizations pane, click the Matrix icon.

  ![ws name.](media/A19.png)
		
9. Position and resize the visual to fill the report page, but be sure to leave about a 0.5 inches (1 cm) of space along the top of the page.

10. In the **Fields** pane, from the **Geography** table, drag the **State-Province Type** field and drop it into the matrix visual.

11. In the matrix visual, verify that you see three rows—one for each state-province classification.
	
    ![ws name.](media/A20.png)
		
12. To add a new level to the matrix visual rows, from the **Geography** table, drag the **State-Province** field into the Rows well (located beneath the **Visualizations** pane), directly beneath the **State-Province Type** field.

    ![ws name.](media/A21.png)
		
    ![ws name.](media/A22.png)
		
13. To add a value to the matrix visual, in the Fields pane, from inside the Sale table, drag the Sale Amount field into the matrix visual.		
		
    ![ws name.](media/A23.png)
		
14. Notice that it is now possible to analyze sale amounts using the classifications generated by the calculated column added to the Geography table.

15. To expand all levels on the matrix visual rows, at the top-right of the matrix visual, click the Expand All Down One Level In the Hierarchy icon (fork-like icon).

    ![ws name.](media/A24.png)
		
### **Subtask 3: Create a New Table**

In this task, you will create a new table sourced from a web page to support per capita analysis.

1. On the **Home** ribbon tab, from inside the **Data** group, click **Get Data**, and then select **Web**.

   ![ws name.](media/A25.png)
		
2. In the **From Web window**, in the **URL** box, enter: **https://aka.ms/USPopulationSynapsePBI**
   *The URL is for a web page that contains US census population data. You will preview the web page in the following steps.*

3. Click **OK**.

   ![ws name.](media/A26.png)

4. In the **Access Web Content** window, notice that anonymous authentication is selected, and then click **Connect**.
		
   ![ws name.](media/A27.png)
		
5. In the **Navigator** window, in the right pane, select **Web View**.
		
   ![ws name.](media/A28.png)
		
6. Review the web page design.

   *The page comprises a table listing US states together with their 2009 census population value and a ranking.*

7. Switch back to **Table** view.
		
   ![ws name.](media/A29.png)
		
8. To preview HTML table data, in the left pane, select (do not check) **Table 2**.
		
   ![ws name.](media/A30.png)
	
   *This table of data contains the data that’s required by your model to calculate sale per capita. Three transformations, however, will need to be applied: The row for **United States** must be removed, the **Rank** column must be removed, and the **Number** column must be renamed to **Population**.*
	
9. To create a query based on the Table 2 HTML table, check the Table 2 checkbox.			
   ![ws name.](media/A31.png)
		
10. Click **Transform Data**.
		
    ![ws name.](media/A32.png)
		
11. In the Power Query Editor window, in the **Query Settings** pane (located at the right), in the **Name** box, replace the text with **US State Population**, and then press **Enter**.
			
    ![ws name.](media/A33.png)
		
12. To remove the United States row, in the State column header, click the down-arrow, and then uncheck the United States item (scroll to the bottom of the list).
		
    ![ws name.](media/A34.png)
		
13. Click **OK**.

14. To remove the **Rank** column, right-click the **Rank** column header, and then select **Remove**.
		
    ![ws name.](media/A35.png)

15. To rename the Number column, double-click the Number column header, replace the text with Population, and then press Enter.
 
16. Verify that the query has two columns and 51 rows.

*Tip: The query column and row counts are displayed at the left of the status bar.*	
    ![ws name.](media/A36.png)
		
17. To apply the query, on the **Home** ribbon tab, from inside the **Close** group, click the **Close & Apply** icon.
		
    ![ws name.](media/A37.png)
		
18. When prompted about a potential security risk, read the notification, and then click OK.

*The warning is irrelevant in your model design because Power Query isn’t merging queries that connect to different data sources.*

![ws name.](media/A38.png)
		
*The query is applied to create a model table. Because the data connection to the web page does not support DirectQuery storage mode, the table rows have been imported into the model.*

19. In Report view, in the status bar, at the right, notice that the model is now using mixed storage mode.
		
    ![ws name.](media/A39.png)
		
20. Switch to Model view.

21. Notice the addition of the **US State Population** table.

22. Hover the cursor over the table header, and review the tooltip.

    *The tooltip describes that the table data is imported.*

23. Move the **US State Population** table so it sits beside the **Geography** table.
 
24. To create a model relationship, from the **Geography** table, drag the **State-Province** column and drop it on the **State** column of the **US State Population** table.
		
    ![ws name.](media/A40.png)
		
25. In the **Create Relationship window**, in the **Cross Filter Direction** dropdown list, select **Both**.
		
    ![ws name.](media/A41.png)
		
    *The rows of **Geography** table store cities, so the values found in the **State-Province** column contain duplicate values (for example, there are many cities in the state of California). When you create the relationship, Power BI Desktop automatically determines column cardinalities and discovered that it’s a many-to-one relationship. To ensure filters propagate from the **Geography** table to the **US State Population** table, the relationship must cross filter in both directions.*

26. Click **OK**.

    ![ws name.](media/A42.png)
	
27. To hide the new table, in the header of the **US State Population** table, click the visibility icon.

    ![ws name.](media/A43.png)
		
    *The table is hidden because it will only be used by a measure calculation that you will create in the next task.*

### **Subtask 4: Create a Measure**

In this task, you will create a measure to calculate sale per capita.

1. Switch to Report view.

2. In the **Fields** pane, right-click the **Sale** table, and then select **New Measure**.

		
   ![ws name.](media/A44.png)

3. In the formula bar, enter the following measure definition.

	```
	DAX
	Sale per Capita =
	DIVIDE(
		SUM('Sale'[Sale Amount]),
		SUM('US State Population'[Population])
	)
	```
	
    *The measure is named **Sale per Capita**. The expression uses the DAX DIVIDE function to divide the sum of the **Sale Amount** column by the sum of the **Population** column.*

4. On the **Measure Tools** contextual ribbon tab, from inside the **Formatting** group, in the **Format** dropdown list, select **Currency**.

5. In the decimal places box, enter **2**.

   ![ws name.](media/A45.png)
		
6. To add the measure to the matrix visual, in the **Fields** pane, from inside the **Sale** table, drag the **Sale per Capita** field into the matrix visual.

   *The measure evaluates the result by combining data sourced from a remote model in the Power BI service with imported table local to your new model.*

### **Subtask 5: Repair a Data Issue**

In this task, you will modify data in the **US State Population** table to address a data issue in the data warehouse.

1. In the matrix visual, notice there is no measure value for the state of Massachusetts.

   ![ws name.](media/A46.png)
	
   *It’s because the state name, as stored in the Azure Synapse Analytics data warehouse, is misspelled (with trailing characters [E]). One approach to fix the spelling is to ask the data warehouse team to update their data, but that’s likely to take some time to achieve, if ever. The other approach is to modify the data loaded into the **US State Population** table, which you will do now.*	
	
2. On the Home ribbon tab, from inside the **Queries** group, click the **Transform Data** icon.	
		
   ![ws name.](media/A47.png)
		
3. In the Power Query Editor window, right-click the **State** column, and then select **Replace Values.**		
		
   ![ws name.](media/A48.png)
				
4. In the **Replace Values** window, in the **Value to Find** box, enter the correctly spelled state name: **Massachusetts**

5. In the **Replace With** box, enter the misspelled state name: **Massachusetts[E]**
		
   ![ws name.](media/A49.png)
		
6. Click **OK**.		
		
   ![ws name.](media/A50.png)
		
7. To apply the query, on the **Home** ribbon tab, from inside the **Close** group, click the **Close & Apply** icon.
		
   ![ws name.](media/A51.png)
		
8. When the query applies (and data is reimported into the model), in the matrix visual, notice that there is now a sale per capita value for the state of Massachusetts.
		
   ![ws name.](media/A52.png)
		
   *The development and testing of the data model is now complete. You will now remove the visual in preparation for authoring a new report design in **Exercise 09**.*
	
9. Select the matrix visual.

10. To remove the visual, press the **Delete** key.
 
11. In the **Filters** pane, remove the **Country** filter.
		
    ![ws name.](media/A53.png)
		
12. Save the Power BI Desktop solution.

13. Leave the solution open for the next exercise.

    *The lab is now complete. As a data analyst, you will author a multi-page report design in **Exercise 09**.*


# Summary

In this exercise, you used Power BI Desktop to live connect to the **Sale Analysis** dataset published in **Exercise 07** by the BI developer. You then converted the live connection to a DirectQuery model, allowing you to extend the remote model with a calculated column and a new table of imported data sourced from a web page.

<br/><br/>
# Exercise 9: Author a Power BI Report

In this lab, you are working in the role of a **data analyst**.

You will use Power BI Desktop to continue the development of the solution created in Exercise 08. You will author a multi-page report that will include synced slicers, a custom visual, page drill through, a measure, bookmarks, and buttons. You will finalize the exercise by publishing the report to the Power BI service.

---

**Important**

Important: You must successfully complete Exercise 7 before commencing this lab.

---

## **Task 1: Develop the Report Layout**

In this task, you will develop a two-page report.


### **Subtask 1: Develop Page 1**

In this task, you will develop the first report page.

The completed report page will look like the following:
![ws name.](media/Q1.png)
    
   *Important: You must continue the development of the Power BI Desktop solution that was created in Exercise 08.*

1. In Power BI Desktop, in the **Fields** pane, in the **Geography** table, right-click the **Country** field, and then select **Add to Filters | Report-level Filters**.

   ![ws name.](media/Q2.png)

2. In the **Filters** pane, in the **Country** filter tile, check the **United States** item.

   ![ws name.](media/Q3.png)
 
3. To hide the filter, in the Filters pane, hover the cursor over the Country filter tile, and then click the visibility icon.

   ![ws name.](media/Q4.png)
	
   *Hiding the filter ensures that report users cannot modify the filter.*

4. In the **Filters** pane, at the top-left, click the arrow to collapse the pane.

   ![ws name.](media/Q5.png)
 
5. To rename the report page, at the bottom-left, double-click **Page 1**.

6. Replace the text with **Sale Analysis**, and then press **Enter**.

   ![ws name.](media/Q6.png)
 
7. To format the page, in the **Visualizations** pane, select the **Format** pane (paint roller icon).

   ![ws name.](media/8.8.png)
 
   *You’ll format many report elements in this lab to produce a professional report layout. To format an element, you’ll select it, and then access formatting options in this pane. Formatting options are organized into sections*.
   
8. Expand the **Page Background** section.

   ![ws name.](media/8.9.png)
 
9. Open the **Color** palette, click **Custom Color**, and set the custom color **C5C5C5**.

10. Set the **Transparency** property to **0%**.

11. Add a slicer to the page.

    ![ws name.](media/8.10.png)
 
12. Position and size the slicer at the top-left of the report page.
    
    ![ws name.](media/8.11.png)
 
13. In the **Fields** pane, expand the **Date** table, and then drag the **Calender** field  into the slicer.

    ![ws name.](media/Q7.png)
 
14. Ensure that the slicer is selected, and then open the **Format** pane.

15. Turn the **Shadow** property on.

    ![ws name.](media/8.13.png)
 
    *For a consistent style, you’ll be instructed to add shadow to all elements you add to the report*.
 
16. In the slicer, select **CY2012**.

    ![ws name.](media/Q8.png)
 
17. To create a new visual, first select an empty area of the report canvas.

18. To add a table visual to the report canvas, in the **Visualizations** pane, click the table visual icon.

    ![ws name.](media/8.15.png)
 
19. Position the table visual at the right of the slicer, and resize it to fill the remaining page space.

    ![ws name.](media/8.16.png)
 
20. Add the following fields to the table visual:

    -	**Geography** table **State-Province** field
    -	**Sale** table **Sale Amount** field
    -	**Sale** table **Sale per capita** field
    -	**Sale** table **Profit Amount** field

21. Apply the following table visual formats:

    -	In the **Style** section, set the **Style** to **Bold Header**.
    -	In the **Grid** section, increase the **Text Size** property to **16** pt.
    -	Turn **Shadow** on.

22. To sort the table visual rows, click the **Sale per Capita** column header to sort by descending profitability.

    ![ws name.](media/Q9.png)
 
23. Save the Power BI Desktop solution.
 
## **Task 2: Develop Page 2**

In this task, you will develop the second report page.

The completed report page will look like the following:

![ws name.](media/Q10.png)
 
1. To duplicate the report page, at the bottom-left, right-click the **Sale Analysis** page, and then select **Duplicate Page**.

   ![ws name.](media/8.19.png)
 
   *Tip: Duplicating the page copies the formatting options. It can be quicker to duplicate than to reapply formats. And, it’s likely to result in more design consistency.*

2. Rename the new page as **Sale Chord**.

   ![ws name.](media/8.20.png)
 
3. To delete the table visual, select the visual, and then press the **Delete key**.
 
4. To sync the slicers, on the **View** ribbon tab, from inside the **Show Panes** group, select **Sync Slicers**.
 
   ![ws name.](media/8.21.png)
   
5. In the report page, select the **Year** slicer.

6. In the **Sync Slicers** pane (located at the left), check both pages to sync.

   ![ws name.](media/8.22.png)
 
   *When a report user changes either **Year** slicer, the filter will propagate between these pages. Both slicers will remain in sync.*
   
7. In the **Sync Slicers** pane, at the top-left, click **X**.

   ![ws name.](media/8.23.png)
 
8. To import a custom visual, in the **Visualizations** pane, click the ellipsis (…), and then select **Get More Visuals**.

   ![ws name.](media/Q11.png)
 
9. In the **Power BI Visuals** window, in the **Search** box, enter **Chord**, and then press **Enter**.

   ![ws name.](media/8.25.png)
 
10. When the **Chord** search result appears, click **Add**.

    ![ws name.](media/8.26.png)
 
11. When the custom visual imports, click **OK**.

12. In the **Visualizations** pane, notice that the chord custom visual sits in an area beneath the core Power BI visuals.

    ![ws name.](media/8.27.png)
 
13. Add a chord visual to the report page.
 
14. Position the chord visual at the right of the slicer, and resize it to fill the remaining page space.

    ![ws name.](media/8.28.png)
 
15. Configure the following visual field wells:

    -	**From: Geography** table **Sales Territory** field
    -	**To: Customer** table **Buying Group** field
    -	**Values: Sale** table **Sale Amount** field

    ![ws name.](media/8.29.png)
 
16. Format the chord visual to add shadow.

17. Change the **Year** slicer values, and notice how the chord visual animates.

18. Hover the cursor over the outer segments and the internal chords to reveal tooltips describing inter-relationships between sales territories and buying groups.

19. Set the **Year** slicer back to **CY2012**.

20. Save the Power BI Desktop solution.

## **Task 2: Develop a Drill Through Page**

In this exercise, you will develop a drill through page.

### **Subtask 1: Develop a Drill Through Page**

In this task, you will develop a drill through page allowing report users to see detail data for a state-province.

The completed report page will look like the following:

![ws name.](media/Q12.png)
 
1. Create a new report page by duplicating the **Sale Chord** page.

2. Rename the new page as **State-Province Details**.

   ![ws name.](media/8.31.png)
 
3. Remove the slicer and chord visual.
 
4. From the **Fields** pane, in the **Geography** table, drag the **State-Province** field to the **Drill Through** section (beneath the **Visualizations** pane), into the well.

   ![ws name.](media/8.32.png)
 
5. Apply a filter to the first state, **Alabama**.

   ![ws name.](media/8.33.png)
 
   *The filter will be applied when the report user drills through. You applied this filter now to help design the page for a single state.*
   
6. At the top-left of the report page, notice the back arrow button.

   *The button was added automatically when you added a drill through filter. It allows report users to navigate back to where they drilled.*
   
7. Select the button, and the in the **Visualizations** pane, turn the **Background** off.

   ![ws name.](media/8.34.png)
 
8. Add a multi-row card visual to the report page.

   ![ws name.](media/8.35.png)
 
9. Position and size the multi-row card visual at the top-left of the report page.

   ![ws name.](media/8.36.png)
 
10. Add the following five fields to the multi-row card visual:

    -	**Geography** table **State-Province** field
    -	**Sale** table **Quantity** field
    -	**Sale** table **Sale per capita** field
    -	**Sale** table **Sale Amount** field
    -	**Sale** table **Profit Amount** field
    -	**Product** table **Profit % All Geography** field

11. Apply the following formats:

    -	In the **Data Labels** section, set the **Text Size** to **16** pt.
    -	In the **Card Title** section, set the **Text Size** property to **20** pt.
    -	Turn **Shadow** on.

    ![ws name.](media/Q13.png)
   
    *If the card values form more than one column, reduce the width of the multi-row card visual*
 
12. Add a line and clustered column chart visual to the report page.

    ![ws name.](media/8.38.png)
 
13. Position the line and clustered column visual at the right of the slicer, and resize it to fill the remaining page space.

    ![ws name.](media/8.39.png)
 
14. Configure the following field mappings:

    -	**Shared Axis: Date** table **Month** field
    -	**Column Values: Sale** table **Sale Amount** field

    ![ws name.](media/8.40.png)
 
15. To add a report-level measure, in the **Fields** pane, right-click the **Sale** table, and then select **New Measure**.

    ![ws name.](media/8.41.png)
 
    *A report-level measure can be added by the report author. It allows them to define complex summarization logic that’s not already defined in the model.*
    
16. In the formula bar, enter the following measure definition:

    ```
      DAX
        Profit Margin =
        DIVIDE(
		SUM(Sale[Profit Amount]),
	   	SUM(Sale[Sale Amount])
       )
       ```
    *The measure is named **Profit Margin**. The formula divides the sum of the **Profit Amount** column by the sum of the **Sale Amount** column.*
 
17. On the **Measure Tools** contextual ribbon tab, set the format to percentage.

    ![ws name.](media/8.43.png)
 
18. Add the **Profit Margin** measure to the **Line Values** well of the line and clustered column visual.

    ![ws name.](media/Q14.png)
 
19. Format the line and clustered column visual to add shadow.

    *The design of the drill through page is now complete.*

20. Right-click the **State-Province Details** page tab, and then select **Hide Page**.

    ![ws name.](media/8.45.png)
 
    *Report users won’t see the page tab, but they’ll be able to drill through to the page. You’ll now test the drill through experience.*
 
### **Subtask 2: Explore Drill Through**

In this task, you will explore the drill through experience.

1. Select the **Sale Analysis** page.

2. Ensure the **Year** slicer is set to **CY2012**.

3. In the table visual, right-click any state, and then select **Drill Through > State-Province Details**.

   ![ws name.](media/8.46.png)
 
   *Drill through is available from any report visual that groups by the State-Province field.*
   
4. In the drill through page, notice the state you drilled from is the title of the multi-row card visual.

   ![ws name.](media/8.47.png)
 
5. Hover the cursor over the top-left corner of the line and clustered column chart visual, and then hover over the filter (funnel) icon.

   ![ws name.](media/8.48.png)
 
   *The tooltip reveals all applied filters.*

6.  Notice that the **Year** slicer value was passed to the drill through page, too.

7.  To return back to where you drilled from, at the top-left corner, while pressing the **Ctrl** key, click the back button.
    
    *When editing a report, you must press the **Ctrl** key when clicking buttons. If you don’t press the **Ctrl** key, the designer understands you’re selecting it so it can be configured.*
   
8. Save the Power BI Desktop solution.

## **Task 3: Work with Bookmarks**

In this exercise, you will superimpose visuals on the drill through page. You’ll then create bookmarks and assign them to buttons. This design will allow the report user to determine which visual to display.

### **Subtask 1: Create a New Visual**

In this task, you will add a new visual to the drill through page.

1. Select the **State-Province Details** page.

2. Select the line and clustered column chart visual.

3. To clone the visual, press **Ctrl+C**, and then press **Ctrl+V**.

   *Tip: Copy and paste commands are also available on the **Home** ribbon tab.*

4. Position the cloned visual precisely over the top of the original visual.

5. Modify the top visual field **Shared Axis** field mappings by removing the **Month** field, and then replacing it with the **Salesperson** table **Employee** field.

   ![ws name.](media/8.49.png)
 
6. Format the visual data color by setting the **Default Color** to purple.

   ![ws name.](media/8.50.png)
 
### **Subtask 2: Create Bookmarks**

In this task, you will create two bookmarks to show or hide the superimposed visuals.

1. On the **View** ribbon tab, from inside the **Show Panes** group, select **Bookmarks** and **Selection**.

   ![ws name.](media/8.51.png)
 
2. In the **Selection** pane, notice there are two similarly named report elements.

   ![ws name.](media/8.52.png)
 
3. Hover the cursor over each to reveal a tooltip describing their full title.

4. Notice that one ends in “by Month”, and the other ends in “by Salesperson”.

5. Determine which of the visuals groups by salesperson, and then click the **Hide** icon.

   ![ws name.](media/8.53.png)
 
6. Verify that the “by Month” visual is now visible.

7. In the **Bookmarks** pane, click **Add**.

   ![ws name.](media/8.54.png)
 
8. To rename the bookmark, double-click **Bookmark 1**.

9. Rename the bookmark as **By Month**, and then press **Enter**.

10. Click the ellipsis at the right of the bookmark, and then select **Data**.

    ![ws name.](media/8.55.png)
 
    *By selecting Data, you’re disabling the bookmark from capturing any applied filters. It means that when the bookmark is applied, it’ll use the filters applied by the report user.*
    
11. Click the ellipsis again, and then select **Update**.

    ![ws name.](media/8.56.png)
 
12. In the **Selection** pane, unhide the "by salesperson" visual, and then hide the “by month” visual.

13. Create a second bookmark, and then name it **By Salesperson**.

14. Configure the bookmark to not override filters (turn off **Data**), and then update the bookmark.

15. Verify there are two bookmarks.

    ![ws name.](media/8.57.png)
 
16. Close the **Selection** pane.

    ![ws name.](media/8.58.png)
 
17. Close the **Bookmarks** pane.

    ![ws name.](media/8.59.png)
 
### **Subtask 3: Add Buttons**

In this task, you will add two buttons to the report page, and then configure each to select a bookmark.

1. On the **Insert** ribbon tab, from inside the **Elements** group, click **Buttons**, and then select **Blank**.

   ![ws name.](media/8.60.png)

2. Position and size the button so that it is directly beneath the multi-row card visual and it is the same width.

   ![ws name.](media/8.61.png)
 
3. In the **Visualizations** pane, apply the following button formats:

   -	Set the **Button Text** section to **On**.
   -	Expand the **Button Text** section, and then set the **Button Text** to **By Month**.
   -	Set the button text **Font Color** to **Black**.
   -	Set the button text **Text Size** to **16** pt.
   -	Set the **Fill** section to **On**.
   -	Set the fill **Fill Color** to **Blue**.
   -	Set the **Shadow** section to **On**.
   -	Set the **Action** section to **On**.
   -	Set the action **Type** to **Bookmark**.
   -	Set the action **Bookmark** to **By Month**.

4. Clone(Copy and paste) the button, and then position it directly beneath the first button.

   ![ws name.](media/8.62.png)
 
5. Modify the button formats, as follows:

   -	Set the **Button Text** to **By Salesperson**.
   -	Set the fill **Fill Color** to **Purple**.
   -	Set the action **Bookmark** to **By Salesperson**.
 
6. Verify that the buttons looks like the following:
 
   ![ws name.](media/8.63.png)
 
7. Test each button by pressing the **Ctrl** key and clicking a button.

## **Task 4: Publish the Report**

In this exercise, you will prepare the report for publication, and then publish it to Power BI.


### **Subtask 1: Prepare the Report**

In this task, you will prepare the report for publication.

1. On the **State-Province Details** page, ensure the **By Month** visual is displayed.

2. Select the **Sale Analysis** page.

3. Ensure the **Year** slicer is set to **CY2012**.

   *It’s important to select the initial page and reset filters just before publishing the report. It will become the report state when report users first open the report.*

4. Save the Power BI Desktop solution as **Sale Report**.

### **Subtask 2: Publish the Report**

In this task, you will publish the report to Power BI.

1. On the **Home** ribbon tab, from inside the **Share** group, click **Publish**.

   ![ws name.](media/8.64.png)

2. If prompted to save changes, click **Yes**.

3. In the **Publish to Power BI** window, select the lab workspace (do not use **My Workspace**).

4. Click **Select**.

   ![ws name.](media/8.65.png)
 
5. When publication has completed, click **Got It**.

6. Close Power BI Desktop.

### **Subtask 3: Review the Published Dataset**

In this task, you will review the published dataset.

1. In the Power BI web browser session, open your lab workspace.

2. In the **Navigation** pane, notice the addition of the **US Sale Analysis** dataset.

   ![ws name.](media/Q15.png)
	
3. In the **Navigation** pane, hover the cursor over the **US Sale Analysis** dataset, and when the ellipsis appears click it, select **View Lineage**.	
	
   ![ws name.](media/Q16.png)
	
4. In the lineage view diagram, notice the two sources which contribute to the **US Sale Analysis** dataset.
		
   ![ws name.](media/Q17.png)	
	
   *Your new **US Sale Analysis** dataset comprises two data connections: Web and Analysis Services. Note that the Analysis Services connection is used by Power BI to connect to the Power BI dataset*

5. To open the report, in the **Navigation** pane, click the **US Sale Analysis** report.

6. In the report viewer, beneath the menu bar, notice the error message that describes that the web data source is missing credentials.

   ![ws name.](media/Q18.png)	
	
   *The **US State Population** table is loaded from a web page, which requires that a gateway be setup. It’s not possible to create or view a report in the Power BI service until the gateway is installed and the web connector credentials applied.
In the next section, you will install a gateway in personal mode, and then apply data source credentials. This section of the lab is optional. However, you must complete this section if you’re to explore the report later in that section.
*
## **Task 5: Install the Gateway (Optional)**

In this section, you will install a gateway and configure the US Sale Analysis dataset data source credentials.

*Important: If you’re using the lab VM, it is possible to complete this lab. If you’re using your own machine, you can only install the gateway if you’re using a 64-bit operating system and policy allows installing this software. If you have already installed a personal gateway on your machine, you will need to uninstall it first.*

### **Subtask 1: Install the Gateway**

In this task, you will install the Power BI gateway in personal mode.

1. In the Power BI web browser session, at the top-right, click the download icon (down-pointing arrow), and then select **Data Gateway**.

   ![ws name.](media/Q19.png)
	
   *A new web browser tab opens to the Power BI gateway page.*
	
2. In the Power BI gateway web page, click **Download Personal Mode**.	
	
   ![ws name.](media/Q20.png)
	
   *There are two types of gateway: The standard gateway and gateway in personal mode. For the data analyst, it can be appropriate to install the gateway in personal mode. Note that if you configured scheduled data refresh, you would need to ensure your machine is running and connected to the Internet for the refresh to succeed.*
	
3.  When the installer software downloads, open it.
		
    ![ws name.](media/Q21.png)	
	
4. In the gateway setup window, check the acceptance checkbox, and then click **Install**.

   ![ws name.](media/Q22.png)	

5. When prompted to enter an email address, enter your lab Azure account.

6. Click Sign In.

   ![ws name.](media/Q23.png)	

7. Complete the sign in process by entering your password.

8. When the gateway installation and setup has completed, click **Close**.

9. Close the Power BI gateway web page.

   *The gateway is now setup and running. In the next task, you will assign the gateway to the **US Sale Analysis** dataset and configure data source credentials.*
	
### **Subtask 2: Configure Dataset Settings**

In this task, you will configure the **US Sale Analysis** dataset settings.

1. In the Power BI web browser session, in the **Navigation** pane, hover the cursor over the **US Sale Analysis** dataset, and when the ellipsis appears click it, select **Settings**.
	
   ![ws name.](media/Q24.png)	
	
2. In the **Data Source Credentials** section, read the messages.

   *Credentials must be set for only the Web connection. There is no need to set credentials for the connection to the **Sale Analysis** dataset.*
	
3. For the **Web** connection, click **Edit Credentials**.

   ![ws name.](media/Q25.png)
	
4. In the window, in the **Privacy Level Settings** dropdown list, select **Public**.

   *Privacy levels allows Power Query to determine the most efficient, yet secure way, to refresh data when combining data from multiple data sources. In your model, Power Query is not used to combine data.*
	
5. Click **Sign In**.

   ![ws name.](media/Q26.png)
	
   *It’s now possible to perform and schedule data refresh for your model. You won’t do that in this lab.*
	
6. To test the dataset, in the **Navigation** pane, click the **US Sale Analysis** report.

7. Notice that it is now possible to see the report data and interact with the report.

### **Subtask 3: Explore the Report**

In this task, you will explore the report to determine root cause for low-profit earning state.

1. In the **Navigation** pane, click the **US Sale Analysis**.

2. At the left, notice there are only two pages.

   ![ws name.](media/8.66.png)
 
   *Recall that the drill through page was hidden.*
   
3. Set the **Year** slicer to **CY2014**.

   *Understand that the page refreshed quickly because Power BI is querying an aggregation that you created in **Exercise 07**.*
	
4. To see low-sale per capita states, modify the table sort to **Sale per Capita** ascending.

5. To understand **Tennessee** sales in more detail, right-click **Tennessee**, and then drill through to the details page.

6. Review the monthly sales.

7. Click the **By Salesperson** button, and then review the result by salespeople.

   *The lab is now complete.*

### Summary

In this exercise, you used Power BI Desktop to continue the development of the solution created in **Exercise 07**. You authored a multi-page report that includes synced slicers, a custom visual, page drill through, a measure, bookmarks, and buttons. You then finalized the exercise by publishing the report to the Power BI service.
In order to explore and interact with the report in the Power BI service, you had the opportunity to install a gateway.
