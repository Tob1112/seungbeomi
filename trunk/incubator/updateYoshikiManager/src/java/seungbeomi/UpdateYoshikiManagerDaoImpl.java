package seungbeomi;

import org.springframework.jdbc.core.support.JdbcDaoSupport;

public class UpdateYoshikiManagerDaoImpl extends JdbcDaoSupport implements UpdateYoshikiManagerDao{

	private static final String INSERT_SQL = "INSERT INTO YOSHIKI " +
			"(YOSHIKIID, YOSHIKI_FILE_DATA, TETSUZUKI_YUKO_KAISHIBI, VERSION) VALUES (?,?,?,?)";
	private static final String UPDATE_SQL = "";

	@Override
	public void update(DefaultShinseishoYoshiki yoshiki) {
		getJdbcTemplate().update(INSERT_SQL,
				new Object[]{
					yoshiki.getYoshikiId(),
					yoshiki.getYoshikiFileData(),
					yoshiki.getTetsuzukiYukoKaishibi(),
					yoshiki.getVersion()});
	}

	@Override
	public void insert(DefaultShinseishoYoshiki yoshiki) {
		System.out.println("insert method");

	}
}
