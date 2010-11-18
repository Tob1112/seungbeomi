package org.barista.common.test;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;

import javax.sql.DataSource;

import org.dbunit.database.DatabaseConnection;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.database.QueryDataSet;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.excel.XlsDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSet;
import org.dbunit.operation.DatabaseOperation;

public class DBUnitSupport {

	enum DataType {
		EXCEL, XML
	}

	private IDatabaseConnection connection;

	public void setConnection(DataSource dataSource, String schema) {
		try {
			if (connection == null) {
				Connection con = dataSource.getConnection();
				connection = new DatabaseConnection(con);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void insertData(DataSource dataSource, String fileName, DataType type, DatabaseOperation op) {
		try {
			InputStream in = new FileInputStream(fileName);
			IDataSet dataSet = null;
			if (type == DataType.EXCEL) {
				dataSet = new XlsDataSet(in);
			} else if (type == DataType.XML) {
				dataSet = new FlatXmlDataSet(in);
			}
			op.execute(connection, dataSet);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void exportData(DataSource dataSource, String[] tableNames, String fileName, DataType type) {
		try {
			QueryDataSet dataSet = new QueryDataSet(connection);
			FileOutputStream out = new FileOutputStream(fileName);

			for (String tableName : tableNames) {
				dataSet.addTable(tableName);
			}

			if (type == DataType.EXCEL) {
				XlsDataSet.write(dataSet, out);
			} else if (type == DataType.XML) {
				FlatXmlDataSet.write(dataSet, out);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void exportData(DataSource dataSource, String fileName, DataType type) {
		try {
			IDataSet dataSet = connection.createDataSet();
			FileOutputStream out = new FileOutputStream(fileName);

			if (type == DataType.EXCEL) {
				XlsDataSet.write(dataSet, out);
			} else if (type == DataType.XML) {
				FlatXmlDataSet.write(dataSet, out);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void cleanInsertXmlData(DataSource dataSource, String file) {
		insertData(dataSource, file, DataType.XML, DatabaseOperation.CLEAN_INSERT);
	}
	protected void cleanInsertXlsData(DataSource dataSource, String file) {
		insertData(dataSource, file, DataType.EXCEL, DatabaseOperation.CLEAN_INSERT);
	}
	protected void insertXmlData(DataSource dataSource, String file) {
		insertData(dataSource, file, DataType.XML, DatabaseOperation.INSERT);
	}
	protected void insertXlsData(DataSource dataSource, String file) {
		insertData(dataSource, file, DataType.EXCEL, DatabaseOperation.INSERT);
	}
	protected void exportXmlData(DataSource dataSource, String[] tableNames, String file) {
		exportData(dataSource, tableNames, file, DataType.XML);
	}
	protected void exportXlsData(DataSource dataSource, String[] tableNames, String file) {
		exportData(dataSource, tableNames, file, DataType.EXCEL);
	}
	protected void exportXmlData(DataSource dataSource, String file) {
		exportData(dataSource, file, DataType.XML);
	}
	protected void exportXlsData(DataSource dataSource, String file) {
		exportData(dataSource, file, DataType.EXCEL);
	}
}
