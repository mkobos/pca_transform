package com.mkobos.pca_transform.covmatrixevd;

import Jama.Matrix;

/**
 * 
 * @author Mateusz Kobos
 *
 */
public class EVDResult {
	public Matrix d;
	public Matrix v;
	
	public EVDResult(Matrix d, Matrix v) {
		this.d = d;
		this.v = v;
	}
}
