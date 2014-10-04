package com.mkobos.pca_transform;

import Jama.Matrix;

import org.junit.Test;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import junit.framework.TestCase;

/**
 * @author Fredrik Bridell
 * @author Mateusz Kobos
 */
public class DataReaderTest  extends TestCase {
    @Test
    public void testReadingData() throws IOException {
        String resource = "target/test-classes/data/dim_reduction-artificial_data/data_2d.csv";

        BufferedReader br = new BufferedReader(new FileReader(resource));
        Matrix read = DataReader.read(br, false);
        
        assertNotNull(read);
        assertEquals(30, read.getRowDimension());
    }

}
