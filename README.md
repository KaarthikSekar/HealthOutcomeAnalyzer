# End-to-End Healthcare Analytics on Snowflake Using NHANES Data

## Project Overview

This project is an end-to-end healthcare analytics solution built entirely on Snowflake using the CDC NHANES (National Health and Nutrition Examination Survey) 2017–2018 dataset.

The objective was to explore the relationship between dietary habits and health outcomes such as hypertension, obesity, and diabetes through data engineering, exploratory data analysis, statistical hypothesis testing, and machine learning.

A key goal of this project was to gain hands-on experience with Snowflake and understand how modern cloud-native analytics workflows can be performed within a single platform.

---

## Dataset

**Source:** CDC NHANES 2017–2018

The project integrates data from four NHANES datasets:

- Diet Data
- Demographics Data
- Examination Data
- Laboratory Data

These datasets were merged using participant identifiers to create a unified analytical dataset for downstream analysis and modeling.

---

## Tech Stack

### Data Platform
- Snowflake
- Snowflake Notebooks
- Virtual Warehouses

### Data Engineering
- SQL

### Data Analysis & Statistics
- Python
- Pandas
- SciPy

### Machine Learning
- Scikit-Learn
  - Random Forest Classifier
  - Model Evaluation
  - Feature Importance Analysis

### Visualization
- Matplotlib

---

## Project Workflow

### 1. Data Engineering

- Loaded raw NHANES datasets into Snowflake tables
- Merged datasets using SQL joins on participant IDs
- Performed data cleaning and preprocessing
- Engineered analytical features directly in SQL

Features created:

- Hypertension Flag
- Diabetes Flag
- BMI Category

---

### 2. Exploratory Data Analysis

Exploratory analysis was conducted using SQL and Snowflake Notebooks to understand participant demographics, dietary patterns, and health outcomes.

#### Key Findings

- 74.8% of participants exceeded the recommended daily sodium intake of 2,300 mg
- Average macronutrient distribution:
  - Carbohydrates: 50.5%
  - Fat: 33.8%
  - Protein: 15.7%
- Obesity was the largest BMI category, representing 31.6% of participants

---

### 3. Statistical Analysis

Statistical hypothesis testing was performed using Python and SciPy within Snowflake Notebooks.

#### Tests Conducted

- Independent T-Test
- One-Way ANOVA
- Chi-Square Test

#### Findings

- BMI differs significantly across age groups
- Obese participants consume significantly less fiber
- Sodium intake alone was not a statistically significant predictor of hypertension

---

### 4. Machine Learning

A Random Forest Classifier was developed to predict hypertension risk.

#### Features Used

- Sodium Intake
- Calories
- Fiber
- BMI
- Age
- Protein
- Fat
- Gender
- Ethnicity
- Weight
- Height

#### Model Performance

| Metric | Value |
|----------|----------|
| Accuracy | 93.5% |
| Recall | 86% |

#### Top Predictors

1. BMI
2. Age
3. Weight

These variables were identified as the most influential features in predicting hypertension.

---

## Snowflake Components Used

This project was developed entirely within Snowflake using:

- Snowflake Tables
- SQL Worksheets
- Snowflake Virtual Warehouse
- Snowflake Notebooks
- Python Runtime Environment

This allowed data engineering, analytics, statistical testing, and machine learning workflows to be executed without moving data across platforms.

---

## Repository Structure

```text
.
├── warehouse.sql
├── eda.ipynb
├── stats.ipynb
├── mlmodel.ipynb
├── README.md
└── dashboard/
