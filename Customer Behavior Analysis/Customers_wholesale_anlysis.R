## Title : title: "Clustering Wholesale Customers"
----

-----

##{r global_options, include=FALSE}
##knitr::opts_chunk$set(echo=FALSE, warning=FALSE, message=FALSE)


getwd()
setwd("C:\\Users\\12172\\Desktop\\Course\\Resume_projects\\Customer Behaviour analysis")


customer <- read.csv('Customers_wholesale.csv')


head(customer)
str(customer)

### K-Means Clustering
customer1<- customer
customer1<- na.omit(customer1)
customer1$Channel <- NULL
customer1$Region <- NULL

# Standardize the variables.
customer1 <- scale(customer1)

#Determine number of clusters.

wss <- (nrow(customer1)-1)*sum(apply(customer1,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(customer1, 
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")

# The correct choice of k is often ambiguous, but from the above plot,
## I am going to try my cluster analysis with 6 clusters .
## Fit the model and print out the cluster means. 

fit <- kmeans(customer1, 6) # fit the model
aggregate(customer1,by=list(fit$cluster),FUN=mean) # get cluster means
customer1 <- data.frame(customer1, fit$cluster) #append cluster assignment

##Plotting the results.
library(cluster)
clusplot(customer1, fit$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)

### Outlier detection with K-Means

##First, the data are partitioned into k groups by assigning them to the closest cluster centers, as follows:
customer2 <- customer[, 3:8]
kmeans.result <- kmeans(customer2, centers=6)
kmeans.result$centers

##Then calculate the distance between each object and its cluster center, 
##and pick those with largest distances as outliers.

kmeans.result$cluster # print out cluster IDs 
centers <- kmeans.result$centers[kmeans.result$cluster, ]
distances <- sqrt(rowSums((customer2 - centers)^2)) # calculate distances
outliers <- order(distances, decreasing=T)[1:5] # pick up top 5 distances
print(outliers)


### These are the outliers. Let me make it more meaningful.

print(customer2[outliers,])

# ** Hierarchical Clustering

##First draw a sample of 40 records from the customer data to avoid crowding
## removing variables Region and Channel from the data 

idx <- sample(1:dim(customer)[1], 40)
customerSample <- customer[idx,]
customerSample$Region <- NULL
customerSample$Channel <- NULL

#There are a wide range of hierarchical clustering methods, I'm using Ward's method 

d <- dist(customerSample, method = "euclidean") # distance matrix
fit <- hclust(d, method="ward.D") 
plot(fit) # display dendogram
groups <- cutree(fit, k=6) # cut tree into 6 clusters

# draw dendogram with red borders around the 6 clusters 
rect.hclust(fit, k=6, border="red")

## Conlusion: 

# At the bottom, I start with 40 data points, each assigned to separate clusters, 
# two closest clusters are then merged till I have just one cluster at the top. 
# The height in the dendrogram at which two clusters are merged 
# merged culters: represents the distance between two clusters in the data space. 
# The decision of the number of clusters that can best depict different groups can be chosen by observing the dendrogram.

# We can then build targeted strategy using the profiles of each cluster. 























