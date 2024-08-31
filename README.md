# ST6241A_2425
Project work for ST6241A, Aug 2024

Project requries

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

# Dataset

- [Singapore HDB resale price TS](https://data.gov.sg/collections/189/view)
    - Multivariate time series capturing Singapore's public housing resale price
- [Singapore Median Income TS](https://beta.data.gov.sg/datasets/d_7b5fd60b047a80da91d2adb86cf47628/view)
    - Univariate time series capturing Singapore's median income growth

# Repo structure

- `notebook`: Notebooks used to produce the visuals
- `model`: Models built for the prediction
- `data`: Data transformed/used in modelling
- `asset`: Assets used in the final report, including plots and other visuals