package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//������������ ������ Connection Test
public class ConnectTestOracle {
	public static void main(String[] args) {
		try {
			// 1. ����̺� �ε�
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException se) {
			se.printStackTrace();
		}

		PreparedStatement ps = null;
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String id = "scott";
		String pw = "tiger";

		try {
			// 2. connection ������
			Connection con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB�� ����");

			String drop = "DROP TABLE test ";
			ps = con.prepareStatement(drop);
			ps.execute();
			System.out.println("<<< delete ��������");

			String create = "CREATE TABLE test(test VARCHAR2(10)) ";
			ps = con.prepareStatement(create);
			ps.execute();
			System.out.println("<<< create ��������");

			String insert = "insert into test values(?)";
			ps = con.prepareStatement(insert);
			ps.setString(1, "����");
			ps.executeUpdate();
			System.out.println("<<< insert ��������");

			String select = "select * from test where test=?";
			ps = con.prepareStatement(select);
			ps.setString(1, "����");
			ResultSet rs = ps.executeQuery();
			System.out.println("<<< select ��������");
			while (rs.next()) {
				System.out.println("DB�� ���� ? :" + rs.getString(1));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
