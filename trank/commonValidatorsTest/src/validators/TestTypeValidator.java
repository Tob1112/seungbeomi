package validators;

import java.util.*;

import org.apache.commons.validator.Field;
import org.apache.commons.validator.GenericTypeValidator;
import org.apache.commons.validator.util.ValidatorUtils;

/**
 * Contains validation methods for different unit tests.
 *
 * @version $Revision: 478334 $ $Date: 2006-11-22 21:31:54 +0000 (Wed, 22 Nov 2006) $
 */
public class TestTypeValidator {

   /**
    * Checks if the field can be successfully converted to a <code>byte</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>byte</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Byte validateByte(Object bean, Field field) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatByte(value);
   }

   /**
    * Checks if the field can be successfully converted to a <code>byte</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>byte</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Byte validateByte(Object bean, Field field, Locale locale) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatByte(value, locale);
   }

   /**
    * Checks if the field can be successfully converted to a <code>short</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>short</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Short validateShort(Object bean, Field field) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatShort(value);
   }

   /**
    * Checks if the field can be successfully converted to a <code>short</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>short</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Short validateShort(Object bean, Field field, Locale locale) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatShort(value, locale);
   }

   /**
    * Checks if the field can be successfully converted to a <code>int</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>int</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Integer validateInt(Object bean, Field field) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatInt(value);
   }

   /**
    * Checks if the field can be successfully converted to a <code>int</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>int</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Integer validateInt(Object bean, Field field, Locale locale) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatInt(value, locale);
   }

   /**
    * Checks if the field can be successfully converted to a <code>long</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>long</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Long validateLong(Object bean, Field field) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatLong(value);
   }

   /**
    * Checks if the field can be successfully converted to a <code>long</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>long</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Long validateLong(Object bean, Field field, Locale locale) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatLong(value, locale);
   }

   /**
    * Checks if the field can be successfully converted to a <code>float</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>float</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Float validateFloat(Object bean, Field field) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatFloat(value);
   }

   /**
    * Checks if the field can be successfully converted to a <code>float</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>float</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Float validateFloat(Object bean, Field field, Locale locale) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatFloat(value, locale);
   }

   /**
    * Checks if the field can be successfully converted to a <code>double</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>double</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Double validateDouble(Object bean, Field field) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatDouble(value);
   }

   /**
    * Checks if the field can be successfully converted to a <code>double</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>double</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Double validateDouble(Object bean, Field field, Locale locale) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatDouble(value, locale);
   }

   /**
    * Checks if the field can be successfully converted to a <code>date</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>date</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Date validateDate(Object bean, Field field, Locale locale) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());

      return GenericTypeValidator.formatDate(value, locale);
   }

   /**
    * Checks if the field can be successfully converted to a <code>date</code>.
    *
    * @param value The value validation is being performed on.
    * @return boolean If the field can be successfully converted
    * to a <code>date</code> <code>true</code> is returned.
    * Otherwise <code>false</code>.
    */
   public static Date validateDate(Object bean, Field field) {
      String value = ValidatorUtils.getValueAsString(bean, field.getProperty());
      String datePattern = field.getVarValue("datePattern");
      String datePatternStrict = field.getVarValue("datePatternStrict");

      Date result = null;
      if (datePattern != null && datePattern.length() > 0) {
            result = GenericTypeValidator.formatDate(value, datePattern, false);
        } else if (datePatternStrict != null && datePatternStrict.length() > 0) {
            result = GenericTypeValidator.formatDate(value, datePatternStrict, true);
        }

      return result;
   }
}