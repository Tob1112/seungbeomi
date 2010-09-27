package seungbeomi;

import java.sql.Types;

import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.core.support.SqlLobValue;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobHandler;

public class UpdateYoshikiManagerDaoImpl extends JdbcDaoSupport implements UpdateYoshikiManagerDao {

	private static final String INSERT_SQL = "INSERT INTO YOSHIKI " +
			"(YOSHIKIID, YOSHIKI_FILE_DATA, TETSUZUKI_YUKO_KAISHIBI, VERSION) VALUES (?,?,?,?)";
	private static final String UPDATE_SQL = "UPDATE YOSHIKI SET" +
		"YOSHIKI_ID = ?, " +
		"YOSHIKI_FILE_DATA = ?, " +
		"TETSUZUKI_YUKO_KAISHIBI = ?, " +
		"VERSION = ?" +
		"WHERE YOSHIKI_ID = ?";

	@Override
	public void update(DefaultShinseishoYoshiki yoshiki) {
		getJdbcTemplate().update(UPDATE_SQL, getArgs(yoshiki), getArgType());
	}

	private Object[] getArgs(DefaultShinseishoYoshiki yoshiki) {
		LobHandler lobHandler = new DefaultLobHandler();

		Object[] args = new Object[] {
				yoshiki.getYoshikiId(),
				new SqlLobValue(yoshiki.getYoshikiFileData(), lobHandler),
				yoshiki.getTetsuzukiYukoKaishibi(),
				yoshiki.getVersion(),
				yoshiki.getYoshikiId()
		};

		return args;
	}

	private int[] getArgType() {
		int[] argTypes = new int[] {
				Types.CHAR,
				Types.CLOB,
				Types.DATE,
				Types.NUMERIC,
				Types.CHAR
		};
		return argTypes;
	}
}
