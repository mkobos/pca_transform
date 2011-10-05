package pca_transform;

import java.io.IOException;

import pca_transform.covmatrixevd.SVDBased;

public class SVDBasedPCA_Test extends TemplatePCATest {
	
	public SVDBasedPCA_Test() {
		super(1e-12, new SVDBased());
	}
	
	public void testIris() throws IOException{
		checkPCATransformation("data/iris_data_set/iris.csv", 
				"data/iris_data_set/iris.csv",
				"data/iris_data_set/built-in-iris_rotated.csv", 
				"data/iris_data_set/built-in-iris_whitened.csv");
		checkPCATransformation("data/iris_data_set/iris.csv", 
				"data/iris_data_set/iris-other.csv",
				"data/iris_data_set/built-in-other_rotated.csv", 
				"data/iris_data_set/built-in-other_whitened.csv");		
	}
	
	public void testImageSegementationClass1() throws IOException{
		checkPCATransformation(
				"data/dim_reduction-image_segmentation_data/image-segmentation-class1.csv", 
				"data/dim_reduction-image_segmentation_data/image-segmentation-class1.csv",
				"data/dim_reduction-image_segmentation_data/built-in_rotated.csv", 
				"data/dim_reduction-image_segmentation_data/built-in_whitened.csv");		
	}
	
	
	public void testOutliers() throws IOException{
		checkOutliers("data/dim_reduction-artificial_data/all.csv",
				"data/dim_reduction-artificial_data/all-outliers.csv",
				"data/dim_reduction-artificial_data/all-non_outliers.csv");
	}
	
	public void testDimsReduction() throws IOException{
		checkDimsReduction("data/dim_reduction-artificial_data/all.csv", 6, 2);
		checkDimsReduction("data/dim_reduction-artificial_data/data_3d.csv", 3, 1);
		checkDimsReduction("data/dim_reduction-artificial_data/data_2d.csv", 2, 1);
		checkDimsReduction("data/dim_reduction-artificial_data/no_dim_reduction.csv", 2, 2);	
	}
	
	public void testNoOfSamplesSmallerThanNoOfDims() throws IOException {
		checkPCATransformation("data/no_of_samples_smaller_than_no_of_dims/data.csv",
				"data/no_of_samples_smaller_than_no_of_dims/data.csv",
				"data/no_of_samples_smaller_than_no_of_dims/built-in-rotated.csv",
				"data/no_of_samples_smaller_than_no_of_dims/built-in-whitened.csv");
	}
}
