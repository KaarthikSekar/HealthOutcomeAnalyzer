-- CREATE WAREHOUSE IF NOT EXISTS nhanes_wh
--     WAREHOUSE_SIZE = 'X-SMALL'
--     AUTO_SUSPEND = 60
--     AUTO_RESUME = TRUE;

-- CREATE DATABASE IF NOT EXISTS nhanes_db;
-- CREATE SCHEMA IF NOT EXISTS nhanes_db.raw;

-- USE DATABASE NHANES_DB;
-- USE SCHEMA RAW;

-- CREATE OR REPLACE TABLE DEMOGRAPHICS (
--     SEQN     FLOAT,
--     RIDAGEYR FLOAT,
--     RIAGENDR FLOAT,
--     RIDSTATR FLOAT,
--     RIDRETH1 FLOAT,
--     RIDRETH3 FLOAT
-- );

-- CREATE OR REPLACE TABLE DIET (
--     SEQN     FLOAT, 
--     DR1TKCAL FLOAT, 
--     DR1TPROT FLOAT,
--     DR1TCARB FLOAT, 
--     DR1TSUGR FLOAT, 
--     DR1TFIBE FLOAT,
--     DR1TTFAT FLOAT, 
--     DR1TSODI FLOAT
-- );

-- CREATE OR REPLACE TABLE EXAMINATION (
--     SEQN   FLOAT, 
--     BPXSY1 FLOAT, 
--     BPXDI1 FLOAT,
--     BMXBMI FLOAT, 
--     BMXWT  FLOAT, 
--     BMXHT  FLOAT
-- );

-- CREATE OR REPLACE TABLE LABS (
--     SEQN  FLOAT, 
--     LBXGH FLOAT
-- );


SELECT 'DEMOGRAPHICS' AS table_name, COUNT(*) AS row_count FROM DEMOGRAPHICS
UNION ALL
SELECT 'DIET',        COUNT(*) FROM DIET
UNION ALL
SELECT 'EXAMINATION', COUNT(*) FROM EXAMINATION
UNION ALL
SELECT 'LABS',        COUNT(*) FROM LABS;


CREATE OR REPLACE TABLE NHANES_FINAL AS
SELECT 
    d.SEQN,
    d.RIDAGEYR    AS age,
    d.RIAGENDR    AS gender,
    d.RIDRETH1    AS ethnicity,
    di.DR1TSODI   AS sodium_mg,
    di.DR1TFIBE   AS fiber_g,
    di.DR1TSUGR   AS sugar_g,
    di.DR1TKCAL   AS calories,
    di.DR1TPROT   AS protein_g,
    di.DR1TTFAT   AS fat_g,
    e.BPXSY1      AS systolic_bp,
    e.BPXDI1      AS diastolic_bp,
    e.BMXBMI      AS bmi,
    e.BMXWT       AS weight_kg,
    e.BMXHT       AS height_cm,
    l.LBXGH       AS hba1c,
    CASE 
        WHEN e.BPXSY1 >= 130 OR e.BPXDI1 >= 80   
        THEN 1 ELSE 0 
    END AS hypertension_flag,
    CASE 
        WHEN e.BMXBMI < 18.5 THEN 'Underweight'
        WHEN e.BMXBMI < 25   THEN 'Normal'
        WHEN e.BMXBMI < 30   THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    CASE 
        WHEN l.LBXGH >= 6.5 THEN 1 ELSE 0        
    END AS diabetes_flag
FROM DEMOGRAPHICS d
JOIN DIET        di ON d.SEQN = di.SEQN
JOIN EXAMINATION e  ON d.SEQN = e.SEQN
JOIN LABS        l  ON d.SEQN = l.SEQN;


SELECT COUNT(*) FROM NHANES_FINAL;
SELECT hypertension_flag, COUNT(*) FROM NHANES_FINAL GROUP BY 1;

SELECT diabetes_flag, COUNT(*) FROM NHANES_FINAL GROUP BY 1;
SELECT bmi_category, COUNT(*) FROM NHANES_FINAL GROUP BY 1 ORDER BY 2 DESC;