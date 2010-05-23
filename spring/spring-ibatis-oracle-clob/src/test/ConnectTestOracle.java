package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//다중쿼리문을 날리는 Connection Test
public class ConnectTestOracle {
	public static void main(String[] args) {
		try {
			// 1. 드라이브 로딩
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException se) {
			se.printStackTrace();
		}

		PreparedStatement ps = null;
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String id = "scott";
		String pw = "tiger";

		try {
			// 2. connection 얻어오기
			Connection con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB와 연결");

			String drop = "DROP TABLE test ";
			ps = con.prepareStatement(drop);
			ps.execute();
			System.out.println("<<< delete 쿼리실행");

			String create = "CREATE TABLE test(test VARCHAR2(10)) ";
			ps = con.prepareStatement(create);
			ps.execute();
			System.out.println("<<< create 쿼리실행");

			String insert = "insert into test values(?)";
			ps = con.prepareStatement(insert);
			ps.setString(1, "성공");
			ps.executeUpdate();
			System.out.println("<<< insert 쿼리실행");

			String select = "select * from test where test=?";
			ps = con.prepareStatement(select);
			ps.setString(1, "성공");
			ResultSet rs = ps.executeQuery();
			System.out.println("<<< select 쿼리실행");
			while (rs.next()) {
				System.out.println("DB와 연결 ? :" + rs.getString(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
