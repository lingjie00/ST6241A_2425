# Time series test and plots
# %%
# packages required
install.packages("TSA")
install.packages("vars")
install.packages("urca")
install.packages("HDTSA")

# %%
library(TSA)
library(vars)
library(urca)
library(HDTSA)
# %%
median_income <- read.csv("data/median_income_data_train.csv")
median_income[1:5, ]
str(median_income)

# %%
resale_price <- read.csv("data/resale_price_log_diff_train.csv", row.names = 1)
resale_price[1:5, ]

# %%
# ACF and PACF plots
png("asset/median_income_acf_pacf.png")
par(mfrow = c(2, 1))
acf(
    median_income$income_log_diff,
    ci.type = "ma", main = "ACF of Log Median Income Difference"
)
pacf(
    median_income$income_log_diff,
    main = "PACF of Log Median Income Difference"
)
dev.off()

# %%
png("asset/resale_price_bukit_timah_acf_pacf.png")
par(mfrow = c(2, 1))
acf(
    resale_price$BUKIT.TIMAH,
    ci.type = "ma", main = "ACF of Log Resale Price Difference"
)
pacf(
    resale_price$BUKIT.TIMAH,
    main = "PACF of Log Resale Price Difference"
)
dev.off()

# %%
png("asset/resale_price_yearly_acf_pacf.png")
par(mfrow = c(2, 1))
acf(
    resale_price_yearly$price_log_diff,
    ci.type = "ma", main = "ACF of Log Resale Price Yearly Difference"
)
pacf(
    resale_price_yearly$price_log_diff,
    main = "PACF of Log Resale Price Difference"
)
dev.off()


# %%
# Bukit TImah ARMA(1, 2)
#   0 1 2 3 4 5 6 7 8 9 10 11 12 13
# 0 x o o o o o x o o o o  o  o  o
# 1 x x o o o o o o o o o  o  o  o
# 2 x x x o o o o o o o o  o  o  o
# 3 x x x o o o o o o o o  o  o  o
# 4 x x x o x o o o o o o  o  o  o
# 5 x x x x o o o o o o o  o  o  o
# 6 o x x o o x x o o o o  o  o  o
# 7 x x o x o x o o o o o  o  o  o
eacf(
    resale_price$BUKIT.TIMAH,
)

# %%
# ARIMA model for bukit timah
# Coefficients:
#           ar1     ma1      ma2  intercept
#       -0.9525  0.1079  -0.8607     0.0055
# s.e.   0.0685  0.0597   0.0508     0.0015

# sigma^2 estimated as 0.02531:  log likelihood = 85.53,  aic = -163.07

resale_price_bukit_timah_arima <- arima(
    resale_price$BUKIT.TIMAH,
    order = c(1, 0, 2)
)
BIC(resale_price_bukit_timah_arima)
# %%
png("asset/resale_price_bukit_timah_arima_residuals.png")
par(mfrow = c(2, 1))
acf(residuals(resale_price_bukit_timah_arima))
pacf(residuals(resale_price_bukit_timah_arima))
dev.off()

# %%
# Estimation results for equation BUKIT.TIMAH:
# ============================================
# BUKIT.TIMAH = ANG.MO.KIO.l1 + BEDOK.l1 + BISHAN.l1 + BUKIT.BATOK.l1 +
# BUKIT.MERAH.l1 + BUKIT.PANJANG.l1 + BUKIT.TIMAH.l1 + CENTRAL.AREA.l1 +
# CHOA.CHU.KANG.l1 + CLEMENTI.l1 + GEYLANG.l1 + HOUGANG.l1 + JURONG.EAST.l1 +
# JURONG.WEST.l1 + KALLANG.WHAMPOA.l1 + MARINE.PARADE.l1 + PASIR.RIS.l1 +
# PUNGGOL.l1 + QUEENSTOWN.l1 + SEMBAWANG.l1 + SENGKANG.l1 + SERANGOON.l1 +
# TAMPINES.l1 + TOA.PAYOH.l1 + WOODLANDS.l1 + YISHUN.l1 + const

#                    Estimate Std. Error t value Pr(>|t|)
# ANG.MO.KIO.l1      -0.20235    0.28488  -0.710  0.47845
# BEDOK.l1            0.96381    0.32191   2.994  0.00315 **
# BISHAN.l1          -0.04915    0.19964  -0.246  0.80582
# BUKIT.BATOK.l1      0.30518    0.27878   1.095  0.27513
# BUKIT.MERAH.l1      0.15705    0.21662   0.725  0.46940
# BUKIT.PANJANG.l1   -0.13318    0.31992  -0.416  0.67769
# BUKIT.TIMAH.l1     -0.38006    0.06914  -5.497 1.32e-07 ***
# CENTRAL.AREA.l1     0.06203    0.11838   0.524  0.60096
# CHOA.CHU.KANG.l1    0.35523    0.46597   0.762  0.44686
# CLEMENTI.l1        -0.25374    0.17592  -1.442  0.15094
# GEYLANG.l1          0.10477    0.17108   0.612  0.54106
# HOUGANG.l1         -0.26941    0.36561  -0.737  0.46216
# JURONG.EAST.l1      0.47426    0.22419   2.115  0.03579 *
# JURONG.WEST.l1     -0.50215    0.45923  -1.093  0.27567
# KALLANG.WHAMPOA.l1 -0.02908    0.20252  -0.144  0.88599
# MARINE.PARADE.l1   -0.10995    0.10740  -1.024  0.30734
# PASIR.RIS.l1        0.05868    0.35539   0.165  0.86904
# PUNGGOL.l1         -0.03847    0.43460  -0.089  0.92957
# QUEENSTOWN.l1      -0.31888    0.16674  -1.912  0.05742 .
# SEMBAWANG.l1       -0.60662    0.43694  -1.388  0.16677
# SENGKANG.l1        -0.15287    0.67008  -0.228  0.81981
# SERANGOON.l1       -0.15246    0.23186  -0.658  0.51168
# TAMPINES.l1         0.29015    0.47230   0.614  0.53978
# TOA.PAYOH.l1       -0.29077    0.16573  -1.754  0.08107 .
# WOODLANDS.l1        0.01815    0.50834   0.036  0.97156
# YISHUN.l1          -0.74039    0.40280  -1.838  0.06772 .
# const               0.01405    0.01369   1.026  0.30625
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


