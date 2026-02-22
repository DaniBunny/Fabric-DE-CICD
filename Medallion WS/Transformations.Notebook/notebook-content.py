# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "be4539ba-28af-45fc-aa0b-ed6bb617a89e",
# META       "default_lakehouse_name": "Lakehouse_Silver",
# META       "default_lakehouse_workspace_id": "cc9468fb-af0f-45e6-9b77-53231caa838d",
# META       "known_lakehouses": [
# META         {
# META           "id": "3ace3676-f9b1-4423-82b6-ac293f9504a4"
# META         },
# META         {
# META           "id": "be4539ba-28af-45fc-aa0b-ed6bb617a89e"
# META         }
# META       ]
# META     },
# META     "environment": {}
# META   }
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC 
# MAGIC CREATE OR REPLACE TABLE Lakehouse_Silver.dbo.t5 AS
# MAGIC SELECT 
# MAGIC     t1.AGE,
# MAGIC     t1.SEX,
# MAGIC     t1.BMI,
# MAGIC     t1.countryOrRegion,
# MAGIC     t3.holidayName,
# MAGIC     CURRENT_TIMESTAMP() as created_timestamp
# MAGIC FROM Lakehouse_Silver.dbo.t1 t1
# MAGIC INNER JOIN Lakehouse_Silver.dbo.t3 t3 ON t1.countryOrRegion = t3.countryOrRegion;
# MAGIC 
# MAGIC -- Validate new table t5
# MAGIC SELECT COUNT(*) as t5_record_count FROM Lakehouse_Silver.dbo.t5;
# MAGIC SELECT * FROM Lakehouse_Silver.dbo.t5 LIMIT 5;

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC 
# MAGIC create table dbo.t1 using DELTA as (
# MAGIC     select * from t2 full outer join t3 limit 10000
# MAGIC ) 

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC 
# MAGIC optimize dbo.t1 vorder

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# MAGIC %%sql
# MAGIC 
# MAGIC select age, countryOrRegion, count(1) as total from dbo.t1 group by age, countryOrRegion sort by 3 desc

# METADATA ********************

# META {
# META   "language": "sparksql",
# META   "language_group": "synapse_pyspark"
# META }
