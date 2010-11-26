package org.barista.common.util;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import org.barista.common.util.StringDigester.Algorithm;
import org.junit.Test;


public class StringDigesterTest {

	@Test
	public void testStringDigester() {
		String digestable = "seungbeomi";
		String digested;

		digested = StringDigester.digest(Algorithm.MD5, digestable);

		assertThat(digested, is("6818d0e84c375fb9dd11830c699eb2d3"));

	}
}
