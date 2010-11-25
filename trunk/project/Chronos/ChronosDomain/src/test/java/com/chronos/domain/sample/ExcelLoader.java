package com.chronos.domain.sample;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.barista.exception.BaristaRuntimeException;

/**
 * Excel파일은 열어, 시트에 기입되어있는 데이타를 로드하는 유틸리티클래스.
 * <p>시트를 기입할때의 주의점은 아래와 같다.</p>
 * <ui>
 * 	<li>셀의 서식설정은 모두 "문자"로 한다.</li>
 * 	<li>첫번째행은 테이블명을 기입한다.</li>
 * 	<li>두번째행은 데이터타입을 기입한다.</li>
 * 	<li>세번째행부터는 데이터을 기입한다.</li>
 * </ui>
 * @author seungbeomi
 *
 */
public class ExcelLoader {
	private static final int CELL_TYPE_NUMERIC = 0;

	private Connection connection;

	public ExcelLoader(Connection connection) {
		this.connection = connection;
	}

	/**
	 * 지정된 워크북을 열어 지정된 시트명의 테이터를 지정된 테이블에 로드한다.
	 * @param tableName
	 * @param workbookPath
	 * @param sheetName
	 */
	public void load(String tableName, String workbookPath, String sheetName) {
		String sql;
		List<String> columnNames;
		List<String> types;
		List<Map<String, String>> data;
		HSSFSheet sheet;

		sheet = this.getSheet(workbookPath, sheetName);

		columnNames = this.loadColumnNames(sheet);
		types = this.loadTypes(sheet);
		data = this.loadData(sheet, columnNames);

		sql = this.createSql(tableName, columnNames, types);

		for (int i=0; i < data.size(); i++) {
			this.insert(sql, columnNames, types, data.get(i));
		}
	}

	public void unload(String tableName) {
		this.delete(tableName);
	}

	// ===================================================================
	// Private methods
	// ===================================================================

	/**
	 * 지정된 워크북으로부터 지정된 시트명을 가지는 시트를 얻는다.
	 * @param workbookPath 워크북패스
	 * @param sheetName 시트명
	 * @return 시트
	 */
	private HSSFSheet getSheet(String workbookPath, String sheetName) {
		InputStream is;
		HSSFWorkbook workbook;
		HSSFSheet sheet;

		workbook = null;

		try {
			is = new FileInputStream(new File(workbookPath));
			workbook = new HSSFWorkbook(new POIFSFileSystem(is));
			is.close();
		} catch (FileNotFoundException e) {
			System.out.println("워크북이 존재하지 않습니다.: workbookPath=<" + workbookPath + ">");
			System.exit(0);
		} catch (IOException e) {
			System.out.println("워크북을 읽는중 실폐했습니다.: workbookPath=<" + workbookPath + ">");
			System.out.println(e);
			System.exit(0);
		}

		sheet = workbook.getSheet(sheetName);
		if (sheet == null) {
			System.out.println("시트를 찾지 못했습니다.: sheetName=<" + sheetName + ">");
			System.exit(0);
		}
		return sheet;
	}

	/**
	 * 지정된 시트로부터 컬럼명을 로드한다.
	 * @param sheet 시트
	 * @return 컬럼명리스
	 */
	private List<String> loadColumnNames(HSSFSheet sheet) {
		String cellValue;
		int current;
		List<String> columnNames;
		HSSFCell cell;

		current = 0;
		columnNames = new ArrayList<String>();

		while (true) {
			cell = sheet.getRow(0).getCell(current);

			if (cell == null) {
				break;
			}

			cellValue = this.readCellValueAsString(sheet.getRow(0).getCell(current), false);
			columnNames.add(cellValue);
			current++;
		}

		return columnNames;
	}

	/**
	 * 지정된 시트로부터 데이터타입을 로드한다.
	 * @param sheet 시트
	 * @return
	 */
	private List<String> loadTypes(HSSFSheet sheet) {
		String cellValue;
		int current;
		List<String> types;
		HSSFCell cell;

		current = 0;
		types = new ArrayList<String>();

		while (true) {
			cell = sheet.getRow(1).getCell(current);
			if (cell == null) {
				break;
			}
			cellValue = this.readCellValueAsString(sheet.getRow(1).getCell(current), false);
			types.add(cellValue);
			current++;
		}

		return types;
	}

