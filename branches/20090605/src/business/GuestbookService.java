package business;

import java.util.List;

import persistence.GuestbookDAO;

public class GuestbookService {

	public List selectGuestbookList() {
		GuestbookDAO gDAO = new GuestbookDAO();
		return gDAO.selectGuestbookList();
	}

}
