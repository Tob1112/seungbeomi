package seungbeomi;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.core.support.SqlLobValue;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobHandler;

public class UpdateYoshikiManagerDaoImpl extends JdbcDaoSupport implements UpdateYoshikiManagerDao {

	private static final String UPDATE_SQL = "UPDATE YOSHIKI SET " +
		"YOSHIKI_ID = ?, " +
		"YOSHIKI_FILE_DATA = ?, " +
		"TETSUZUKI_YOSHIKI_KAISHIBI = ?, " +
		"VERSION = ? " +
		"WHERE YOSHIKI_ID = ?";

	@Override
	public void update(DefaultShinseishoYoshiki yoshiki) {
		getJdbcTemplate().update(UPDATE_SQL, getArgs(yoshiki), getArgType());
		System.out.println("updated " + yoshiki.getYoshikiId());
	}

	private Object[] getArgs(DefaultShinseishoYoshiki yoshiki) {
		//LobHandler lobHandler = new DefaultLobHandler();

		Object[] args = new Object[] {
				yoshiki.getYoshikiId(),
				yoshiki.getYoshikiFileData(),	//new SqlLobValue(yoshiki.getYoshikiFileData(), lobHandler),
				yoshiki.getTetsuzukiYukoKaishibi(),
				yoshiki.getVersion(),
				yoshiki.getYoshikiId()
		};

		return args;
	}

	private int[] getArgType() {
		int[] argTypes = new int[] {
				Types.VARCHAR,
				Types.VARCHAR, //Types.CLOB,
				Types.DATE,
				Types.NUMERIC,
				Types.VARCHAR
		};
		return argTypes;
	}

	//---------------------------------------------------------------------

	@Override
	public void updateBatch(final List<DefaultShinseishoYoshiki> yoshikiList) {
		getJdbcTemplate().batchUpdate(
				UPDATE_SQL,
				new BatchPreparedStatementSetter() {

					@Override
					public void setValues(PreparedStatement ps, int i) throws SQLException {
						DefaultShinseishoYoshiki yoshiki = yoshikiList.get(i);
						ps.setString(1, yoshiki.getYoshikiId());
						ps.setString(2, yoshiki.getYoshikiFileData());
						ps.setDate(3, new java.sql.Date(yoshiki.getTetsuzukiYukoKaishibi().getTime()));
						ps.setInt(4, yoshiki.getVersion());
						ps.setString(5, yoshiki.getYoshikiId());
					}

					@Override
					public int getBatchSize() {
						return yoshikiList.size();
					}
				});

	}
}
