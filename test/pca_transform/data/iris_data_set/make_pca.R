d <- iris
numeric.d <- subset(d, select=-Species)
write.csv(numeric.d, "iris.csv", row.names=FALSE)
data <- numeric.d
data.means <- mean(data)

##built-in PCA{
pca <- prcomp(data)
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

  transform.data <- function(means, rotation, scaling, data){
    data.centered <- list()
    for(c in seq(1:ncol(data))){
      data.centered[[paste("x", c, sep="")]] <- data[[c]] - means[[c]]
    }
    data.centered <- as.data.frame(data.centered)
    rotated <- t(rotation%*%t(data.centered))
    whitened <- t(scaling%*%rotation%*%t(data.centered))
    return(list(rotated=rotated, whitened=whitened))
  }

  data.transformed <- transform.data(data.means, rotation, scaling, data)

  data.rotated <- data.transformed$rotated
  write.csv(data.rotated, paste(prefix, "-iris_rotated.csv", sep=""),
            row.names=FALSE)
  data.whitened <-data.transformed$whitened
  write.csv(data.whitened, paste(prefix, "-iris_whitened.csv", sep=""),
            row.names=FALSE)

  other.data <- read.csv("iris-other.csv")

  other.data.transformed <- transform.data(data.means,
                                           rotation, scaling, other.data)
  other.data.rotated <- other.data.transformed$rotated
  write.csv(other.data.rotated, paste(prefix, "-other_rotated.csv", sep=""),
            row.names=FALSE)
  other.data.whitened <- other.data.transformed$whitened
  write.csv(other.data.whitened, paste(prefix, "-other_whitened.csv", sep=""),
            row.names=FALSE)
}

run.experiment(eigen.rotation, eigen.scaling, "eigen")
run.experiment(pca.rotation, pca.scaling, "built-in")