package test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.dbunit.database.DatabaseConnection;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.database.QueryDataSet;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.excel.XlsDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSet;
import org.dbunit.operation.DatabaseOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

@ContextConfiguration(locations = {"test-applicationContext.xml"})
public class DBTestBase {
	enum DataType {EXCEL, FLATXML}

	private DataSource dataSource;
	private File file;
	Connection con;

	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	protected void backup(String backTableName) throws SQLException {
		IDatabaseConnection connection = null;
		try {
			con = dataSource.getConnection();
			connection = new DatabaseConnection(con);

			QueryDataSet partialDataSet = new QueryDataSet(connection);
			partialDataSet.addTable(backTableName);

			file = File.createTempFile(backTableName, ".xml");

			FlatXmlDataSet.write(partialDataSet, new FileOutputStream(file));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (connection != null)
				connection.close();
		}
	}

	protected void recovery() throws SQLException {
		IDatabaseConnection connection = null;
		try {
			con = dataSource.getConnection();
			connection = new DatabaseConnection(con);

			IDataSet dataSet = new FlatXmlDataSet(file);
			DatabaseOperation.CLEAN_INSERT.execute(connection, dataSet);

			file.delete(); // delete backup file
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (connection != null)
				connection.close();
		}
	}

	protected void cleanInsertFlatXmlData(String fileSource) throws Exception {
		insertData(fileSource, DataType.FLATXML, DatabaseOperation.CLEAN_INSERT);
	}

	protected void cleanInsertXlsData(String fileSource) throws Exception {
		insertData(fileSource, DataType.EXCEL, DatabaseOperation.CLEAN_INSERT);
	}

	protected void insertFlatXmlData(String fileSource) throws Exception {
		insertData(fileSource, DataType.FLATXML, DatabaseOperation.INSERT);
	}

	protected void insertXlsData(String fileSource) throws Exception {
		insertData(fileSource, DataType.EXCEL, DatabaseOperation.INSERT);
	}

	private void insertData(String fileSource, DataType type, DatabaseOperation operation) throws Exception {

        IDataSet dataset = null;
        if (type == DataType.EXCEL) {
            dataset = new XlsDataSet(new FileInputStream(fileSource));
        }
        else if (type == DataType.FLATXML) {
            dataset = new FlatXmlDataSet(new FileInputStream(fileSource));
        }

        con = dataSource.getConnection();
        operation.execute(new DatabaseConnection(con), dataset);
    }
}