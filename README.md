# Diet & Health Outcome Analyzer
### End-to-End Healthcare Analytics using CDC NHANES Data on Snowflake

---

## Project Overview

This project is an end-to-end healthcare analytics solution built on Snowflake using the 
CDC NHANES (National Health and Nutrition Examination Survey) 2017–2018 dataset.

The objective was to explore how daily dietary habits impact chronic health outcomes 
such as hypertension, obesity and diabetes — through data engineering, exploratory 
data analysis, statistical hypothesis testing and machine learning.

<img width="1220" height="673" alt="Screenshot 2026-06-19 at 3 34 20 PM" src="https://github.com/user-attachments/assets/35e25189-4c9e-49f2-8404-a25cea843abd" />

<img width="1220" height="673" alt="Screenshot 2026-06-19 at 3 34 37 PM" src="https://github.com/user-attachments/assets/2e1454d7-5b60-496a-93b8-9bcbce0e04c3" />

<img width="1220" height="673" alt="Screenshot 2026-06-19 at 3 34 32 PM" src="https://github.com/user-attachments/assets/18fcdc4b-e692-4752-a4b5-ca333f031b26" />


---

## Dataset

**Source:** CDC NHANES 2017–2018  
**Participants:** 19,626 adults  
**Link:** https://wwwn.cdc.gov/nchs/nhanes/

Four NHANES files merged into one analytical dataset:

| File | Contents |
|---|---|
| Diet | Calories, sodium, fiber, protein, fat, sugar |
| Demographics | Age, gender, ethnicity |
| Examination | Blood pressure, BMI, weight, height |
| Laboratory | HbA1c (diabetes marker) |

---

## Tech Stack

| Layer | Tools |
|---|---|
| Data Platform | Snowflake, Snowflake Notebooks, Virtual Warehouses |
| Data Engineering | SQL |
| Analysis & Statistics | Python, Pandas, SciPy |
| Machine Learning | Scikit-learn |
| Visualization | Matplotlib, Power BI |

---

## Project Workflow

### 1. Data Engineering (warehouse.sql)
- Loaded 4 raw NHANES CSV files into Snowflake tables
- Merged all 4 tables using SQL JOIN on participant ID (SEQN)
- Engineered 3 derived columns directly in SQL:
  - **Hypertension Flag** — Systolic BP ≥ 130 or Diastolic BP ≥ 80
  - **Diabetes Flag** — HbA1c ≥ 6.5%
  - **BMI Category** — Underweight / Normal / Overweight / Obese

---

### 2. Exploratory Data Analysis (eda.ipynb)

Key findings from 19,626 participants:

- **57.5%** exceed the recommended daily sodium limit of 2,300mg
- Average sodium intake: **3,178mg/day** (38% above the limit)
- Average fiber intake: **15.28g/day** (recommended is 25–38g)
- Average daily calories: **1,964**

**BMI Distribution:**
| Category | Count | % |
|---|---|---|
| Obese | 6,210 | 31.6% |
| Normal | 5,604 | 28.6% |
| Overweight | 4,198 | 21.4% |
| Underweight | 3,614 | 18.4% |

**Average Macro Split:**
| Macro | % of Calories |
|---|---|
| Carbohydrates | 50.42% |
| Fat | 34.40% |
| Protein | 15.18% |

---

### 3. Statistical Hypothesis Testing (stats.ipynb)

5 formal tests conducted using SciPy:

| # | Test | Hypothesis | p-value | Result |
|---|---|---|---|---|
| 1 | T-test | Sodium differs between hypertension groups | 0.013 | ✅ Significant |
| 2 | T-test | High sodium affects BMI | 0.682 | ❌ Not Significant |
| 3 | ANOVA | BMI differs across age groups | <0.001 | ✅ Significant |
| 4 | Chi-square | High sodium linked to hypertension | 0.001 | ✅ Significant |
| 5 | T-test | Obese people eat less fiber | <0.001 | ✅ Significant |

**4 out of 5 tests confirmed statistically significant diet-health relationships.**

---

### 4. Machine Learning (mlmodel.ipynb)

**Target:** Predict hypertension risk (binary classification)

**Features used:** Sodium, Calories, Fiber, BMI, Age, Protein, Fat, Gender, Ethnicity, Weight, Height

**3 models compared:**

| Model | Accuracy | Precision | Recall | F1 Score | AUC |
|---|---|---|---|---|---|
| Random Forest | 77.20% | 58.27% | 88.08% | 70.14% | 88.40% |
| Gradient Boosting | 77.16% | 64.91% | 54.17% | 59.05% | 84.62% |
| Logistic Regression | 74.98% | 56.13% | 81.02% | 66.32% | 82.54% |

**Winner: Random Forest** — highest AUC (88.40%) and Recall (88.08%)

**Note on overfitting:**  
Initial Random Forest showed 100% training accuracy vs 93.5% test accuracy — 
a 6.47% gap indicating overfitting. Fixed by applying max_depth=10 and 
min_samples_leaf=5, reducing the gap to 4.06%.

**Class imbalance:**  
Dataset has mild imbalance (79% No Hypertension / 21% Hypertension). 
Handled using class_weight='balanced' across all models.

**Top predictors of hypertension:**
1. Age
2. Weight
3. Fiber intake
4. BMI
5. Calories

---

## Snowflake Components Used

This project was developed entirely within Snowflake:
- Snowflake Tables
- SQL Worksheets
- Virtual Warehouse
- Snowflake Notebooks
- Python Runtime Environment

No data was moved across platforms — engineering, analysis, statistics 
and machine learning all run within Snowflake.

---

## Power BI Dashboard

3 page interactive dashboard built in Power BI:

- **Page 1 — Overview:** KPI cards, hypertension distribution, BMI breakdown, age group distribution, macro split
- **Page 2 — Diet vs Health Stats:** Hypothesis results table, fiber vs obesity, BMI across age groups, sodium vs hypertension scatter plot  
- **Page 3 — ML Dashboard:** Model comparison, confusion matrix, feature importance

---

## Key Takeaways

- 57.5% of Americans consume more sodium than the safe daily limit
- Obese individuals eat significantly less fiber — statistically proven
- BMI increases significantly with age across all groups
- Hypertension is multifactorial — age and weight matter more than sodium alone
- Diet data combined with physical measurements can predict hypertension risk

---

## Repository Structure

```text
.
├── warehouse.sql       ← Snowflake setup, SQL joins, feature engineering
├── eda.ipynb           ← Exploratory data analysis and visualizations  
├── stats.ipynb         ← Statistical hypothesis testing
├── mlmodel.ipynb       ← Machine learning models and evaluation
└── README.md
```

---

## Dataset Citation

Centers for Disease Control and Prevention (CDC). National Health and Nutrition 
Examination Survey Data. Hyattsville, MD: U.S. Department of Health and Human 
Services, 2017-2018. Available at: https://wwwn.cdc.gov/nchs/nhanes/
