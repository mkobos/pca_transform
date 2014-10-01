package com.mkobos.pca_transform;

import Jama.Matrix;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.notNullValue;
import static org.junit.Assert.assertThat;

/**
 * Created by fredrikbridell on 01/10/14.
 */
public class TestDataReader {

    private final static Logger log = LoggerFactory.getLogger(TestDataReader.class);

    // the path in test/resources
    private final static String PATH = "data/dim_reduction-artificial_data/data_2d.csv";


    @Test
    public void testReadingData() throws IOException {
        String resource = "target/test-classes/data/dim_reduction-artificial_data/data_2d.csv";

        Matrix read = DataReader.read(resource, false);
        assertThat(read, notNullValue());
        assertThat(read.getRowDimension(), is(30));
    }

}