# Residual standard error: 0.1843 on 178 degrees of freedom
# Multiple R-Squared: 0.3266,     Adjusted R-squared: 0.2283
# F-statistic: 3.321 on 26 and 178 DF,  p-value: 1.241e-06

resale_price_var <- VAR(resale_price, ic = "SC")
summary(resale_price_var)

# %%
# restricted model
# Estimation results for equation BUKIT.TIMAH:
# ============================================
# BUKIT.TIMAH = BEDOK.l1 + BUKIT.TIMAH.l1 + YISHUN.l1

#                Estimate Std. Error t value Pr(>|t|)
# BEDOK.l1        0.80406    0.27963   2.875  0.00447 **
# BUKIT.TIMAH.l1 -0.42165    0.06095  -6.918 5.93e-11 ***
# YISHUN.l1      -0.72784    0.35852  -2.030  0.04366 *
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


# Residual standard error: 0.1829 on 202 degrees of freedom
# Multiple R-Squared: 0.2492,     Adjusted R-squared: 0.2381
# F-statistic: 22.35 on 3 and 202 DF,  p-value: 1.537e-12

resale_price_var_restricted <- restrict(resale_price_var)
BIC(resale_price_var_restricted$varresult$BUKIT.TIMAH)
summary(resale_price_var_restricted)

# %%
# residuals plot
serial.test(resale_price_var_restricted, lags.pt = 6, type = "PT.adjusted")


causality(VAR(resale_price[, c("BUKIT.TIMAH", "YISHUN")], ic = "SC"), cause = "YISHUN")
causality(VAR(resale_price[, c("BUKIT.TIMAH", "BEDOK")], ic = "SC"), cause = "BEDOK")

# %%
dev.new()
plot(serial.test(resale_price_var, lags.pt = 6, type = "PT.adjusted"))

# %%
resale_price_var_restricted_predict <- predict(
    resale_price_var_restricted,
    n.ahead = 15, ci = 0.95
)

# %%
resale_price_yearly_var <- VAR(
    resale_price_yearly,
    ic = "SC"
)
summary(resale_price_yearly_var)
causality(resale_price_yearly_var, cause = "income_log_diff")

# %%
Psi(resale_price_yearly_var)

# %%
summary(ur.df(
    median_income$income_log_diff,
    type = "none", lags = 4, selectlags = "AIC"
))

# %%
summary(ca.jo(resale_price_yearly, type = "trace", ecdet = "none", K = 2, spec = "transitory"))
summary(ca.jo(resale_price_yearly, type = "eigen", ecdet = "none", K = 2, spec = "transitory"))

# %%
# Factor model
factor_model <- Factors(resale_price, twostep = TRUE)
factor_model$factor_num
factor_loading <- factor_model$loading.mat
factor_matrix <- as.matrix(resale_price) %*% factor_loading
recovered_data <- factor_matrix %*% t(factor_loading)
par(mfrow = c(3, 1))
plot(resale_price[, 1])
plot(recovered_data[, 1])
plot(recovered_data[, 1] - resale_price[, 1])
dev.off()

plot(acf(factor_matrix))

par(mfrow = c(2, 1))
acf(factor_matrix[, 1])
pacf(factor_matrix[, 1])
eacf(factor_matrix[, 1])
factor_1_arima <- arima(factor_matrix[, 1], order = c(0, 0, 1))

par(mfrow = c(2, 1))
acf(factor_matrix[, 2])
pacf(factor_matrix[, 2])
eacf(factor_matrix[, 2])
factor_2_arima <- arima(factor_matrix[, 2], order = c(4, 0, 1))

factor_train_predict_factor <- cbind(
    factor_matrix[, 1] - residuals(factor_1_arima),
    factor_matrix[, 2] - residuals(factor_1_arima)
)
factor_train_predict <- factor_train_predict_factor %*% t(factor_loading)
par(mfrow = c(3, 1))
plot(resale_price$BUKIT.TIMAH)
plot(factor_train_predict[, 7])
plot(factor_train_predict[, 7] - resale_price$BUKIT.TIMAH)


# %%

pca_model <- PCA_TS(resale_price, thresh = TRUE)
pca_model$B
pca_model$Z
pca_model$Groups
plot(acf(pca_model$Z))
