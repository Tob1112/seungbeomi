package business;

import java.sql.SQLException;
import java.util.List;

import persistence.GuestbookDAO;

public class GuestbookService {

	public List selectGuestbookList() throws SQLException {
		GuestbookDAO gDAO = new GuestbookDAO();
		return gDAO.selectGuestbookList();
	}

}
