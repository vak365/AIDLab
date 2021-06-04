DROP TABLE [wwi].[SampleData]; 


CREATE TABLE [wwi].[SampleData] 
(
    [customerkey] REAL, 
    [stockitemkey] REAL
);


INSERT INTO [wwi].[SampleData] ([customerkey], [stockitemkey])
VALUES ( 11, 1 );


SELECT * FROM [wwi].[SampleData];


