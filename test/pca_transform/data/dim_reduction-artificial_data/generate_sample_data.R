get.coordinates <- function(x1, x4){
  x2 <- 2*x1+3
  x3 <- 0.4*x1-1
  x5 <- -0.4*x2
  x6 <- 2.5*x4-5
  return(data.frame(x1=x1, x2=x2, x3=x3, x4=x4, x5=x5, x6=x6))
}

outlier1 <- get.coordinates(1, 2)
outlier1$x2 <- outlier1$x2+2
outlier2 <- get.coordinates(2, 1)
outlier2$x2 <- outlier2$x2+3
outlier2$x3 <- outlier2$x3+0.1
outlier2$x5 <- outlier2$x5+1
outlier2$x6 <- outlier2$x6-4
outlier.small <- get.coordinates(0.4, 0.7)
outlier.small$x5 <- outlier.small$x5+0.001
all.outliers <- rbind(outlier1, outlier2, outlier.small)
write.csv(all.outliers, "all-outliers.csv", row.names=FALSE)

non.outliers <- get.coordinates(c(1, 2), c(2, 1))
write.csv(non.outliers, "all-non_outliers.csv", row.names=FALSE)

all <- get.coordinates(rnorm(30), rnorm(30))
write.csv(all, "all.csv", row.names=FALSE)
data.3d <- subset(all, select=c(x1, x2, x3))
write.csv(data.3d, "data_3d.csv", row.names=FALSE)
data.2d <- subset(all, select=c(x1, x2))
write.csv(data.2d, "data_2d.csv", row.names=FALSE)
no.reduction <- subset(all, select=c(x2, x4))
write.csv(no.reduction, "no_dim_reduction.csv", row.names=FALSE)
