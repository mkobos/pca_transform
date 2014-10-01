package com.mkobos.pca_transform;

import com.mkobos.pca_transform.covmatrixevd.EVDBased;

import Jama.Matrix;

import java.io.IOException;

public class EVDBasedPCA_Test extends TemplatePCATest {
	
	public EVDBasedPCA_Test() {
		super(1e-8, new EVDBased());
	}
	
	/** An example from 
	 * http://www.itl.nist.gov/div898/handbook/pmc/section5/pmc541.htm
	 */
	public void testCovarianceMatrix(){
		Matrix data = new Matrix(new double[][] {
				{4.0, 2.0, .6},
				{4.2, 2.1, .59},
				{3.9, 2.0, .58},
				{4.3, 2.1, .62},
				{4.1, 2.2, .63}});
		Matrix actual = PCA.calculateCovarianceMatrix(data);
		Matrix expected = new Matrix(new double[][] {
				{.025, .0075, .00175}, 
				{.0075, .007, .00135},
				{.00175, .00135, .00043}});
		assertEquals(expected.getRowDimension(), actual.getRowDimension());
		assertEquals(expected.getColumnDimension(), 
				actual.getColumnDimension());
		for(int r = 0; r < expected.getRowDimension(); r++)
			for(int c = 0; c < expected.getColumnDimension(); c++)
				assertEquals(expected.get(r, c), actual.get(r, c), .000000001);
	}
	
	public void testIris() throws IOException{
		checkPCATransformation("data/iris_data_set/iris.csv", 
				"data/iris_data_set/iris.csv",
				"data/iris_data_set/eigen-iris_rotated.csv", 
				"data/iris_data_set/eigen-iris_whitened.csv");
		checkPCATransformation("data/iris_data_set/iris.csv", 
				"data/iris_data_set/iris-other.csv",
				"data/iris_data_set/eigen-other_rotated.csv", 
				"data/iris_data_set/eigen-other_whitened.csv");		
		checkPCATransformation("data/iris_data_set_normalized/iris-normalized.csv", 
				"data/iris_data_set_normalized/iris-normalized.csv",
				"data/iris_data_set_normalized/eigen-iris_rotated.csv", 
				"data/iris_data_set_normalized/eigen-iris_whitened.csv", false);
	}
	
	public void testImageSegementationClass1() throws IOException{
		checkPCATransformation(
				"data/dim_reduction-image_segmentation_data/image-segmentation-class1.csv", 
				"data/dim_reduction-image_segmentation_data/image-segmentation-class1.csv",
				"data/dim_reduction-image_segmentation_data/eigen_rotated.csv", 
				"data/dim_reduction-image_segmentation_data/eigen_whitened.csv");		
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
}
