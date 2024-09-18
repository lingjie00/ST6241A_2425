# ST6241A_2425
Project work for ST6241A, Aug 2024

## Project requirements

1. Summary (one-page)
    - Brief discussion of the problem addressed, a description of the finalmodel, and any conclusion drawn from the analysis
2. Body
    - Statement of the problem/hypothesis being entertained
    - Review of previous work done on the dataset
    - Description of the data used in analysis
    - Data cleaning steps and reason (e.g. outlier, level shift, interventions, etc), including the exoeneous variables used
    - Final model and justification for why it provides an adequate fit to the data
    - Forecasts using the model and comparision to actual values and forecasts of alternative models proposed in the literature
    - Relationship between the 2 dataset

## Repo structure

The original codes of Autofomer are from (thuml/Autoformer)[https://github.com/thuml/Autoformer].
We only tuned the hyperparameters listed in the report to train and predict the resale price.

We only listed the more important files in the repo.

```bash
.
├── data_generation_AF.ipynb # -> Generating the datasets suit for Autoformer model from the transformed resale datasets
├── project_resale_predict.ipynb # -> Results of training Autoformer and using the trained model to prediction
├── results_of_statistical_model.ipynb # -> Results and visulizations of statistical models
├── statistical_models
│  ├── asset # -> Assets of statistical models used in the final report, including plots and other visuals
│  ├── data # -> Data transformed and predictions in statistical modelling
│  ├── statistical_time_series.R # -> Building and testing the statistical models.
│  └── statistical_ts_models.Rmd # -> Predictions of the statistical models.
```


## Dataset

### Raw dataset

- [Singapore HDB resale price TS](https://data.gov.sg/collections/189/view)
    - Multivariate time series capturing Singapore's public housing resale price

### Transformed dataset

`dataset/resale_price` folder contains the transformed data for Autoformer model.

`statistical_models/data` folder contains the transformed data while `data/raw` contains the raw data.

We split data before 2023 as training data and data in 2023 as test data.
Suffixed with `_train` and `_test` respectively.

- resale price data (monthly x town)
    - `resale_price_train.csv`
    - `resale_price_test.csv`
- resale price data (monthly x town) with log difference in matrix form,
  required format by `R` models
    - `resale_price_log_diff_train.csv`
    - `resale_price_log_diff_test.csv`
- resale price data (yearly)
    - `resale_price_yearly_train.csv`
    - `resale_price_yearly_test.csv`

```bash
dataset/resale_price
├── median_income_data_test.csv
├── median_income_data_train.csv
├── resale_price_AF_test.csv
├── resale_price_AF_train.csv
├── resale_price_log_diff_test.csv
├── resale_price_log_diff_train.csv
├── resale_price_test.csv
├── resale_price_train.csv
├── resale_price_yearly_test.csv
└── resale_price_yearly_train.csv

statistical_models/data
├── median_income_data_test.csv
├── median_income_data_train.csv
├── raw_data
│  ├── MedianGrossMonthlyIncomeFromEmploymentofFullTimeEmployedResidentsTotal.csv
│  ├── ResaleFlatPricesBasedonApprovalDate2000Feb2012.csv
│  ├── ResaleFlatPricesBasedonRegistrationDateFromJan2015toDec2016.csv
│  ├── ResaleflatpricesbasedonregistrationdatefromJan2017onwards.csv
│  └── ResaleFlatPricesBasedonRegistrationDateFromMar2012toDec2014.csv
├── resale_price_log_diff_test.csv
├── resale_price_log_diff_train.csv
├── resale_price_test.csv
├── resale_price_train.csv
├── resale_price_yearly_test.csv
└── resale_price_yearly_train.csv
```

