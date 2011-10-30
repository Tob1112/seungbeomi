package auction.test;

import java.sql.Types;

import org.dbunit.dataset.datatype.DataType;
import org.dbunit.dataset.datatype.DataTypeException;
import org.dbunit.dataset.datatype.DefaultDataTypeFactory;

/**
 * TODO: Direct SQL is lots of fun. This fixes DBUnit with the latest HSQL DB.
 * 
 * http://www.carbonfive.com/community/archives/2005/07/dbunit_hsql_and.html
 */
public class FixDBUnit extends DefaultDataTypeFactory {

	public DataType createDataType(int sqlType, String sqlTypeName)
			throws DataTypeException {
		if (sqlType == Types.BOOLEAN) {
			return DataType.BOOLEAN;
		}
		return super.createDataType(sqlType, sqlTypeName);
	}
}
