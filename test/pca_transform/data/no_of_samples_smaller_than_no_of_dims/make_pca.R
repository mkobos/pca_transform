d <- data.frame(x1=c(1, 6, 2), x2=c(2, 5, 2), x3=c(3, 4, 2), 
                x4=c(4, 3, 2), x5=c(5, 2, 2), x6=c(6, 1, 2))
write.csv(d, "data.csv", row.names=FALSE)
d.means <- mean(d)

##built-in PCA{
pca <- prcomp(d, tol=sqrt(.Machine$double.eps))
pca.rotation <- t(pca$rotation)
pca.scaling <- diag(1/pca$sdev)
##built-in PCA}

#PCA{
d.cov <- cov(d)
eigen.dec <- eigen(d.cov, TRUE)
eigen.rotation <- t(eigen.dec$vectors)
eigen.scaling <- diag(1/(sqrt(eigen.dec$values)))
#PCA}

transform.data <- function(means, rotation, scaling, data){
  data.centered <- list()
  for(c in 1:ncol(data)){
    data.centered[[paste("x", c, sep="")]] <- data[[c]] - means[[c]]
  }
  data.centered <- as.data.frame(data.centered)
  rotated <- t(rotation%*%t(data.centered))
  whitened <- t(scaling%*%rotation%*%t(data.centered))
  return(list(rotated=rotated, whitened=whitened))
}

run.experiment <- function(data.means, rotation, scaling, data, prefix){
  data.transformed <- transform.data(data.means, rotation, scaling, data)

  data.rotated <- data.transformed$rotated
  write.csv(data.rotated, paste(prefix, "-rotated.csv", sep=""),
            row.names=FALSE)
  data.whitened <- data.transformed$whitened
  write.csv(data.whitened, paste(prefix, "-whitened.csv", sep=""),
            row.names=FALSE)
  #summary(data.whitened)
  #var(data.whitened)
}

run.experiment(d.means, eigen.rotation, eigen.scaling, d, "eigen")
run.experiment(d.means, pca.rotation, pca.scaling, d, "built-in")