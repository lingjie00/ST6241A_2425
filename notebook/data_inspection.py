import os
from pathlib import Path

import numpy as np
import pandas as pd

pd.set_option("display.max_columns", None)
pd.set_option("display.max_rows", 1000)

ROOT_DIR = Path(".")

# %%


# # Inspect data
median_income_data = pd.read_csv(
    ROOT_DIR
    / "data"
    / "raw_data"
    / "MedianGrossMonthlyIncomeFromEmploymentofFullTimeEmployedResidentsTotal.csv"
)
median_income_data.describe()
median_income_data.info()
median_income_data.head()

median_income_data.describe()

# CPF is a compuslory saving scheme in Singapore
# we consider the median income including CPF as this is standard reporting in Singapore
median_income_data["income"] = median_income_data["med_income_incl_empcpf"]
median_income_data["income_diff"] = median_income_data["med_income_incl_empcpf"].diff()
median_income_data["income_log"] = np.log(median_income_data["med_income_incl_empcpf"])
median_income_data["income_log_diff"] = median_income_data["income_log"].diff()
median_income_data = median_income_data.drop(
    columns=["med_income_excl_empcpf", "med_income_incl_empcpf"]
)
median_income_data = median_income_data.dropna()
median_income_data

# %%

resale_price = pd.concat(
    [
        pd.read_csv(ROOT_DIR / "data" / "raw_data" / fpath)
        for fpath in filter(
            lambda x: "resale" in x.lower(),
            os.listdir(ROOT_DIR / "data" / "raw_data"),
        )
    ]
)
resale_price["month"] = pd.to_datetime(resale_price["month"])
resale_price.info()
resale_price.head()


resale_price.describe()

# %%


# observe if the housing price is available for every single month data
# note how some the longest data available is 96 months while shortest is 1 month
resale_price.groupby(
    ["town", "flat_type", "block", "street_name", "storey_range", "flat_model"]
)[["month"]].nunique().describe()

resale_price.query("town == 'BUKIT TIMAH'").groupby(
    ["town", "flat_type", "block", "street_name", "storey_range", "flat_model"]
)[["month"]].nunique().describe()


# only at the town level then we observe relatively similar number of months available
resale_price.groupby(["town"])[["month"]].nunique()


# to avoid the imbalance data, we will only model the time series at the town level using average resale price
resale_price = (
    resale_price.groupby(["town", "month"])[["resale_price"]]
    .mean()
    .reset_index()
    .round()
)
# calculate the difference between the current month and the previous month
resale_price["price_diff"] = resale_price.groupby("town")["resale_price"].diff()
resale_price["price_log"] = np.log(resale_price["resale_price"])
resale_price["price_log_diff"] = resale_price.groupby("town")["price_log"].diff()
resale_price = resale_price.dropna()
resale_price


# # Train test split
#
# To avoid data leakage, even in the visualisation step, we split the data into training and testing set.
# Final model comparision will be based on the test set while model training and tuning will be done on training set.
#
# We save 2023 data for testing while using 2001 to 2022 as training.

median_income_data_train = median_income_data[median_income_data["year"] < 2023]
median_income_data_test = median_income_data[median_income_data["year"] >= 2023]


resale_price_train = resale_price[resale_price["month"] < "2023-01-01"]
resale_price_test = resale_price[resale_price["month"] >= "2023-01-01"]


# export
median_income_data_train.to_csv(
    ROOT_DIR / "data" / "median_income_data_train.csv", index=False
)
median_income_data_test.to_csv(
    ROOT_DIR / "data" / "median_income_data_test.csv", index=False
)
resale_price_train.to_csv(ROOT_DIR / "data" / "resale_price_train.csv", index=False)
resale_price_test.to_csv(ROOT_DIR / "data" / "resale_price_test.csv", index=False)

# %%
# Export as matrix
# For R functions, they expect the data to be stored as matrix
# We save the log diff as
resale_price_log_diff_train = resale_price_train.pivot(
    columns="town", index="month", values="price_log_diff"
).dropna()
resale_price_log_diff_train.head()
resale_price_log_diff_train.to_csv(
    ROOT_DIR / "data" / "resale_price_log_diff_train.csv", index=True
)
resale_price_log_diff_test = resale_price_test.pivot(
    columns="town", index="month", values="price_log_diff"
).dropna()
resale_price_log_diff_test.head()
resale_price_log_diff_test.to_csv(
    ROOT_DIR / "data" / "resale_price_log_diff_test.csv", index=True
)

# %%
# merge the median income data with resale price data
resale_price_yearly = (
    resale_price.assign(year=resale_price["month"].dt.year)
    .groupby(["year"])[["resale_price"]]
    .mean()
    .reset_index()
    .round()
)
resale_price_yearly["price_log"] = np.log(resale_price_yearly["resale_price"])
resale_price_yearly["price_log_diff"] = resale_price_yearly["price_log"].diff()
resale_price_yearly = resale_price_yearly.dropna()
resale_price_yearly = resale_price_yearly.merge(
    median_income_data[["year", "income_log_diff"]], on="year"
)
resale_price_yearly = resale_price_yearly[["year", "price_log_diff", "income_log_diff"]]
resale_price_yearly.info()
resale_price_yearly.head()

# %%
resale_price_yearly.query("year < 2023").to_csv(
    ROOT_DIR / "data" / "resale_price_yearly_train.csv", index=False
)
resale_price_yearly.query("year >= 2023").to_csv(
    ROOT_DIR / "data" / "resale_price_yearly_test.csv", index=False
)
