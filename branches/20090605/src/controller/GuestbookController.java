package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.GuestbookService;

public class GuestbookController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String action = request.getParameter("action");
		GuestbookService gservice = new GuestbookService();
		
		if (action.equals("selectGuestbookList")) {
			System.out.println("selectGuestbookList");
			gservice.selectGuestbookList();
			//select view 
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
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		
		System.out.println(" * goPost");
		
	}
}
