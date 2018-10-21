library(data.table)
library(caret)
library(ggplot2)
library(purrr)
library(tidyr)
library(corrplot)


set.seed(23)

trainfile<-'C:/MSDS/Proj/training.csv'
train <- fread(trainfile)
testfile<- 'C:/MSDS/Proj/test.csv'
test <- fread(testfile)


head(train)
summary(train)
dim(train)
train[, signal:=as.factor(signal)]
levels(train$signal)<- c('False','True')
str(train)
plot(train$signal, main="Tau Signal")
##anova
fit <- aov(signal~mass, data=train)
plot(fit)
summary(fit)





eda <- fread('C:/MSDS/Proj/training.csv')
str(eda)
eda$id <- NULL
boxplot(eda)
corrplot(cor(eda))

M=cor(eda)
res1 <- cor.mtest(eda, conf.level = .95)
corrplot(M, type = "upper", order = "hclust", 
         p.mat = res1$p, sig.level = .2)
# generating large feature matrix (cols=features, rows=samples)
num_features <- 50 # how many features
num_samples <- 67553 # how many samples
DATASET <- matrix(runif(num_features * num_samples),
                  nrow = num_samples, ncol = num_features)

# setting some dummy names for the features e.g. f23
colnames(DATASET) <- paste0("f", 1:ncol(DATASET))

# let's make 30% of all features to be correlated with feature "f1"
num_feat_corr <- num_features * .3
idx_correlated_features <- as.integer(seq(from = 1,
                                          to = num_features,
                                          length.out = num_feat_corr))[-1]
for (i in idx_correlated_features) {
  DATASET[,i] <- DATASET[,1] + runif(num_samples) # adding some noise
}

corrplot(M, diag = FALSE, tl.pos = "td", 
         tl.cex = 0.5, method = "color", type = "upper",
         insig = "label_sig", pch.col = "white")


eda=subset(eda, select=-c(FlightDistance,CDF1,iso,isolationa,isolationb,isolationc,
                      isolationd,isolatione,isolationf,
                      signal,mass,SPDhits,min_ANNmuon,production))
summary(eda)
       
M=cor(eda)
corrplot(M, diag = FALSE, tl.pos = "td", 
         tl.cex = 0.5, method = "color", type = "upper",
         insig = "label_sig", pch.col = "white")








library(DMwR)
inputData <- knnImputation(eda)
library(party)
cf1 <- cforest(signal ~ ., data = eda, controls = cforest_unbiased(mtry = 2, ntree = 50))

varimp(cf1)
#based on mean difference in accuracy
varimp(cf1, conditional = TRUE)
varimpAUC(cf1)  #more robust towards class imbalance


abs(cor(eda[with = F])) > 0.8





train %>%
  keep(is.numeric) %>%                     # Keep only numeric columns
  gather() %>%                             # Convert to key-value pairs
  ggplot(aes(value)) +                     # Plot the values
  facet_wrap(~ key, scales = "free") +   # In separate panels
  geom_density()                         # as density

train %>%
  keep(is.numeric) %>% 
  gather() %>% 
  ggplot(aes(value)) +
  facet_wrap(~ key, scales = "free") +
  geom_histogram()

train %>%
  keep(is.numeric) %>% 
  gather() %>% 
  ggplot(aes(factor(variable), value)) +
  facet_wrap(~ key, scales = "free") +
  geom_boxplot()


library(reshape)
meltData <- melt(eda)
boxplot(data=meltData, value~variable)
melt %>%
  keep(is.numeric) %>% 
  gather() %>% 
  ggplot(aes(value)) +
  facet_wrap(~ key, scales = "free") +
  geom_boxplot()
p <- ggplot(meltData, aes(factor(variable), value)) 
p + geom_boxplot() + facet_wrap(~variable, scale="free")
boxplot(eda$iso)
boxplot(eda$p0_IsoBDT)
summary(eda$p0_IsoBDT)
library(e1071)
target <- train$sig
model <- tune(svm,target ~ .,data = train,
              ranges = list(gamma = c(0.001, 0.01, 0.1),
                            cost = c(0.1, 1, 5, 10)),
              tunecontrol = tune.control(sampling = "cross", cross = 3),
              kernel = 'radial')