	/**
	 * 지정된 시트로부터 데이타를 로드한다.
	 * @param sheet 시트
	 * @param columnNames 헤더의 리스트
	 * @return 로드된 리스트
	 */
	private List<Map<String, String>> loadData(HSSFSheet sheet, List<String> headers) {
		String cellValue;
		int current;
		Map<String, String> line;
		List<Map<String, String>> loadeds;
		HSSFCell cell;

		current = 2;
		loadeds = new ArrayList<Map<String,String>>();

		while (true) {
			if (sheet.getRow(current) == null) {
				break;
			}
			line = new HashMap<String, String>();

			for (int i=0; i < headers.size(); i++) {
				cell = sheet.getRow(current).getCell(i);
				if (cell != null) {
					cellValue = this.readCellValueAsString(cell, false);
					line.put(headers.get(i), cellValue);
				}
			}

			loadeds.add(line);
			current++;
		}
		return loadeds;
	}

	/**
	 * 테이블명, 컬럼명, 데이터타입리스트를 이용해 INSERT 쿼리를 생성한다.
	 * @param tableName 테이블명
	 * @param columnNames 컬럼명
	 * @param types 데이터타입리스트
	 * @return 생성된 INSERT쿼리문
	 */
	private String createSql(String tableName, List<String> columnNames, List<String> types) {
		StringBuffer sb;
		String sql;
		String type;

		sb = new StringBuffer();
		sb.append("INSERT INTO " + tableName + " VALUES (");

		for (int i=0; i < columnNames.size(); i++) {
			type = types.get(i);

			if (type.equals("Date")) {
				sb.append("TO_DATE(?, 'YYYYMMDDHH24MISS', 'NLS_DATE_LANGUAGE=AMERICAN')");
			} else if (type.equals("Timestamp")) {
				sb.append("TO_TIMESTAMP(?, 'YYYYMMDDHH24MISSFF3', 'NLS_DATE_LANGUAGE=AMERICAN')");
			} else if (type.equals("Blob")) {
				sb.append("EMPTY_BLOB()");
			} else if (type.equals("Clob")) {
				sb.append("EMPTY_CLOB()");
			} else {
				sb.append("?");
			}
			if (i < columnNames.size() - 1) {
				sb.append(", ");
			}
		}

		sb.append(")");
		sql = sb.toString();
		return sql;
	}

	/**
	 *
	 * @param sql
	 * @param columnNames
	 * @param types
	 * @param map
	 */
	private void insert(String sql, List<String> columnNames, List<String> types, Map<String, String> data) {
		String columnName;
		String type;
		int numberOfSet;
		PreparedStatement stmt;

		try {
			stmt = this.connection.prepareStatement(sql);

			numberOfSet = 0;
			for (int i=0; i < types.size(); i++) {
				columnName = columnNames.get(i);
				type = types.get(i);

				if (type.equals("String")) {
					stmt.setString(numberOfSet + 1, data.get(columnName));
					numberOfSet++;
				} else if (type.equals("int")) {
					stmt.setInt(numberOfSet + 1, (int) Double.parseDouble(data.get(columnName)));
					numberOfSet++;
				} else if (type.equals("long")) {
					stmt.setLong(numberOfSet + 1, Long.parseLong(data.get(columnName)));
					numberOfSet++;
				} else if (type.equals("Date")) {
					stmt.setString(numberOfSet + 1, data.get(columnName));
					numberOfSet++;
				} else if (type.equals("Timestamp")) {
					stmt.setString(numberOfSet + 1, data.get(columnName));
					numberOfSet++;
				} else if (!type.equals("Blob") && !type.equals("Clob")) {
					throw new BaristaRuntimeException("잘못된 데이터타입입니다.:" + type);
				}
			}
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BaristaRuntimeException("SQL Exception: " + e);
		}
	}

	/**
	 * @param tableName
	 */
	private void delete(String tableName) {
		PreparedStatement stmt;
		try {
			stmt = this.connection.prepareStatement("DELETE FROM " + tableName);
			stmt.execute();
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BaristaRuntimeException("SQL Exception: " + e);
		}

	}

	/**
	 * 지정된 셀의 값을 얻는다.
	 * @param cell 셀
	 * @param readAsNumberFormat 숫자포맷으로 얻는다
	 * @return 셀의 값
	 */
	private String readCellValueAsString(HSSFCell cell, boolean readAsNumberFormat) {
		String read;
		int cellType;
		int indexOfPeriod;

		cellType = cell.getCellType();
		if (cellType == CELL_TYPE_NUMERIC) {
			read = Double.toString(cell.getNumericCellValue());
			if (readAsNumberFormat) {
				if ((indexOfPeriod = read.indexOf(".")) >= 0) {
					read = read.substring(0, indexOfPeriod);
				}
				if (read.equals("")) {
					read = "0";
				}
			}
		} else {
			read = cell.getStringCellValue();
		}
		return read;
	}
}
