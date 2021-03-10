## Culstering of Wholesale Customers:

** The goal of the project is to use various clustering techniques to segment customers. 
Clustering is an unsupervised learning algorithm that tries to cluster data based on their similarity. Thus, there is no outcome to be predicted, and the algorithm just tries to find patterns in the data.


### K-Means Clustering: 
The correct choice of k is often ambiguous, but from the above plot, I am going to try my cluster analysis with 6 clusters. 

![Imgur Image](https://github.com/mohite2/Academic-Projects/blob/main/Customer%20Behavior%20Analysis/Images/Dendogram.png)


Interpretation of the results: With my analysis, more than 70% of information about the multivariate data is captured by this plot of component 1 and 2.

## Outlier detection with K-Means
First, the data are partitioned into k groups by assigning them to the closest cluster centers, as follows:

![Alt text](/relative/path/to/img.jpg?raw=true "Optional Title")  ## outliers 01

![Alt text](/relative/path/to/img.jpg?raw=true "Optional Title") #02

These are the outliers. 

## Hierarchical Clustering
First draw a sample of 40 records from the customer data, so that the clustering plot will not be over crowded. Same as before, variables “Region” and “Channel” are removed from the data. After that, I apply hierarchical clustering to the data.

![Alt text](/relative/path/to/img.jpg?raw=true "Optional Title") #dendogram

At the bottom, I start with 40 data points, each assigned to separate clusters, two closest clusters are then merged till I have just one cluster at the top. The height in the dendrogram at which two clusters are merged represents the distance between two clusters in the data space. The decision of the number of clusters that can best depict different groups can be chosen by observing the dendrogram.
I reviewed K Means clustering and Hierarchical Clustering. As we have seen, from using clusters we can understand the portfolio in a better way. We can then build targeted strategy using the profiles of each cluster.
