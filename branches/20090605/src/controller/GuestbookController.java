package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Guestbook;

import business.GuestbookService;

public class GuestbookController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
		throws IOException{
		
		String action = request.getParameter("action");
		GuestbookService gservice = new GuestbookService();
		String view = null;
		System.out.println(" * action = " + action);
		if (action.equals("selectGuestbookList")) {
			System.out.println("selectGuestbookList");
			List<Guestbook> model = null;
			try {
				model = gservice.selectGuestbookList();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			request.setAttribute("model", model);
			view = "./guestbook/guestbookList.jsp";
		} else if (action.equals("insertGuestbook")) {
			System.out.println("insertGuestbook");
		} else if (action.equals("selectGuestbookById")) {
			System.out.println("selectGuestbookById");
		} else if (action.equals("updateGuestbook")) {
			System.out.println("updateGuestbook");
		} else if (action.equals("deleteGuestbook")) {
			System.out.println("deleteGuestbook");
		} else {
			System.out.println("illigalAction");
		}		
		response.sendRedirect(view);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		
		System.out.println(" * goPost");
		
	}
}
