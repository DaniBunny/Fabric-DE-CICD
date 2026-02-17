-- Fabric notebook source

-- METADATA ********************

-- META {
-- META   "kernel_info": {
-- META     "name": "synapse_pyspark"
-- META   },
-- META   "dependencies": {
-- META     "lakehouse": {
-- META       "default_lakehouse": "a003166c-2062-4393-9b51-6ad35f879e1c",
-- META       "default_lakehouse_name": "Lakehouse_Silver",
-- META       "default_lakehouse_workspace_id": "ea04f522-3baa-4555-9dc5-9217ae1bdf40",
-- META       "known_lakehouses": [
-- META         {
-- META           "id": "a003166c-2062-4393-9b51-6ad35f879e1c"
-- META         }
-- META       ]
-- META     },
-- META     "environment": {
-- META       "environmentId": "f3d9683f-caf9-b133-4825-42b387580ce2",
-- META       "workspaceId": "00000000-0000-0000-0000-000000000000"
-- META     }
-- META   }
-- META }

-- CELL ********************

select count(*) from dbo.t3

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

select countryOrRegion, count(1) from dbo.t3 group by countryOrRegion

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

select count(*) as cu8 from dbo.t2

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

select count(*) from dbo.t1

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }
