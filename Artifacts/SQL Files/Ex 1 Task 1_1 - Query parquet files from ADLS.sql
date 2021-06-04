SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://azsynapseaiddl.dfs.core.windows.net/wwi/factsale-parquet/2012/Q1/InvoiceDateKey=2012-01-01/part-00007-82fb0c25-17e0-4fc1-8f67-dd23466240a5.c000.snappy.parquet',
        FORMAT='PARQUET'
    ) AS [result]


SELECT
   COUNT(*)
FROM
    OPENROWSET(
        BULK 'https://azsynapseaiddl.dfs.core.windows.net/wwi/factsale-parquet/2012/Q1/InvoiceDateKey=2012-01-01/part-00007-82fb0c25-17e0-4fc1-8f67-dd23466240a5.c000.snappy.parquet',
        FORMAT='PARQUET'
    ) AS [result]
