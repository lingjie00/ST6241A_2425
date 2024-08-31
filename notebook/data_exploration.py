from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

ROOT_DIR = Path(".")

data_dir = ROOT_DIR / "data"
resale_price = pd.read_csv(data_dir / "resale_price_train.csv")
resale_price["month"] = pd.to_datetime(resale_price["month"])
median_income = pd.read_csv(data_dir / "median_income_data_train.csv")
median_income["year"] = pd.to_datetime(median_income["year"], format="%Y")

# %%
# Resale Price data
resale_price.info()
resale_price.head()

resale_price.describe()

fig, axes = plt.subplots(2, 1, figsize=(10, 10))
sns.lineplot(data=resale_price, x="month", y="resale_price", hue="town", ax=axes[0])
axes[0].legend(loc="center left", bbox_to_anchor=(1.1, 0.1))
axes[0].set_title("TS of Resale Price by Town in Singapore")

sns.lineplot(data=resale_price, x="month", y="price_diff", hue="town", ax=axes[1])
# remove legend
axes[1].legend_.remove()
axes[1].set_title("TS of Resale Price Difference by Town in Singapore")

plt.tight_layout()
plt.savefig(ROOT_DIR / "asset" / "resale_price_ts.png")

fig, axes = plt.subplots(2, 1, figsize=(10, 10))
sns.lineplot(data=resale_price, x="month", y="price_log", hue="town", ax=axes[0])
axes[0].legend(loc="center left", bbox_to_anchor=(1.1, 0.1))
axes[0].set_title("TS of Log Resale Price by Town in Singapore")

sns.lineplot(data=resale_price, x="month", y="price_log_diff", hue="town", ax=axes[1])
# remove legend
axes[1].legend_.remove()
axes[1].set_title("TS of Log Resale Price Difference by Town in Singapore")

plt.tight_layout()
plt.savefig(ROOT_DIR / "asset" / "resale_price_log_ts.png")

fig, axes = plt.subplots(2, 2, figsize=(11, 5))
sns.lineplot(
    data=resale_price.query("town == 'BUKIT TIMAH'"),
    x="month",
    y="resale_price",
    hue="town",
    ax=axes[0][0],
)
axes[0][0].legend_.remove()
axes[0][0].set_title("TS of Resale Price (Bukit Timah) in Singapore")

sns.lineplot(
    data=resale_price.query("town == 'BUKIT TIMAH'"),
    x="month",
    y="price_log",
    hue="town",
    ax=axes[0][1],
)
axes[0][1].legend_.remove()
axes[0][1].set_title("TS of Log Resale Price (Bukit Timah) in Singapore")

sns.lineplot(
    data=resale_price.query("town == 'BUKIT TIMAH'"),
    x="month",
    y="price_diff",
    hue="town",
    ax=axes[1][0],
)
# remove legend
axes[1][0].legend_.remove()
axes[1][0].set_title("TS of Resale Price Difference (Bukit Timah) in Singapore")

sns.lineplot(
    data=resale_price.query("town == 'BUKIT TIMAH'"),
    x="month",
    y="price_log_diff",
    hue="town",
    ax=axes[1][1],
)
# remove legend
axes[1][1].legend_.remove()
axes[1][1].set_title("TS of Log Resale Price Difference (Bukit Timah) in Singapore")

plt.tight_layout()
plt.savefig(ROOT_DIR / "asset" / "resale_price_bukit_timah_ts.png")


median_income.info()
median_income.head()


median_income.describe()


fig, axes = plt.subplots(2, 2, figsize=(10, 5))

sns.lineplot(data=median_income, x="year", y="income", ax=axes[0][0])
axes[0][0].set_title("TS of Median Income in Singapore")

sns.lineplot(data=median_income, x="year", y="income_log", ax=axes[0][1])
axes[0][1].set_title("TS of Log Median Income in Singapore")

sns.lineplot(data=median_income, x="year", y="income_diff", ax=axes[1][0])
axes[1][0].set_title("TS of Median Income Difference in Singapore")

sns.lineplot(data=median_income, x="year", y="income_log_diff", ax=axes[1][1])
axes[1][1].set_title("TS of Log Median Income Difference in Singapore")

plt.tight_layout()
plt.savefig(ROOT_DIR / "asset" / "median_income_ts.png")
