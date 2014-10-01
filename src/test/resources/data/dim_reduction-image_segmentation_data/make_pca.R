## Samples belonging to "brickface" class of the "Image segmentation" data. 
## Taken from http://archive.ics.uci.edu/ml/datasets/Statlog+(Image+Segmentation)
data <- read.csv("image-segmentation-class1.csv", check.names=FALSE)

data.means <- mean(data)
data.centered <- list()
for(c in seq(1:ncol(data))){
  data.centered[[paste("x", c, sep="")]] <- data[[c]] - data.means[[c]]
}
data.centered <- as.data.frame(data.centered)

## default implementation of the PCA based on SVD{

## PCA executed with paramter `tol` responsible for omitting dimensions with
## almost zero standard deviation set to a value proposed in the help
## page of the `prcomp` function.
pca <- prcomp(data, tol=sqrt(.Machine$double.eps))
pca.no.reduction <- prcomp(data)
pca.rotation <- t(pca$rotation)
pca.data.rotated <- t(pca.rotation%*%t(data.centered))
pca.data.whitened <- apply(pca.data.rotated, 2, 
	function(col){ return(col/sd(col)) })
write.csv(pca.data.rotated, "built-in_rotated.csv", row.names=FALSE)
write.csv(pca.data.whitened, "built-in_whitened.csv", row.names=FALSE)


pca.no.reduction.sd <- pca.no.reduction$sd[pca.no.reduction$sd > pca.no.reduction$sd[1]*sqrt(.Machine$double.eps)]
## default implementation of the PCA based on SVD}


## my PCA implementation based on eigenvalue decomposition {
data.cov <- cov(data)
eigen.dec <- eigen(data.cov, TRUE)

## dimensionality reduction method corresponding to the method used in
## `prcomp` function
eigen.sd.raw <- sqrt(eigen.dec$values)
threshold <- eigen.sd.raw[1]*sqrt(.Machine$double.eps)
dims.left <- length(eigen.sd.raw[eigen.sd.raw > threshold])
if(dims.left!=14) stop("This wasn't expected")

eigen.v.reduced <- eigen.dec$vectors[, 1:dims.left]
eigen.d.reduced <- eigen.dec$values[1:dims.left]
eigen.sd <- sqrt(eigen.d.reduced)

eigen.rotation <- t(eigen.v.reduced)
eigen.scaling <- diag(1/(sqrt(eigen.d.reduced)))

#eigen.rotation.raw <- t(eigen.dec$vectors)
#eigen.scaling.raw <- diag(1/(sqrt(eigen.dec$values)))


## my PCA implementation based on eigenvalue decomposition }

transform.data <- function(means, eigen.rotation, eigen.scaling, data){
  data.centered <- list()
  for(c in seq(1:ncol(data))){
    data.centered[[paste("x", c, sep="")]] <- data[[c]] - means[[c]]
  }
  data.centered <- as.data.frame(data.centered)
  rotated <- t(eigen.rotation%*%t(data.centered))
  whitened <- t(eigen.scaling%*%eigen.rotation%*%t(data.centered))
  return(list(rotated=rotated, whitened=whitened))
}

data.transformed <- transform.data(data.means, eigen.rotation, eigen.scaling,
                                   data)

data.rotated <- data.transformed$rotated
write.csv(data.rotated, "eigen_rotated.csv", row.names=FALSE)
data.whitened <- data.transformed$whitened
write.csv(data.whitened, "eigen_whitened.csv", row.names=FALSE)
summary(data.whitened)
