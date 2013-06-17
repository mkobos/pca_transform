d <- iris
numeric.d <- subset(d, select=-Species)
write.csv(numeric.d, "iris.csv", row.names=FALSE)
preNormalized <- numeric.d
means <- colMeans(preNormalized)

# normalize the iris dataset
data <- list()
for(c in seq(1:ncol(preNormalized))){
  data[[paste("x", c, sep="")]] <- preNormalized[[c]] - means[[c]]
}
data <- as.data.frame(data)
write.csv(data, "iris-normalized.csv", row.names=FALSE)

##built-in PCA{
pca <- prcomp(data, center=FALSE)
pca.rotation <- t(pca$rotation)
pca.scaling <- diag(1/pca$sdev)
##built-in PCA}

#PCA{
data.cov <- cov(data)
eigen.dec <- eigen(data.cov, TRUE)
eigen.rotation <- t(eigen.dec$vectors)
eigen.scaling <- diag(1/(sqrt(eigen.dec$values)))
#PCA}

run.experiment <- function(rotation, scaling, prefix){

  transform.data <- function(rotation, scaling, data){
    rotated <- t(rotation%*%t(data))
    whitened <- t(scaling%*%rotation%*%t(data))
    return(list(rotated=rotated, whitened=whitened))
  }

  data.transformed <- transform.data(rotation, scaling, data)

  data.rotated <- data.transformed$rotated
  write.csv(data.rotated, paste(prefix, "-iris_rotated.csv", sep=""),
            row.names=FALSE)
  data.whitened <-data.transformed$whitened
  write.csv(data.whitened, paste(prefix, "-iris_whitened.csv", sep=""),
            row.names=FALSE)
}

run.experiment(eigen.rotation, eigen.scaling, "eigen")
run.experiment(pca.rotation, pca.scaling, "built-in")
