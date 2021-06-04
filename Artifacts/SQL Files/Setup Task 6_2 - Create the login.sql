CREATE LOGIN [asa.sql.staging]
WITH PASSWORD = 'Temp1234'
GO


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

--Create user in DB
CREATE USER [az-synapse-aid-lab-ws] FROM EXTERNAL PROVIDER;

--Granting permission to the identity
GRANT CONTROL ON DATABASE::sqlpool01 TO [az-synapse-aid-lab-ws];