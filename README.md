# Customer-Segmentation
A Shiny App

A Customer is a person or business that buys another organization's goods or services. He is known as the king of the market. Customers are significant in light of the fact that they drive incomes; without them, organizations have nothing to offer. In this competitive modern world, it is critical to comprehend customer conduct and categorize customers, depending on their demography and purchasing behavior. Customer segmentation can be done with the help of essential differentiators such as age, race, religion, gender, family size, ethnicity, income, education level, geographic location, psychographic tendencies, behavioral tendencies, etc.

In this project, we will make use of K-means clustering which is the essential algorithm for clustering unlabeled dataset. 

While using the k-means clustering algorithm, the first step is to indicate the number of clusters (k) that we wish to produce in the final output. The algorithm starts by selecting k objects from dataset randomly that will serve as the initial centers for our clusters. These selected objects are the cluster means, also known as centroids. Then, the remaining objects have an assignment of the closest centroid. This centroid is defined by the Euclidean Distance present between the object and the cluster mean. We refer to this step as “cluster assignment”. When the assignment is complete, the algorithm proceeds to calculate new mean value of each cluster present in the data. After the recalculation of the centers, the observations are checked if they are closer to a different cluster. Using the updated cluster mean, the objects undergo reassignment. This goes on repeatedly through several iterations until the cluster assignments stop altering. The clusters that are present in the current iteration are the same as the ones obtained in the previous iteration.


Summing up the K-means clustering –

 * We specify the number of clusters that we need to create.
 * The algorithm selects k objects at random from the dataset. This object is the initial cluster or mean.
 * The closest centroid obtains the assignment of a new observation. We base this assignment on the Euclidean Distance between object and the centroid.
 * k clusters in the data points update the centroid through calculation of the new mean values present in all the data points of the cluster. The kth cluster’s centroid has a l   length of p that contains means of all variables for observations in the k-th cluster. We denote the number of variables with p.
 * Iterative minimization of the total within the sum of squares. Then through the iterative minimization of the total sum of the square, the assignment stop wavering when we achieve maximum iteration. The default value is 10 that the R software uses for the maximum iterations.
 
 While working with clusters, you need to specify the number of clusters to use. You would like to utilize the optimal number of clusters. To help you in determining the optimal clusters, there are three popular methods –

 * Elbow method
 * Silhouette method
 * Gap statistic
