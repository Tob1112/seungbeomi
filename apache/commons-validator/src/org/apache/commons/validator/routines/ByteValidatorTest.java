/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.commons.validator.routines;

import java.util.Locale;

/**
 * Test Case for ByteValidator.
 * 
 * @version $Revision: 478334 $ $Date: 2006-11-22 21:31:54 +0000 (Wed, 22 Nov 2006) $
 */
public class ByteValidatorTest extends BaseNumberValidatorTest {

    /**
     * Main
     * @param args arguments
     */
    public static void main(String[] args) {
        junit.textui.TestRunner.run(ByteValidatorTest.class);
    }

    /**
     * Constructor
     * @param name test name
     */
    public ByteValidatorTest(String name) {
        super(name);
    }

    protected void setUp() throws Exception {
        super.setUp();

        validator       = new ByteValidator(false, 0);
        strictValidator = new ByteValidator();

        testPattern = "#,###";

        // testValidateMinMax()
        max = new Byte(Byte.MAX_VALUE);
        maxPlusOne = new Long(max.longValue() + 1);
        min = new Byte(Byte.MIN_VALUE);
        minMinusOne = new Long(min.longValue() - 1);

        // testInvalidStrict()
        invalidStrict = new String[] {null, "", "X", "X12", "12X", "1X2", "1.2"};

        // testInvalidNotStrict()
        invalid       = new String[] {null, "", "X", "X12"};

        // testValid()
        testNumber    = new Byte((byte)123);
        testZero      = new Byte((byte)0);
        validStrict          = new String[] {"0", "123", ",123"};
        validStrictCompare   = new Number[] {testZero, testNumber, testNumber};
        valid                = new String[] {"0", "123", ",123", ",123.5", "123X"};
        validCompare         = new Number[] {testZero, testNumber, testNumber, testNumber, testNumber};

        testStringUS = ",123";
        testStringDE = ".123";

        // Localized Pattern test
        localeValue = testStringDE;
        localePattern = "#.###";
        testLocale    = Locale.GERMANY;
        localeExpected = testNumber;

    }

    /**
     * Test ByteValidator validate Methods
     */
    public void testByteValidatorMethods() {
        Locale locale     = Locale.GERMAN;
        String pattern    = "0,00";
        String patternVal = "1,23";
        String germanPatternVal = "1.23";
        String localeVal  = ".123";
        String defaultVal = ",123";
        String XXXX    = "XXXX"; 
        Byte expected = new Byte((byte)123);
        assertEquals("validate(A) default", expected, ByteValidator.getInstance().validate(defaultVal));
        assertEquals("validate(A) locale ", expected, ByteValidator.getInstance().validate(localeVal, locale));
        assertEquals("validate(A) pattern", expected, ByteValidator.getInstance().validate(patternVal, pattern));
        assertEquals("validate(A) both",    expected, ByteValidator.getInstance().validate(germanPatternVal, pattern, Locale.GERMAN));

        assertTrue("isValid(A) default", ByteValidator.getInstance().isValid(defaultVal));
        assertTrue("isValid(A) locale ", ByteValidator.getInstance().isValid(localeVal, locale));
        assertTrue("isValid(A) pattern", ByteValidator.getInstance().isValid(patternVal, pattern));
        assertTrue("isValid(A) both",    ByteValidator.getInstance().isValid(germanPatternVal, pattern, Locale.GERMAN));

        assertNull("validate(B) default", ByteValidator.getInstance().validate(XXXX));
        assertNull("validate(B) locale ", ByteValidator.getInstance().validate(XXXX, locale));
        assertNull("validate(B) pattern", ByteValidator.getInstance().validate(XXXX, pattern));
        assertNull("validate(B) both",    ByteValidator.getInstance().validate(patternVal, pattern, Locale.GERMAN));

        assertFalse("isValid(B) default", ByteValidator.getInstance().isValid(XXXX));
        assertFalse("isValid(B) locale ", ByteValidator.getInstance().isValid(XXXX, locale));
        assertFalse("isValid(B) pattern", ByteValidator.getInstance().isValid(XXXX, pattern));
        assertFalse("isValid(B) both",    ByteValidator.getInstance().isValid(patternVal, pattern, Locale.GERMAN));
    }

    /**
     * Test Byte Range/Min/Max
     */
    public void testByteRangeMinMax() {
        ByteValidator validator = (ByteValidator)strictValidator;
        Byte number9  = validator.validate("9", "#");
        Byte number10 = validator.validate("10", "#");
        Byte number11 = validator.validate("11", "#");
        Byte number19 = validator.validate("19", "#");
        Byte number20 = validator.validate("20", "#");
        Byte number21 = validator.validate("21", "#");
        byte min = (byte)10;
        byte max = (byte)20;

        // Test isInRange()
        assertFalse("isInRange() < min",   validator.isInRange(number9,  min, max));
        assertTrue("isInRange() = min",    validator.isInRange(number10, min, max));
        assertTrue("isInRange() in range", validator.isInRange(number11, min, max));
        assertTrue("isInRange() = max",    validator.isInRange(number20, min, max));
        assertFalse("isInRange() > max",   validator.isInRange(number21, min, max));

        // Test minValue()
        assertFalse("minValue() < min",    validator.minValue(number9,  min));
        assertTrue("minValue() = min",     validator.minValue(number10, min));
        assertTrue("minValue() > min",     validator.minValue(number11, min));

        // Test minValue()
        assertTrue("maxValue() < max",     validator.maxValue(number19, max));
        assertTrue("maxValue() = max",     validator.maxValue(number20, max));
        assertFalse("maxValue() > max",    validator.maxValue(number21, max));
    }
}
