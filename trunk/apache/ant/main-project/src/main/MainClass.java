package main;

import util.Util;
import domain.User;

public class MainClass {
	public static void main(String[] args) {
		User user = new User();
		user.setNo("01");
		user.setPassword("pw");
		user.setName("son");
		System.out.println(user);
		
		Util util = new Util();
		util.getMessage();
	}
}
