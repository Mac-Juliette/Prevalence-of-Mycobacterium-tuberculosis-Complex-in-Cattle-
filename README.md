Prevalence of Mycobacterium tuberculosis Complex in Cattle Slaughtered in Yaoundé and Douala Abattoirs

This repository contains R scripts and supporting materials for analyzing the prevalence of Mycobacterium tuberculosis complex (MTBC) in cattle slaughtered at abattoirs in Yaoundé and Douala, Cameroon.  
The project combines descriptive, inferential, and visualization approaches to better understand MTBC epidemiology in livestock.


Analysis Outline
 1. Descriptive Statistics
- Summarize animal characteristics (sex, age, race, provenance).  
- Describe abattoir throughput (`Effectif_abbatu`) per day.  
- Report lesion/tissue types and observations.  

 2. Prevalence Estimation
- Primary prevalence: MTBC positivity among suspected animals.  
- Stratified prevalence: By abattoir, sex, age, race, tissue type, provenance.  
- Estimated overall prevalence: Approximate prevalence among all slaughtered animals = suspicion rate × positivity rate among suspects.  

3. Concordance Analysis
- Build 2×2 tables comparing 'Visual inspection' vs. 'Laboratory result'.  
- Calculate sensitivity, specificity, PPV, NPV.  
- Compute Cohen’s Kappa statistic for agreement.  
- Stratify concordance by abattoir and tissue type.  
4. Inferential Statistics
- Chi-square/Fisher’s tests for associations between predictors and MTBC positivity.  
- Logistic regression:  
  - Outcome:Result (Positive/Negative)  
  - Predictors: Visuel, Sexe, Âge, Race, Provenance, Site_abattage  

5. Visualization
- Bar plots: prevalence by site, sex, age group.  
- Line charts: trends over time.  

- Recommended packages:  
  - `tidyverse`  
  - `epiR`  
  - `caret`  
  - `ggplot2`  
  - `dplyr`  
  - `psych`  

 How to Use

1. Clone this repository:  
   ```bash
   git clone https://github.com/Mac-Juliette/Prevalence-of-Mycobacterium-tuberculosis-Complex-in-Cattle.git

