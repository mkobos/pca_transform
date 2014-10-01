package com.mkobos.pca_transform.covmatrixevd;

import Jama.Matrix;

/** Calculates eigenvalue decomposition of the covariance matrix of the 
 * given data 
 * @author Mateusz Kobos
 * */
public interface CovarianceMatrixEVDCalculator {
	/** Calculate covariance matrix of the given data
	 * @param centeredData data matrix where rows are the instances/samples and 
	 * columns are dimensions. It has to be centered.
	 */
	public com.mkobos.pca_transform.covmatrixevd.EVDResult run(Matrix centeredData);
}
