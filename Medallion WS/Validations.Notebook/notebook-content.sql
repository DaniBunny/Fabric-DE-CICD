-- Fabric notebook source

-- METADATA ********************

-- META {
-- META   "kernel_info": {
-- META     "name": "synapse_pyspark"
-- META   },
-- META   "dependencies": {
-- META     "lakehouse": {
-- META       "default_lakehouse": "be4539ba-28af-45fc-aa0b-ed6bb617a89e",
-- META       "default_lakehouse_name": "Lakehouse_Silver",
-- META       "default_lakehouse_workspace_id": "cc9468fb-af0f-45e6-9b77-53231caa838d",
-- META       "known_lakehouses": [
-- META         {
-- META           "id": "be4539ba-28af-45fc-aa0b-ed6bb617a89e"
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
